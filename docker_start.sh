#!/usr/bin/env bash

PACKAGE_NAME="cache_thingy"
PORT="8082"
PORT_2="8090"
PORT_3="8091"
PORT_4="8092"

docker build -t $PACKAGE_NAME:latest .

container_run() {
  # --name nginx_cache \
  docker run -it \
    --mount source=nginx-cache,target=/data/nginx/cache \
    -e COGNITE_PROJECT=$COGNITE_PROJECT \
    -e COGNITE_API_KEY=$COGNITE_API_KEY \
    -p $PORT:8080 \
    -p $PORT_2:8090 \
    -p $PORT_3:8091 \
    -p $PORT_4:8092 \
    --name $PACKAGE_NAME \
    $PACKAGE_NAME:latest

}

container_start() {
  docker start -a $PACKAGE_NAME
}

while [ "$1" != "" ]; do
  case $1 in
  -r | --run)
    container_run
    ;;
  -s | --start)
    container_start
    ;;
  *)
    echo "Heeelp"
    ;;
  esac
  shift
done
