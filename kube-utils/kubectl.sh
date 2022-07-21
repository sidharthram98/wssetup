#!/bin/bash

podList=$(ls -A | awk 'NR == 1{o = "['\''" $1 "'\''"}NR > 1{o = o ", '\''" $1 "'\''"}END{o = o "]"; print o}')

echo $podList

for value in $podList
do
    echo $value> store.txt  
    podName= tr ",[]'" " " < store.txt
    if [[ sudo microk8s kubectl logs $podName --since 1m ]]; then
        echo "logs found"
    else
        sudo microk8s kubectl get pods 
    fi
done
