#!/bin/bash -e

os_type=`uname`

if [ "${os_type}" == 'Darwin' ] ; then
    grep_option='E'
else
    grep_option='P'
fi

if [ ! $1 ] ; then
    FOLIANT_VERSION=`curl https://raw.githubusercontent.com/foliant-docs/foliant/master/foliant/__init__.py | grep -${grep_option}o "\d+\.\d+\.\d+"`
else
    FOLIANT_VERSION=$1
fi

echo "Building and pushing the slim image for Foliant ${FOLIANT_VERSION}"

docker pull ubuntu:focal
docker login
docker build --no-cache --build-arg VERSION=${FOLIANT_VERSION} -t foliant/foliant:slim -t foliant/foliant:${FOLIANT_VERSION}-slim -f Dockerfile-slim ./ 2>&1 | tee ./build.log
docker push foliant/foliant:slim
docker push foliant/foliant:${FOLIANT_VERSION}-slim
docker logout
