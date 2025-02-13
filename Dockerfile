FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04

ENV PYTHONUNBUFFERED=1 

# SYSTEM
RUN apt-get update --yes --quiet && DEBIAN_FRONTEND=noninteractive apt-get install --yes --quiet --no-install-recommends \
    software-properties-common \
    build-essential apt-utils \
    wget curl vim git ca-certificates kmod \
    nvidia-driver-525 \
 && rm -rf /var/lib/apt/lists/*

# PYTHON 3.10
RUN add-apt-repository --yes ppa:deadsnakes/ppa && apt-get update --yes --quiet
RUN DEBIAN_FRONTEND=noninteractive apt-get install --yes --quiet --no-install-recommends \
    python3.10 \
    python3.10-dev \
    python3.10-distutils \
    python3.10-lib2to3 \
    python3.10-gdbm \
    python3.10-tk \
    pip \
    cmake

RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 999 \ 
    && update-alternatives --config python3 && ln -s /usr/bin/python3 /usr/bin/python

RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10

RUN pip install --upgrade pip

RUN pip install jittor \ 
    cupy-cuda11x \
    plyfile \
    opencv-python
