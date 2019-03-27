FROM ubuntu:18.04

LABEL maintainer "NVIDIA CORPORATION <cudatools@nvidia.com>"

###########################################
#           Install Basic Staff           #
###########################################

RUN apt-get update && apt-get install -y --no-install-recommends gnupg2 curl ca-certificates && \
    curl -fsSL https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub | apt-key add - && \
    echo "deb https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/cuda.list && \
    echo "deb https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64 /" > /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-get purge --autoremove -y curl && \
    rm -rf /var/lib/apt/lists/*

ENV CUDA_VERSION 10.1.105
ENV CUDA_PKG_VERSION 10-1=$CUDA_VERSION-1
ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
ENV LD_LIBRARY_PATH /usr/local/nvidia/lib:/usr/local/nvidia/lib64

# For libraries in the cuda-compat-* package: https://docs.nvidia.com/cuda/eula/index.html#attachment-a
RUN apt-get update && apt-get install -y --no-install-recommends \
        cuda-cudart-$CUDA_PKG_VERSION \
        cuda-compat-10-1=418.39-1 && \
    ln -s cuda-10.1 /usr/local/cuda && \
    rm -rf /var/lib/apt/lists/*

# Required for nvidia-docker v1
RUN echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf

# nvidia-container-runtime
ENV NVIDIA_VISIBLE_DEVICES all
ENV NVIDIA_DRIVER_CAPABILITIES compute,utility
ENV NVIDIA_REQUIRE_CUDA "cuda>=10.1"

###########################################
#     CUDA, CUDNN & Dependences           #
###########################################

ENV CUDNN_VERSION 7.5.0.56
ARG CUDA_VERSION=10.1
ARG LIB_DIR_PREFIX=x86_64
ARG ARCH=

RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-command-line-tools-${CUDA_VERSION} \
    cuda-cublas-dev-${CUDA_VERSION} \
    cuda-cudart-dev-${CUDA_VERSION} \
    cuda-cufft-dev-${CUDA_VERSION} \
    cuda-curand-dev-${CUDA_VERSION} \
    cuda-cusolver-dev-${CUDA_VERSION} \
    cuda-cusparse-dev-${CUDA_VERSION} \
    libcudnn7=$CUDNN_VERSION-1+cuda${CUDA_VERSION} \
    libcudnn7-dev=$CUDNN_VERSION-1+cuda${CUDA_VERSION} \
    libcurl3-dev \
    libfreetype6-dev \
    libhdf5-serial-dev \
    libzmq3-dev \
    zlib1g-dev \
    pkg-config && \
    find /usr/local/cuda-9.0/lib64/ -type f -name 'lib*_static.a' -not -name 'libcudart_static.a' -delete && \
    rm /usr/lib/${LIB_DIR_PREFIX}-linux-gnu/libcudnn_static_v7.a 
    

RUN [[ "${ARCH}" = "ppc64le" ]] || { apt-get update && \
        apt-get install nvinfer-runtime-trt-repo-ubuntu1604-5.0.2-ga-cuda${CUDA} \
        && apt-get update \
        && apt-get install -y --no-install-recommends \
            libnvinfer5=5.0.2-1+cuda${CUDA_VERSION} \
            libnvinfer-dev=5.0.2-1+cuda${CUDA_VERSION} \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/*; }
