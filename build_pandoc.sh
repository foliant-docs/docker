#!/bin/bash -e

os_type=`uname`

if [ "${os_type}" == 'Darwin' ] ; then
    grep_option='E'
else
    grep_option='P'
fi

if [ ! $1 ] ; then
    # TODO: switch add-partial-copy to master
    FOLIANT_VERSION=`curl https://raw.githubusercontent.com/foliant-docs/foliant/fix-partial-copy/foliant/__init__.py | grep -${grep_option}o "\d+\.\d+\.\d+"`
else
    FOLIANT_VERSION=$1
fi

echo "Building and pushing the pandoc image for Foliant ${FOLIANT_VERSION}"

DOCKER_IMAGE_TAG=foliant/foliant:pandoc
DOCKER_IMAGE_NUMBERED_TAG=foliant/foliant:${FOLIANT_VERSION}-pandoc
GITHUB_REGISTRY_URL=ghcr.io
ORGANIZATION=foliant-docs

# docker pull $GITHUB_REGISTRY_URL/$ORGANIZATION/foliant/foliant
# docker login $GITHUB_REGISTRY_URL
docker build --no-cache -t $DOCKER_IMAGE_TAG -t $DOCKER_IMAGE_NUMBERED_TAG -f Dockerfile-pandoc ./ 2>&1 | tee ./build.log
# docker tag $DOCKER_IMAGE_TAG $GITHUB_REGISTRY_URL/$ORGANIZATION/$DOCKER_IMAGE_TAG
# docker push $GITHUB_REGISTRY_URL/$ORGANIZATION/$DOCKER_IMAGE_TAG
# docker tag $DOCKER_IMAGE_NUMBERED_TAG $GITHUB_REGISTRY_URL/$ORGANIZATION/$DOCKER_IMAGE_NUMBERED_TAG
# docker push $GITHUB_REGISTRY_URL/$ORGANIZATION/$DOCKER_IMAGE_NUMBERED_TAG
# docker logout $GITHUB_REGISTRY_URL
