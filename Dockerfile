############################################
# Base image
############################################
FROM ubuntu:16.04

############################################
# Proxy setting (if nessesary)
############################################
ENV https_proxy "http://proxy_adress:port"
ENV http_proxy "http://proxy_adress:port"

############################################
# update and install tools
############################################
RUN apt-get update && \
    apt update && \
    apt-get install -y wget && \
    apt install -y build-essential libbz2-dev libdb-dev \
    libreadline-dev libffi-dev libgdbm-dev liblzma-dev \
    libncursesw5-dev libsqlite3-dev libssl-dev \
    zlib1g-dev uuid-dev

############################################
# install python
############################################
ARG PYTHON_MAJOR_VERSION="3.9"
ARG PYTHON_MINER_VERSION=".2"
ARG PYTHON_VERSION=${PYTHON_MAJOR_VERSION}${PYTHON_MINER_VERSION}
RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tar.xz && \
    tar xJf Python-${PYTHON_VERSION}.tar.xz && \
    cd Python-${PYTHON_VERSION} && \
    ./configure --enable-shared && \
    make && \
    make install

############################################
# apache install
############################################
RUN apt install -y nano sudo apache2 apache2-dev

############################################
# distribute src
############################################
ARG USER_NAME="apache"
RUN adduser ${USER_NAME}
WORKDIR /home/${USER_NAME}/myapp
COPY ./src .
COPY ./conf /etc/apache2/sites-available

############################################
# pip install
############################################
RUN pip3 install --upgrade pip && \
    pip3 install -r requirements.txt

############################################
# apache setting
############################################
WORKDIR /etc/apache2/sites-available
RUN a2dissite 000-default.conf && \
    a2ensite app.conf

# apacheの起動
CMD ["apachectl", "-D", "FOREGROUND"]