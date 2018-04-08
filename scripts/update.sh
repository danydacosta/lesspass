#!/usr/bin/env bash

docker-compose pull
docker-compose down
echo "Curl docker-compose.prod.yml"
curl -s -o docker-compose.yml https://raw.githubusercontent.com/danydacosta/lesspass/master/docker-compose.prod.yml
echo "Try to renew LestEncrypt certificate"
docker run -it --rm -p 4433:443 -p 8081:80 -v $PWD/letsencrypt:/etc/letsencrypt/ certbot/certbot renew
docker-compose up -d
echo "Delete old docker images"
docker images --quiet --filter=dangling=true | xargs --no-run-if-empty docker rmi