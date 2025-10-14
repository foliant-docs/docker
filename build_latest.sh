#!/bin/bash -e


echo "Building and pushing the latest image"

DOCKER_IMAGE_TAG=foliant/foliant
GITHUB_REGISTRY_URL=ghcr.io
ORGANIZATION=foliant-docs

# docker pull $GITHUB_REGISTRY_URL/$ORGANIZATION/foliant/foliant:slim
# docker login $GITHUB_REGISTRY_URL
docker build --no-cache -t $DOCKER_IMAGE_TAG ./ 2>&1 | tee ./build.log
# docker tag $DOCKER_IMAGE_TAG $GITHUB_REGISTRY_URL/$ORGANIZATION/$DOCKER_IMAGE_TAG
# docker push $GITHUB_REGISTRY_URL/$ORGANIZATION/$DOCKER_IMAGE_TAG
# docker logout $GITHUB_REGISTRY_URL
