# Nvidia Base Image For Horovod Dockers

Basic Nvidia Image for building horovod with tensorflow docker image

This image used as base image for creating images based on tensorflow version 1.13.1 and above

```
Ubuntu Server 18.04

CUDA Version   -->> 10.0.130

docker inspect -f '{{index .Config.Labels "com.nvidia.cuda.version"}}' efd0a8ea6627

CUDNN Version  -->> 7.6.0.64

docker inspect -f '{{index .Config.Labels "com.nvidia.cudnn.version"}}' efd0a8ea6627

NCCL Version   -->> 2.4.2

docker inspect -f '{{index .Config.Labels "com.nvidia.nccl.version"}}' efd0a8ea6627

```

Load & Run docker image:

```
pv /media/common/DOCKER_IMAGES/Nvidia/BasicImages/nvidia-cuda-10.0-cudnn7-base-horovod.tar | docker load

docker tag 2a9e5a41bb75 nvidia/cuda:10.0-cudnn7-base-horovod

nvidia-docker run --name horovod-base -v /media:/media nvidia/cuda:10.0-cudnn7-base-horovod

docker run --runtime=nvidia -it --name horovod-base -v /media:/media nvidia/cuda:9.0-cudnn7-base-horovod -->> docker ver. 2.0

nvidia-docker run -it --name horovod-base -v /media:/media nvidia/cuda:9.0-cudnn7-base-horovod -->> docker ver.1.1

```
