#!/usr/bin/env sh

JENKINS_VERSION=2.189-jdk11

docker build --build-arg JENKINS_VERSION=${JENKINS_VERSION} -t circulo7/jenkins_kube:${JENKINS_VERSION} .