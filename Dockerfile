FROM nvidia/cuda:10.0-cudnn7-devel

#get deps
RUN apt-get update && \
DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
python3-dev python3-pip python3-setuptools git g++ wget make libprotobuf-dev protobuf-compiler libopencv-dev \
libgoogle-glog-dev libboost-all-dev libcaffe-cuda-dev libhdf5-dev libatlas-base-dev

#for python api
RUN pip3 install numpy scipy matplotlib ipython jupyter pandas sympy nose opencv-python 

#replace cmake as old version has CUDA variable bugs
RUN wget https://github.com/Kitware/CMake/releases/download/v3.14.2/cmake-3.14.2-Linux-x86_64.tar.gz && \
tar xzf cmake-3.14.2-Linux-x86_64.tar.gz -C /opt && \
rm cmake-3.14.2-Linux-x86_64.tar.gz
ENV PATH="/opt/cmake-3.14.2-Linux-x86_64/bin:${PATH}"

#get openpose
WORKDIR /openpose
RUN git clone https://github.com/CMU-Perceptual-Computing-Lab/openpose.git .

RUN git submodule update --init --recursive --remote

RUN sed -i -e 's/30 35 50 52 60 61/30 35 50 52 60 61 75/g' 3rdparty/caffe/cmake/Cuda.cmake

#build it
WORKDIR /openpose/build
RUN cmake -DBUILD_PYTHON=ON .. && make -j8
WORKDIR /openpose

RUN apt-get update

#commands to configure openpose

#move the pyopenpose python library into the python3 package folder so it can be imported.
RUN cp /openpose/build/python/openpose/pyopenpose.cpython-36m-x86_64-linux-gnu.so /usr/local/lib/python3.6/dist-packages/

#download default openpose model weights
RUN chmod +x /openpose/models/getModels.sh
RUN /openpose/models/getModels.sh

#make the directory where external files will be mounted
WORKDIR /external

# Add Tini. Tini operates as a process subreaper for jupyter. This prevents
# kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini
ENTRYPOINT ["/usr/bin/tini", "--"]

EXPOSE 8888
CMD ["jupyter", "notebook", "--port=8888", "--no-browser", "--ip=0.0.0.0", "--allow-root", "--NotebookApp.token=''", "--NotebookApp.password=''"]

	
