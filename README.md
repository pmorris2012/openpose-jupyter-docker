# openpose-jupyter-docker
Dockerfile repository for a docker image which opens a jupyter notebook server, configured to preprocess image/video data using OpenPose.

Pull from dockerhub at https://hub.docker.com/r/pmorris2012/openpose-jupyter

Steps to use:
1. Install a version of the NVIDIA graphics driver compatible with CUDA 10.0+
2. Install nvidia-docker


## DOWNLOAD AND RUN CONTAINER

replace [PORT] and [PATH] before running, then go to ```localhost:[PORT]``` in your browser to access the notebook server.
```
docker run --gpus all -it -p [PORT]:8888 -v [PATH]:/external pmorris2012/openpose-jupyter
```

## SETUP ON UBUNTU

1. Install Nvidia graphics driver from the `ppa:graphics-drivers/ppa` repository.
```
sudo add-apt-repository ppa:graphics-drivers/ppa
sudo apt update
ubuntu-drivers devices
sudo apt install nvidia-[VERSION]
```

2. Install docker CE using the instructions here

https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-engine---community-1

3. (Optional) Run docker with without needing root access (don't have to type sudo)
```
sudo groupadd docker
sudo gpasswd -a [USER] docker
newgrp docker
```

4. Install the nvidia-docker runtime, and follow the instructions for use here

https://github.com/NVIDIA/nvidia-docker


