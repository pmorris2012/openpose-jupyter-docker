# openpose-jupyter-docker
Dockerfile repository for a docker image which opens a jupyter notebook server, configured to preprocess image/video data using OpenPose.

Pull from dockerhub at https://hub.docker.com/r/pmorris2012/openpose-jupyter


## DOWNLOAD AND RUN CONTAINER

- [PORT]: the port the jupyter notebook server will be accessible on outside the container.
- [PATH]: The local path where your data/code is stored.
```
docker run --gpus all -it -p [PORT]:8888 -v [PATH]:/external pmorris2012/openpose-jupyter
```
Go to ```localhost:[PORT]``` in your browser to access the notebook server.

## DOCKER SETUP ON UBUNTU

1. Install Nvidia graphics driver from the `ppa:graphics-drivers/ppa` repository. Reboot after this step.
- [VERSION]: the version of the nvidia driver you want to install.
```
sudo apt-get purge nvidia*
sudo add-apt-repository ppa:graphics-drivers
sudo apt-get update
ubuntu-drivers devices
sudo apt install nvidia-[VERSION]
```

2. Install docker CE using the instructions here

https://docs.docker.com/install/linux/docker-ce/ubuntu/#install-docker-engine---community-1

3. (Optional) Run docker with without needing root access (don't have to type sudo)
- [USER]: your username
```
sudo groupadd docker
sudo gpasswd -a [USER] docker
newgrp docker
```

4. Install the nvidia-docker runtime, and follow the instructions for use here

https://github.com/NVIDIA/nvidia-docker


