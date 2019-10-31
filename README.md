# Nvidia-Base-Image
Basic Nvidia Image for building tensorflow enabled docker image

This image used as base image for creating images based on ubuntu 18 and Cuda 9.0

```
Ubuntu Server 18.04

CUDA Version   -->> 9.0.176

CUDNN Version  -->> 7.6.2.24

```

Load & Run docker image:

```
pv /media/common/DOCKER_IMAGES/Nvidia/BasicImages/nvidia-cuda-10.0-cudnn7-base-nonccl-ubuntu18.04.tar | docker load

docker tag c9543dfc5cd3 nvidia/cuda:10.0-cudnn7-base

docker run --runtime=nvidia -it --name tflow_build -v /media:/media nvidia/cuda:10.0-cudnn7-base
```
