#!/bin/bash

UE_IMSI=999251000050009

NumberOfUEInstances=1
UEsCreatedAtTheSameTime=2
ContainerName=ueransim_docker-ueransim-
NumberOfGNBInstances=$(docker ps --format '{{.Names}}' | grep -c "^${ContainerName}")

for (( i=1; i <= NumberOfGNBInstances; i++ ));
do
    echo "<@ Starting $NumberOfUEInstances UE instances (with $UEsCreatedAtTheSameTime individual UEs each) on '$ContainerName$i'"
    for (( j=0; j < NumberOfUEInstances; j++ ))
    do
        docker exec $ContainerName$i ./build/nr-ue -c config/ue.yaml -i $UE_IMSI -n $UEsCreatedAtTheSameTime &
        UE_IMSI=$((UE_IMSI+UEsCreatedAtTheSameTime))
        sleep 2
    done
done
echo "<@ All UEs started"
