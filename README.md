# Nvidia-Base-Image
Basic Nvidia Image for building tensorflow enabled docker image

This image used as base image for creating images based on tensorflow version 2.0 and above

```
Ubuntu Server 16.04

CUDA Version   -->> 10.1.130

CUDNN Version  -->> 7.4.1.5

```

Load & Run docker image:

```
pv /media/common/DOCKER_IMAGES/Nvidia/BasicImages/nvidia-cuda-10.0-cudnn7-base-ubuntu16.04.tar | docker load

docker tag 2a9e5a41bb75 nvidia/cuda:10.0-cudnn7-base

docker run --runtime=nvidia -it --name tflow_build -v /media:/media nvidia/cuda:10.0-cudnn7-base
```
