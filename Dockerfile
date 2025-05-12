
FROM osrf/ros:noetic-desktop-full

# Set noninteractive to avoid prompts during the build
ARG DEBIAN_FRONTEND=noninteractive

# Update apt package list and install general packages
RUN apt-get update && \
    apt-get install -y --fix-missing \
    curl wget \
    nano \
    build-essential \ 
    cmake \
    libeigen3-dev\
    ros-noetic-libfranka

COPY . /workspace
WORKDIR /workspace

# Set the default command to execute
CMD ["bash"]



