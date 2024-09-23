# Use an official Python runtime as a parent image
FROM python:3.10-bullseye

# Build the Docker image with build arguments
# docker build \
#   --build-arg DOCKERUSER_UID=$DOCKERUSER_UID \
#   --build-arg DOCKERUSER_GID=$DOCKERUSER_GID \
#   --build-arg DOCKERUSER_NAME=$DOCKERUSER_NAME \
#   --build-arg DOCKERUSER_PASSWORD=$DOCKERUSER_PASSWORD \
#   -t my-docker-project .
# or use default values
# docker build -t my-docker-project .
ARG DOCKERUSER_UID=65000
ARG DOCKERUSER_GID=65000
ARG DOCKERUSER_NAME=dockeruser
ARG DOCKERUSER_PASSWORD=dockeruser

ENV DOCKERUSER_UID=${DOCKERUSER_UID}
ENV DOCKERUSER_GID=${DOCKERUSER_GID}
ENV DOCKERUSER_NAME=${DOCKERUSER_NAME}
ENV DOCKERUSER_PASSWORD=${DOCKERUSER_PASSWORD}

###### fix locales ######
# Install locales package
RUN apt-get update && \
    apt-get install -y locales

# Generate the en_US.UTF-8 locale
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LC_ALL=en_US.UTF-8

# Set environment variables for locale
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
###### fix locales ######

RUN mkdir -p /usr/src/venvs && python -m venv /usr/src/venvs/app-main
COPY requirements.txt /usr/src/
RUN /usr/src/venvs/app-main/bin/pip install --upgrade pip && \
    /usr/src/venvs/app-main/bin/pip install -r /usr/src/requirements.txt

# install basic utils
RUN apt-get update && apt-get install -y iputils-ping tree bash sudo gosu && rm -rf /var/lib/apt/lists/*

# Copy entrypoint script
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh


# Copy app.py file
COPY app.py /usr/src/app.py

# Set the working directory in the container
WORKDIR /usr/src/project

# Set entrypoint
ENTRYPOINT ["/entrypoint.sh"]

# Run app.py when the container launches
CMD ["/bin/bash"]
