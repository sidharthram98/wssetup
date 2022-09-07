#!/bin/bash

(crontab -l; echo "*/5 * * * * cd /home/anicca/Downloads && bash restart_pods.sh")|crontab -
(crontab -l; echo "0 */24 * * * echo '------------------Restarting all pods past 24th hour----------------------'>>/home/Downloads/restart_pods.log")|crontab -
(crontab -l; echo "0 */24 * * * microk8s kubectl delete pods --all | tee -a /home/anicca/Downloads/restart_pods.log && date | tee -a /home/anicca/Downloads/restart_pods.log")|crontab -
(crontab -l; echo "1 */24 * * * echo '--------------------------------------------------------------------------'>>/home/anicca/Downloads/restart_pods.log")|crontab -
