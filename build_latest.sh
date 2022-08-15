#!/bin/bash -e


echo "Building and pushing the latest image"

docker pull foliant/foliant:slim
docker login
docker build --no-cache -t foliant/foliant ./ 2>&1 | tee ./build.log
docker push foliant/foliant
docker logout
