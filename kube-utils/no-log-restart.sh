#!/bin/bash

echo ' '>store.txt
podList=$(sudo microk8s kubectl get pods | awk '{print $1}')
#echo $podList

for value in $podList
do
    echo $value> store.txt
    echo "$(tr "\n,[]'" " " < store.txt)"
    if [[ $(sudo microk8s kubectl logs $value --since=10m) ]]; then
        echo "-------------------------------${value} pod is fine!--------------------------------------"
        continue
    else
        echo "-----------------------------logs not found --- Restarting Pod ${value}-------------------------------------"
        sudo microk8s kubectl delete pod $value
    fi
done
