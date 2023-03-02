FROM python:3.10

COPY . /app

WORKDIR /app

RUN pip install -r ./python/requirements.txt 

RUN apt-get update && apt-get install -y \
    build-essential cmake --no-install-recommends \
    libgtk2.0-dev pkg-config \
	wget vim 

RUN mkdir -p /opencv && cd /opencv && \
    wget -O opencv.zip https://github.com/opencv/opencv/archive/4.x.zip && \
    unzip opencv.zip && \
    mkdir -p build && cd build && \ 
    cmake \
    -D CMAKE_BUILD_TYPE=Release \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    ../opencv-4.x && \
    make -j"$(nproc)" && ldconfig
