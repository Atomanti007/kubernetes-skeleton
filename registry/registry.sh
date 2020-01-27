#!/bin/sh

sudo apt update -y \
&& sudo apt install docker.io -y \
&& sudo usermod -aG docker $USER \
&& newgrp docker \
&& sudo apt install docker-compose -y \
&& sudo apt remove golang-docker-credential-helpers \
&& grep -qxF '127.0.0.1 zsolt.docker.registry' /etc/hosts || sudo bash -c 'echo "127.0.0.1 zsolt.docker.registry" >> /etc/hosts' \
&& mkdir ~/registry -p \
&& mkdir ~/registry/key -p \
&& mkdir ~/registry/images -p \
&& mkdir ~/registry/auth -p \
&& touch ~/registry/auth/htpasswd \
&& wget -P ~/registry https://raw.githubusercontent.com/Atomanti007/kubernetes-skeleton/master/registry/docker-compose.yaml \
&& wget -P ~/registry/key https://raw.githubusercontent.com/Atomanti007/kubernetes-skeleton/master/registry/domain.crt \
&& wget -P ~/registry/key https://raw.githubusercontent.com/Atomanti007/kubernetes-skeleton/master/registry/domain.key \
&& docker-compose -f ~/registry/docker-compose.yaml up -d \
&& docker run --entrypoint htpasswd registry:2 -Bbn user password > ~/registry/auth/htpasswd
