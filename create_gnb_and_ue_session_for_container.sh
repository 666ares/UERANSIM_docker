#!/bin/bash

ue_imsi=999251000050009
ue_processes=1
ue_on_each_process=1

container_name=ueransim_docker-ueransim-
gnbs=$(docker ps --format '{{.Names}}' | grep -c "^${container_name}")

for (( i=1; i <= gnbs; i++ )); do
    echo "<@ Starting $ue_processes 'nr-ue' process(es) with $ue_on_each_process UE(s) per process on '$container_name$i'"
    for (( j=0; j < ue_processes; j++ )); do
        docker exec $container_name$i /bin/sh -c "./build/nr-ue -c config/ue.yaml -i $ue_imsi -n $ue_on_each_process &"
        ue_imsi=$((ue_imsi+ue_on_each_process))
        sleep 1
    done
done
echo "<@ All UEs started"