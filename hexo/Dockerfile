FROM node:20-bullseye

MAINTAINER Hankz <hankz1108@gmail.com>

# # Set the server port as an environmental
# ENV HEXO_SERVER_PORT=4000

# Install requirements
RUN \
  apt-get update && \
  apt-get install git htop vim -y && \
  npm install -g hexo-cli

# Set workdir
WORKDIR /app

# Expose Server Port
EXPOSE ${HEXO_SERVER_PORT}

# run init script
ADD init /init

RUN chmod -R +x /init
CMD /init/init.sh
