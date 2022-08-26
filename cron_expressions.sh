#!/bin/bash

(crontab -l; echo "/5 * * * * bash /home/anicca/Downloads/restart_pods.sh | tee /home/anicca/Downloads/restart_pods.log") | crontab -
(crontab -l; echo "0 */24 * * * echo '------------------Restarting all pods past 24th hour----------------------'") | crontab -
(crontab -l; echo "0 */24 * * * microk8s kubectl delete pods --all | tee /home/anicca/Downloads/restart_pods.log && date | tee /home/anicca/Downloads/restart_pods.log") | crontab -
(crontab -l; echo "1 */24 * * * echo '--------------------------------------------------------------------------' | tee /home/anicca/Downloads/restart_pods.log") | crontab -
