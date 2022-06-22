!/bin/bash
echo "Installing Microk8s..."
sudo snap install microk8s --classic --channel=1.24/stable

echo "Microk8s installed. Configuring networking..."
sudo ufw allow in on cni0 && sudo ufw allow out on cni0
sudo ufw default allow routed

echo "Disabling HA Cluster... This might take a while..."
microk8s disable ha-cluster

echo "Enabling GPU..."
microk8s enable gpu dns storage

echo "Enabling Multus"
microk8s enable multus
