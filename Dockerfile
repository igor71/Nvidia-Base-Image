FROM nvidia/cuda:9.0-base-ubuntu16.04

MAINTAINER Igor Rabkin <igor.rabkin@xiaoyi.com>

###########################################
#     CUDA, CUDNN & Dependences           #
###########################################

ENV CUDNN_VERSION 7.0.5.15
LABEL com.nvidia.cudnn.version="${CUDNN_VERSION}"

RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-command-line-tools-9-0 \
    cuda-cublas-dev-9-0 \
    cuda-cudart-dev-9-0 \
    cuda-cufft-dev-9-0 \
    cuda-curand-dev-9-0 \
    cuda-cusolver-dev-9-0 \
    cuda-cusparse-dev-9-0 \
    libcudnn7=$CUDNN_VERSION-1+cuda9.0 \
    libcudnn7-dev=$CUDNN_VERSION-1+cuda9.0 \
    libcurl3-dev \
    libfreetype6-dev \
    libhdf5-serial-dev \
    libpng12-dev \
    libzmq3-dev  && \
    find /usr/local/cuda-9.0/lib64/ -type f -name 'lib*_static.a' -not -name 'libcudart_static.a' -delete && \
    rm /usr/lib/x86_64-linux-gnu/libcudnn_static_v7.a 
    

###################################################################
#                          NCCL Installation                      #
###################################################################

RUN apt-get install -y --no-install-recommends \
    libnccl2=2.2.13-1+cuda9.0 \
    libnccl-dev=2.2.13-1+cuda9.0 && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

###################################################################
# Link NCCL libray and header where the build script expects them #
###################################################################

RUN mkdir /usr/local/cuda-9.0/lib &&  \
    ln -s /usr/lib/x86_64-linux-gnu/libnccl.so.2 /usr/local/cuda/lib/libnccl.so.2 && \
    ln -s /usr/include/nccl.h /usr/local/cuda/include/nccl.h
    
# TODO: Remove after license is excluded from BUILD file.
RUN gunzip /usr/share/doc/libnccl2/NCCL-SLA.txt.gz && \
    cp /usr/share/doc/libnccl2/NCCL-SLA.txt /usr/local/cuda/
