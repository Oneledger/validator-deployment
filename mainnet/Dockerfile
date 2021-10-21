FROM golang:1.10.3-stretch

USER root

#Update and install required libs
RUN apt-get update && apt-get install -y \
  apt-utils \
  build-essential \
  git \
  nano \
  curl \
  tmux \
  vim \
  wget \
  libsnappy-dev

#Setup environment variables 
ENV GOVERSION 1.14.7
ENV GOROOT /usr/local/go
ENV GOPATH /home/ubuntu/go
ENV PATH $GOPATH:$GOPATH/bin:$GOROOT/bin:$PATH
ENV OLDATA /home/node/data
ENV OLTEST 1
ENV GO111MODULE on

#Create Directories
RUN mkdir -p -- $GOPATH $OLDATA

#Install dependencies for cleveldb
RUN cd /usr/local && wget https://github.com/google/leveldb/archive/v1.20.tar.gz && \
    tar -zxvf v1.20.tar.gz && \
    cd leveldb-1.20/ && \
    make && \
    cp -r out-static/lib* out-shared/lib* /usr/local/lib/ && \
    cd include/ && \
    cp -r leveldb /usr/local/include/ && \
    ldconfig &&\
    cd /usr/local && \
    rm -f v1.20.tar.gz

CMD ["/bin/bash"]