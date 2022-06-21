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

echo "Building and pushing the full image for Foliant ${FOLIANT_VERSION}"

docker pull foliant/foliant:pandoc
docker login
docker build --no-cache -t foliant/foliant:full -t foliant/foliant:${FOLIANT_VERSION}-full -f Dockerfile-full ./ 2>&1 | tee ./build.log
docker push foliant/foliant:full
docker push foliant/foliant:${FOLIANT_VERSION}-full
docker logout
