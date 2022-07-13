#!/bin/bash

cd $HOME/Downloads
wget https://raw.githubusercontent/sidharthram98/wssetup/main/configmicrok8s.sh
wget https://raw.githubusercontent/sidharthram98/wssetup/main/delete-image.sh
wget https://raw.githubusercontent/sidharthram98/wssetup/main/oms-agent.sh
wget https://raw.githubusercontent/sidharthram98/wssetup/main/.env-template -O .env
