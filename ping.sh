#!/bin/bash

ContainerName=ueransim_docker-ueransim-
NumberOfGNBInstances=$(docker ps --format '{{.Names}}' | grep -c "^${ContainerName}")

for (( i=1; i <= NumberOfGNBInstances; i++ )); do
    interfaces=$(docker exec $ContainerName$i ip -o link show | awk -F': ' '$2 ~ /^uesimtun/ {split($2, a, "@"); print a[1]}')
    for interface in $interfaces; do
        echo "<@ Generating traffic from '$interface' on '$ContainerName$i'"
        docker exec "$ContainerName$i" /bin/sh -c "nohup ping -I \"$interface\" google.es > /dev/null 2>&1 &"
        sleep 1
    done
done
