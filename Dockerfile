FROM nvidia/cuda:11.6.1-base-ubuntu20.04

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
    wget \
    bzip2 \
    git \
    vim \
    screen \
    htop \
    iputils-ping \
    openssh-server \
    iputils-ping \
    build-essential \
    ca-certificates \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    libstdc++6 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-Linux-x86_64.sh -O ~/mambaforge.sh && \
  bash ~/mambaforge.sh -b -p /opt/conda && \
  rm ~/mambaforge.sh && \
  /opt/conda/bin/conda init

ENV PATH=/opt/conda/bin:$PATH

ADD environment.yml /tmp/environment.yml
RUN mamba env update -n base -f /tmp/environment.yml && \
    mamba clean --all --yes && \
    rm -rf /tmp/environment.yml

# COMMAND: docker build -t mschossler/cuda116jupyterssh . && docker push mschossler/cuda116jupyterssh
# MANIFEST DIGEST: sha256:637f9e168a1a39328fe5ceb7afcbfc7e3f0eef4759d114450b1ad5c0bddee922
