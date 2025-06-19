#!/bin/bash

ContainerName=ueransim_docker-ueransim-
NumberOfGNBInstances=$(docker ps --format '{{.Names}}' | grep -c "^${ContainerName}")

for (( i=1; i <= NumberOfGNBInstances; i++ ));
do
    echo "<@ Stopping traffic from 'uesimtunX' interfaces on '$ContainerName$i'"
    docker exec -it $ContainerName$i /bin/sh -c 'kill -9 $(pgrep -f "ping -I uesimtun")'
done
