# Nvidia-Base-Image
Basic Nvidia Image for building tensorflow/pytorch/cafee enabled docker image without installed NCCL libraries.

This image used as base image for creating images based on tensorflow version 2.0 and above

```
Ubuntu Server 16.04

docker inspect -f '{{index .Config.Labels "com.nvidia.cuda.version"}}' 9e1be3b3d9ff

CUDA Version   -->> 10.0.130

docker inspect -f '{{index .Config.Labels "com.nvidia.cudnn.version"}}' 9e1be3b3d9ff

CUDNN Version  -->> 7.6.2.24

```

Load & Run docker image:

```
pv /media/common/DOCKER_IMAGES/Nvidia/BasicImages/nvidia-cuda-10.0-cudnn7-base-nonccl-ubuntu16.04.tar | docker load

docker tag 9e1be3b3d9ff nvidia/cuda:10.0-cudnn7-base

docker run --runtime=nvidia -it --name tflow_build -v /media:/media nvidia/cuda:10.0-cudnn7-base
```
