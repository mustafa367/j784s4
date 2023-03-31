FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update
RUN apt-get -y install git wget curl

RUN wget https://dr-download.ti.com/software-development/software-development-kit-sdk/MD-zv2DZbDzFz/08.06.00.14/ti-processor-sdk-rtos-j784s4-evm-08_06_00_14.tar.gz
