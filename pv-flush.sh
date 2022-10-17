flux uninstall -s
sudo microk8s kubectl delete deployments --all -n=default
sudo microk8s kubectl delete pvc --all -n=default
sudo microk8s kubectl delete pv --all -n=default
rm -rf /home/anicca/aniccadeveloper
cd /home/anicca/Downloads
sudo microk8s ctr images rm ghcr.io/anicca-computer-vision-prod/cv_models_prod:master
bash configmicrok8s.sh
