#!/bin/sh

docker-compose up -d \
&& docker run --entrypoint htpasswd registry:2 -Bbn user password > auth/htpasswd
