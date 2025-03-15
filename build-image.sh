#!/bin/bash
source utility.sh

docker login -u $DOCKER_USERNAME -p $DOCKER_TOKEN > /dev/null
if [[ $? -eq 0 ]]; then
    logger "i" "Docker login successful."
else
    logger "e" "Docker login failed."
    exit 1
fi

export name=$(grep -A5 '<groupId>it.devops</groupId>' pom.xml | grep -m1 '<artifactId>' | sed -E 's/.*<artifactId>(.*)<\/artifactId>.*/\1/')
export version=$(grep -A5 '<groupId>it.devops</groupId>' pom.xml | grep -m1 '<version>' | sed -E 's/.*<version>(.*)<\/version>.*/\1/')

if [[ -z "$name" || -z "$version" ]]; then
    logger "e" "Error: Unable to retrieve name or version from pom.xml"
    exit 1
else
    logger "i" "The app name is: $name"
    logger "i" "The app version is: $version"
fi

envsubst < Dockerfile.template > Dockerfile
IMAGE_TAG="$DOCKER_USERNAME/$name:$version"
logger "i" "Preparing to push $IMAGE_TAG"

docker build --platform=linux/amd64 -t $IMAGE_TAG .
if [[ $? -eq 0 ]]; then
    logger "i" "$IMAGE_TAG created"
else
    logger "e" "Problem to create image"
    exit 1
fi

docker push $IMAGE_TAG
if [[ $? -eq 0 ]]; then
    logger "i" "$IMAGE_TAG pushed on Docker Hub"
else
    logger "e" "Problem to push image $IMAGE_TAG"
    exit 1
fi
