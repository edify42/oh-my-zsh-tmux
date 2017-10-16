#!/bin/bash

NAME=awscli

docker rm -f $USER/$NAME
docker build . -t $USER/$NAME

docker run --rm -it $USER/$NAME 
