FROM nvidia/cuda:10.2-cudnn7-devel-ubuntu18.04
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV LC_ALL=C.UTF-8

ENV PATH /usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}
RUN apt-get update -y

RUN apt-get update \
    && apt-get install -y python3-pip python3-dev \
    && cd /usr/local/bin \
    && ln -s /usr/bin/python3 python \
    && pip3 install --upgrade pip

COPY requirements.txt /tmp
WORKDIR /tmp
RUN pip install git+https://github.com/SKT-AI/KoBART#egg=kobart
RUN pip install -r requirements.txt

ARG UNAME
ARG UID
ARG GID
RUN groupadd -g $GID -o $UNAME
RUN useradd -m -u $UID -g $GID -o -s /bin/bash $UNAME
USER $UNAME