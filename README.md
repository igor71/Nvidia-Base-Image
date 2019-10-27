# Nvidia-Base-Image
Basic Nvidia Image for building tensorflow enabled docker image

This image used as base image for creating images based on tensorflow version 2.0 and above

```
Ubuntu Server 16.04

CUDA Version   -->> 10.0.130

CUDNN Version  -->> 7.6.2.24

```

Load & Run docker image:

```
pv /media/common/DOCKER_IMAGES/Nvidia/BasicImages/nvidia-cuda-10.0-cudnn7-base-nonccl-ubuntu16.04.tar | docker load

docker tag c9543dfc5cd3 nvidia/cuda:10.0-cudnn7-base

docker run --runtime=nvidia -it --name tflow_build -v /media:/media nvidia/cuda:10.0-cudnn7-base
```
