#!/bin/bash

set -e

if [ ! $1 ] ; then
    FOLIANT_VERSION=1.0.11 # Default version, upgrade it when necessary
else
    FOLIANT_VERSION=$1
fi

echo "Building and pushing the full image for Foliant ${FOLIANT_VERSION}"

docker pull foliant/foliant:pandoc
docker login
docker build -t foliant/foliant:full -t foliant/foliant:${FOLIANT_VERSION}-full -f Dockerfile-full ./ 2>&1 | tee ./build.log
docker push foliant/foliant:full
docker push foliant/foliant:${FOLIANT_VERSION}-full
docker logout
