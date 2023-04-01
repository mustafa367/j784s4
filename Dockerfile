FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get -y update
RUN apt-get -y install git wget curl

# Make directory for SDK
RUN mkdir j784s4

# Grab the Linux SDK
RUN wget https://dr-download.ti.com/software-development/software-development-kit-sdk/MD-lOshtRwR8P/08.06.00.12/ti-processor-sdk-linux-j784s4-evm-08_06_00_12-Linux-x86-Install.bin
# Grab the RTOS SDK
RUN wget https://dr-download.ti.com/software-development/software-development-kit-sdk/MD-zv2DZbDzFz/08.06.00.14/ti-processor-sdk-rtos-j784s4-evm-08_06_00_14.tar.gz
# Grab the Vision Apps dataset
RUN wget https://dr-download.ti.com/software-development/software-development-kit-sdk/MD-zv2DZbDzFz/08.06.00.14/psdk_rtos_ti_data_set_08_06_00.tar.gz

# Untar RTOS SDK and Vision Apps dataset
RUN tar -xf ti-processor-sdk-rtos-j784s4-evm-08_06_00_14.tar.gz
RUN tar -xf psdk_rtos_ti_data_set_08_06_00.tar.gz

# Make Linux SDK executable and install
RUN chmod +x ti-processor-sdk-linux-j784s4-evm-08_06_00_12-Linux-x86-Install.bin
RUN ./ti-processor-sdk-linux-j784s4-evm-08_06_00_12-Linux-x86-Install.bin
