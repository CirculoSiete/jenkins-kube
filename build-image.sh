#!/usr/bin/env sh

JENKINS_VERSION=2.207-jdk11

LOCAL_TAG_VERSION="${TAG_VERSION:-$JENKINS_VERSION}"

echo "Jenkins version: $JENKINS_VERSION"
echo "LOCAL_TAG_VERSION: $LOCAL_TAG_VERSION"
echo $TAG_VERSION

docker build --build-arg JENKINS_VERSION=${JENKINS_VERSION} \
   -t circulo7/jenkins_kube:${LOCAL_TAG_VERSION} \
   -t circulo7/jenkins_kube:latest . && \
   git release $LOCAL_TAG_VERSION && \
   docker push circulo7/jenkins_kube:${LOCAL_TAG_VERSION} && \
   docker push circulo7/jenkins_kube:latest && \
   echo "Done"
