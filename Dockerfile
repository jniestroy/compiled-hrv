FROM debian:stretch-slim
RUN apt-get update -y
RUN apt-get upgrade -y


ENV DEBIAN_FRONTEND noninteractive
RUN apt-get -q update && \
    apt-get install -q -y --no-install-recommends \
	  xorg \
      unzip \
      wget \
      curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install the MCR dependencies and some things we'll need and download the MCR
# from Mathworks -silently install it
RUN mkdir /mcr-install && \
    mkdir /opt/mcr && \
    cd /mcr-install && \
    wget -q http://ssd.mathworks.com/supportfiles/downloads/R2019a/Release/5/deployment_files/installer/complete/glnxa64/MATLAB_Runtime_R2019a_Update_5_glnxa64.zip && \
    unzip -q MATLAB_Runtime_R2019a_Update_5_glnxa64.zip && \
    rm -f MATLAB_Runtime_R2019a_Update_5_glnxa64.zip && \
    ./install -destinationFolder /opt/mcr -agreeToLicense yes -mode silent && \
    cd / && \
    rm -rf mcr-install

#ENV LD_LIBRARY_PATH /opt/mcr/v96/runtime/glnxa64:/opt/mcr/v96/bin/glnxa64:/opt/mcr/v96/sys/os/glnxa64:/opt/mcr/v96/extern/bin/glnxa64
COPY . .
RUN mkdir Results
RUN apt-get update -y
RUN apt-get install -y python python-pip build-essential
COPY requirements.txt .
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

RUN chmod +x HRV.sh

ENTRYPOINT ["/HRV.sh"]
CMD []
