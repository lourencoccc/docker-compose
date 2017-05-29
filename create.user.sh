#!/bin/bash -e

getIp() {
  name=$(docker ps -f name=$1 --format "{{.Names}}")
  if [[ ! -z "$name" ]] ; then
      docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $name
  fi
}

curl -sS $(getIp auth):5000/user \
           -H 'content-type: application/json' \
           -d '{"username": "admin", "passwd":"admin", "service":"admin"}' |
  python -m json.tool
