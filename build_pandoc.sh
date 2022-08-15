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

echo "Building and pushing the pandoc image for Foliant ${FOLIANT_VERSION}"

docker pull foliant/foliant
docker login
docker build --no-cache -t foliant/foliant:pandoc -t foliant/foliant:${FOLIANT_VERSION}-pandoc -f Dockerfile-pandoc ./ 2>&1 | tee ./build.log
docker push foliant/foliant:pandoc
docker push foliant/foliant:${FOLIANT_VERSION}-pandoc
docker logout
