#!/bin/bash

container_name=ueransim_docker-ueransim-
gnbs=$(docker ps --format '{{.Names}}' | grep -c "^${container_name}")

for (( i=1; i <= gnbs; i++ )); do
    interfaces=$(docker exec $container_name$i ip -o link show | awk -F': ' '$2 ~ /^uesimtun/ {split($2, a, "@"); print a[1]}')
    for interface in $interfaces; do
        echo "<@ Generating traffic from '$interface' on '$container_name$i'"
        docker exec "$container_name$i" /bin/sh -c "ping -I \"$interface\" google.es > /dev/null 2>&1 &"
        sleep 1
    done
done
