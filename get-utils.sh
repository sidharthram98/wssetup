#!/bin/bash

    
cd $HOME/Downloads
wget https://raw.githubusercontent.com/sidharthram98/wssetup/main/configmicrok8s.sh
wget https://raw.githubusercontent.com/sidharthram98/wssetup/main/delete-image.sh
wget https://raw.githubusercontent.com/sidharthram98/wssetup/main/oms-agent.sh
wget https://raw.githubusercontent.com/sidharthram98/wssetup/main/.env-template -O .env
wget https://raw.githubusercontent.com/sidharthram98/wssetup/main/restart_pods.sh
crontab -r && sleep 10
wget https://raw.githubusercontent.com/sidharthram98/wssetup/main/cron_expressions.sh | bash
