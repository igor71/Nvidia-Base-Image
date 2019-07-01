# Nvidia Base Image For Horovod Dockers

Basic Nvidia Image for building horovod with tensorflow docker image

This image used as base image for creating images based on tensorflow version 1.13.1 and above

```
Ubuntu Server 16.04

CUDA Version   -->> 9.0.176

docker inspect -f '{{index .Config.Labels "com.nvidia.cuda.version"}}' e3f90c878960

CUDNN Version  -->> 7.6.0.64

docker inspect -f '{{index .Config.Labels "com.nvidia.cudnn.version"}}' e3f90c878960

NCCL Version   -->> 2.3.7

docker inspect -f '{{index .Config.Labels "com.nvidia.nccl.version"}}' e3f90c878960

```

Load & Run docker image:

```
pv /media/common/DOCKER_IMAGES/Nvidia/BasicImages/nvidia-cuda-9.0-cudnn7-base-horovod.tar | docker load

docker tag 2a9e5a41bb75 nvidia/cuda:9.0-cudnn7-base-horovod

nvidia-docker run --name horovod-base -v /media:/media nvidia/cuda:9.0-cudnn7-base-horovod

docker run --runtime=nvidia -it --name horovod-base -v /media:/media nvidia/cuda:9.0-cudnn7-base-horovod

```
