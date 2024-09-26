# Use an official Ubuntu image as a base
FROM ubuntu:20.04

# Add these lines at the beginning of your Dockerfile
ARG DOCKERUSER_UID=65000
ARG DOCKERUSER_GID=65000
ARG DOCKERUSER_NAME=dockeruser
ARG DOCKERUSER_PASSWORD=dockeruser
ARG DOCKERUSER_HOME=/home/dockeruser
ARG DOCKERUSER_SHELL=/bin/bash

# Update environment variables
ENV DOCKERUSER_UID=${DOCKERUSER_UID}
ENV DOCKERUSER_GID=${DOCKERUSER_GID}
ENV DOCKERUSER_NAME=${DOCKERUSER_NAME}
ENV DOCKERUSER_PASSWORD=${DOCKERUSER_PASSWORD}
ENV DOCKERUSER_HOME=${DOCKERUSER_HOME}
ENV DOCKERUSER_SHELL=${DOCKERUSER_SHELL}

# Create the user with the specified UID and GID
RUN groupadd -g ${DOCKERUSER_GID} ${DOCKERUSER_NAME} && \
    useradd -m -u ${DOCKERUSER_UID} -g ${DOCKERUSER_GID} -s ${DOCKERUSER_SHELL} ${DOCKERUSER_NAME} && \
    echo "${DOCKERUSER_NAME}:${DOCKERUSER_PASSWORD}" | chpasswd && \
    usermod -aG sudo ${DOCKERUSER_NAME}

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Europe/Copenhagen

# Install required packages
RUN apt-get update && \
    apt-get install -y \
    texlive-latex-base \
    texlive-latex-recommended \
    texlive-latex-extra \
    texlive-fonts-recommended \
    texlive-fonts-extra \
    texlive-xetex \
    texlive-science \
    texlive-pictures \
    latexmk \
    make \
    git \
    wget \
    unzip \
    sudo \
    gosu \
    locales \
    lcdf-typetools \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    wget \
    perl \
    xzdec \
    tar \
    make \
    git \
    wget \
    unzip \
    locales \
    xfonts-utils \
    fontconfig \
    ttf-mscorefonts-installer \
    && rm -rf /var/lib/apt/lists/*


RUN apt-get update && \
apt-get install -y \
wget \
perl \
xzdec \
tar \
make \
git \
wget \
unzip \
locales \
xfonts-utils \
fontconfig \
ttf-mscorefonts-installer \
&& rm -rf /var/lib/apt/lists/*

# Set up locales
RUN locale-gen en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8

# Set the working directory
WORKDIR /usr/src/project

# Copy the DTU templates into the container
COPY ../../dtutemplates/tex/latex/ /usr/local/share/texmf/tex/latex/

# Update LaTeX filename database
RUN mktexlsr

# Copy your LaTeX files into the working directory
# COPY app-main/ /usr/src/project/app-main/

# Copy the entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint to our custom script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Run an interactive shell by default
CMD ["/bin/bash"]
