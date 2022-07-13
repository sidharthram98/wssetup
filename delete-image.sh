#!/bin/bash

flux uninstall -s
echo "Flux hooks.. Removed!! 😶‍🌫️"
sleep 5

sudo microk8s kubectl delete deployments --all -n=default
echo "Deployments.. Killed!! 🥶"
sleep 5
sudo microk8s enable gpu
echo "Gpu enabled back again! 😥"
sleep 5

sudo microk8s ctr images rm ghcr.io/anicca-computer-vision-prod/cv_models_prod:$1
echo "${1} Image removed 😎"

bash configmicrok8s.sh
