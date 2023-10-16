# FROM nvidia/cuda:11.8.0-devel-ubuntu22.04
FROM huggingface/transformers-pytorch-gpu:latest

# ARG DEBIAN_FRONTEND=noninteractive
# ENV CUDA_HOME="/usr/local/cuda-11.8"
# ENV LD_LIBRARY_PATH="/usr/local/cuda-11.8/lib64"
RUN echo 'export CUDA_HOME=/usr/local/cuda-11.8' >> ~/.bashrc
RUN echo 'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-11.8/targets/x86_64-linux/lib:/usr/local/cuda-11.8/targets/x86_64-linux/lib/stubs:/usr/local/cuda-11.8/targets/x86_64-linux/lib/libcudart.so' >> ~/.bashrc
RUN apt-get update && apt-get install -y \
    git \
    curl \
    software-properties-common make build-essential \
    libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev tmux\
    && add-apt-repository ppa:deadsnakes/ppa \
    # && apt install -y python3.10 \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /workspace
# RUN curl -sSL https://install.python-poetry.org | python3 -
# RUN echo 'export PATH=$PATH:$HOME/.local/bin' >>  ~/.bashrc
COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt
# RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10 \
#     && python3.10 -m pip install numpy --pre torch==2.0.0 --force-reinstall --index-url https://download.pytorch.org/whl/cu118 \
#     && python3.10 -m pip install -r requirements.txt 
    
COPY . .
ENTRYPOINT ["tail", "-f", "/dev/null"]
