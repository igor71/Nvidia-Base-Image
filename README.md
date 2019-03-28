# Nvidia-Base-Image
Basic Nvidia Image for building tensorflow enabled docker image

This image used as base image for creating images based on tensorflow 1.10.1

```
CUDA Version   -->> 9.0.176

CUDNN Version  -->> 7.4.1.5
```
Load & Run docker image:

```
pv /media/common/DOCKER_IMAGES/Nvidia/BasicImages/nvidia-cuda-10.0-cudnn7-base.tar | docker load

docker tag 7bfeb6c8d6fb nvidia/cuda:10.0-cudnn7-base

docker run --runtime=nvidia -it --name tflow_build -v /media:/media nvidia/cuda:10.0-cudnn7-base
```
