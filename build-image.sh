#!/usr/bin/env sh

JENKINS_VERSION=2.193-jdk11

docker build --build-arg JENKINS_VERSION=${JENKINS_VERSION} \
  -t circulo7/jenkins_kube:${JENKINS_VERSION} \
  -t circulo7/jenkins_kube:latest . && \
  docker push circulo7/jenkins_kube:${JENKINS_VERSION} && \
  docker push circulo7/jenkins_kube:latest && \
  git release $JENKINS_VERSION