#!/bin/bash

container_name=ueransim_docker-ueransim-
gnbs=$(docker ps --format '{{.Names}}' | grep -c "^${container_name}")

for (( i=1; i <= gnbs; i++ )); do
    echo "<@ Stopping traffic from 'uesimtunX' interfaces on '$container_name$i'"
    docker exec $container_name$i /bin/sh -c 'kill -9 $(pgrep -f "ping -I uesimtun")'
done
