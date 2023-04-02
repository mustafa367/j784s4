FROM ubuntu:18.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install -yq tzdata && \
    ln -fs /usr/share/zoneinfo/America/Detroit /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata

RUN apt-get -y install git wget curl sudo
# # Make directory for SDK
# RUN mkdir /home/j784s4

# Grab the Linux SDK
RUN wget https://dr-download.ti.com/software-development/software-development-kit-sdk/MD-lOshtRwR8P/08.06.00.12/ti-processor-sdk-linux-j784s4-evm-08_06_00_12-Linux-x86-Install.bin
# Grab the RTOS SDK
RUN wget https://dr-download.ti.com/software-development/software-development-kit-sdk/MD-zv2DZbDzFz/08.06.00.14/ti-processor-sdk-rtos-j784s4-evm-08_06_00_14.tar.gz
# Grab the Vision Apps dataset
RUN wget https://dr-download.ti.com/software-development/software-development-kit-sdk/MD-zv2DZbDzFz/08.06.00.14/psdk_rtos_ti_data_set_08_06_00.tar.gz

# Untar RTOS SDK and Vision Apps dataset
RUN tar -xf ti-processor-sdk-rtos-j784s4-evm-08_06_00_14.tar.gz -C /opt/
RUN tar -xf psdk_rtos_ti_data_set_08_06_00.tar.gz -C /opt/

# Make Linux SDK executable and install
RUN chmod +x ti-processor-sdk-linux-j784s4-evm-08_06_00_12-Linux-x86-Install.bin
RUN ./ti-processor-sdk-linux-j784s4-evm-08_06_00_12-Linux-x86-Install.bin

# Set environment variables for SDK
ENV PSDKR_PATH /opt/ti-processor-sdk-rtos-j784s4-evm-08_06_00_14
ENV PSDKL_PATH /opt/ti-processor-sdk-linux-j784s4-evm-08_06_00_12
ENV SOC j784s4

# Copy file system and boot image
RUN cp ${PSDKL_PATH}/board-support/prebuilt-images/boot-${SOC}-evm.tar.gz ${PSDKR_PATH}/
RUN cp ${PSDKL_PATH}/filesystem/tisdk-edgeai-image-${SOC}-evm.tar.xz ${PSDKR_PATH}/

# Run setup_psdk_rtos.sh
RUN cd /opt/ti-processor-sdk-rtos-j784s4-evm-08_06_00_14
RUN /bin/bash -c ./psdk_rtos/scripts/setup_psdk_rtos.sh

# Clean up
RUN rm /ti*
RUN rm /psdk*