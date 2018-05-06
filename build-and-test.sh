#!/bin/bash
clear
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

mkdir -p "$DIR/config"

TAG="homeassistant-socat:latest"

COUNT=$( docker ps -a | grep "$TAG" | wc -l )
if [ "$COUNT" == "0" ] ; then
  echo "all clear"
else
  echo "clearing..."
  echo "  - stopping $COUNT"
  docker ps -a | grep "homeassistant-socat" | awk '{print $1}' | xargs docker stop
  echo "  - removing $COUNT"
  docker ps -a | grep "homeassistant-socat" | awk '{print $1}' | xargs docker rm
  echo "... done"
fi

docker build -t "$TAG" .
docker image list | grep "$TAG"
docker run -d \
  -e "SOCAT_ZWAVE_HOST=127.0.0.1" \
  -e "SOCAT_ZWAVE_PORT=7676" \
  -e "SOCAT_ZWAVE_LINK=/dev/zwave" \
  -e "PAUSE_BETWEEN_CHECKS=10" \
  -p "9123:8123" \
  --mount type=bind,source="$DIR/config",target=/config \
  "$TAG"

docker ps -a | grep "homeassistant-socat" | awk '{print $1}' | xargs -I % echo docker exec -it % /bin/bash > tmp.run.sh

bash tmp.run.sh
rm tmp.run.sh