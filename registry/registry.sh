#!/bin/sh


docker-compose up -d

sleep 10

docker run --entrypoint htpasswd registry:2 -Bbn user password > auth/htpasswd
