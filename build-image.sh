#!/bin/bash
DOCKER_USERNAME=$1
DOCKER_TOKEN=$2
docker login -u $DOCKER_USERNAME -p $DOCKER_TOKEN
export name=$(grep -A5 '<groupId>it.devops</groupId>' pom.xml | grep -m1 '<artifactId>' | sed -E 's/.*<artifactId>(.*)<\/artifactId>.*/\1/')
export version=$(grep -A5 '<groupId>it.devops</groupId>' pom.xml | grep -m1 '<version>' | sed -E 's/.*<version>(.*)<\/version>.*/\1/')
envsubst < Dockerfile.template > Dockerfile
docker build --platform=linux/amd64 -t domenicoallitude/vulnapp:latest .
docker push domenicoallitude/vulnapp:latest
