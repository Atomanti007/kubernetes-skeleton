#!/bin/sh

echo "--------------------------------- Uptade"
sudo apt update -y

echo "--------------------------------- Install docker.io"
sudo apt install docker.io -y \
&& sudo usermod -aG docker $USER

echo "--------------------------------- Create new group docker"
newgrp docker << END

echo "--------------------------------- Install docker compose"
sudo apt install docker-compose -y

echo "--------------------------------- Remove golang-docker-credential-helpers"
sudo apt remove golang-docker-credential-helpers -y

echo "--------------------------------- Add zsolt.docker.registry to localhost"
grep -qxF '127.0.0.1 zsolt.docker.registry' /etc/hosts || sudo bash -c 'echo "127.0.0.1 zsolt.docker.registry" >> /etc/hosts'

echo "--------------------------------- Create file system for registry"
mkdir ~/registry -p \
&& mkdir ~/registry/key -p \
&& mkdir ~/registry/images -p \
&& mkdir ~/registry/auth -p \
&& touch ~/registry/auth/htpasswd \
&& wget -P ~/registry https://raw.githubusercontent.com/Atomanti007/kubernetes-skeleton/master/registry/docker-compose.yaml \
&& wget -P ~/registry/key https://raw.githubusercontent.com/Atomanti007/kubernetes-skeleton/master/registry/domain.crt \
&& wget -P ~/registry/key https://raw.githubusercontent.com/Atomanti007/kubernetes-skeleton/master/registry/domain.key

echo "--------------------------------- Compose docker registry"
docker-compose -f ~/registry/docker-compose.yaml up -d \
&& docker run --entrypoint htpasswd registry:2 -Bbn user password > ~/registry/auth/htpasswd
