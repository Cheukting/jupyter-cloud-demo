#!/bin/bash

# Install docker
curl -fsSL get.docker.com -o get-docker.sh
sh get-docker.sh

# Pull and run docker image
docker run -d -p 80:8888 --name demo jupyter/base-notebook start-notebook.sh --NotebookApp.token=