ARG JENKINS_VERSION
from "jenkins/jenkins:${JENKINS_VERSION}"

USER root

# 'Docker in Docker'.
RUN apt-get update -qq \
    && apt-get install -qqy apt-transport-https ca-certificates curl gnupg2 software-properties-common gettext-base

RUN curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add -

RUN add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/debian \
    $(lsb_release -cs) \
    stable"

RUN apt-get update  -qq && \
    apt-get install docker-ce=17.12.1~ce-0~debian -y
RUN usermod -aG docker jenkins

#Docker-compose installation
RUN curl -L https://github.com/docker/compose/releases/download/1.24.1/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose

#Kubectl installation
RUN curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && \
    chmod +x ./kubectl && \
    mv ./kubectl /usr/local/bin/kubectl

#Helm installation
RUN curl -LO https://get.helm.sh/helm-v3.0.0-linux-amd64.tar.gz && \
    tar -xzf helm-v3.0.0-linux-amd64.tar.gz && \
    chmod +x linux-amd64/helm && \
    mv linux-amd64/helm /usr/local/bin/

#gcloud SDK installation  
RUN export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
    sudo apt-get update && sudo apt-get install google-cloud-sdk -y

#flux installation
RUN curl -LO https://github.com/fluxcd/flux/releases/download/1.16.0/fluxctl_linux_amd64 && \
    chmod +x ./fluxctl_linux_amd64 && \
    mv ./fluxctl_linux_amd64 /usr/local/bin/fluxctl

#Kubeval installation
RUN wget https://github.com/instrumenta/kubeval/releases/latest/download/kubeval-linux-amd64.tar.gz && \
    tar xf kubeval-linux-amd64.tar.gz && \
    chmod +x kubeval && \
    mv kubeval /usr/local/bin

USER jenkins
