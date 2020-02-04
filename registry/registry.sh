#!/bin/sh

echo "--------------------------------- Get domain"
echo Domain name:
read docker_domain

echo "--------------------------------- Uptade"

sudo apt update -y

echo "--------------------------------- Install docker.io"

sudo apt install docker.io -y \
&& sudo usermod -aG docker $USER

echo "--------------------------------- Create new group docker"
newgrp docker << END

echo "--------------------------------- Install docker compose"
sudo apt install docker-compose -y

echo "--------------------------------- Fix docker login"
sudo apt install gnupg2 pass -y

echo "--------------------------------- Add zsolt.docker.registry to localhost"
grep -qxF '127.0.0.1 $docker_domain' /etc/hosts || sudo bash -c 'echo "127.0.0.1 $docker_domain" >> /etc/hosts'

echo "--------------------------------- Create file system for registry"
mkdir ~/registry -p \
&& mkdir ~/registry/key -p \
&& mkdir ~/registry/images -p \
&& mkdir ~/registry/auth -p \
&& touch ~/registry/auth/htpasswd \
&& wget -P ~/registry https://raw.githubusercontent.com/Atomanti007/kubernetes-skeleton/master/registry/docker-compose.yaml \
&& openssl req -subj '/CN=$docker_domain/O=Atomanti007/C=HU' -new -newkey rsa:2048 -days 365 -nodes -x509 -keyout ~/registry/key/domain.key -out ~/registry/key/domain.crt

echo "--------------------------------- Compose docker registry"
docker-compose -f ~/registry/docker-compose.yaml up -d \
&& docker run --entrypoint htpasswd registry:2 -Bbn user password > ~/registry/auth/htpasswd
