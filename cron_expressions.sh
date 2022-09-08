#!/bin/bash

(crontab -l; echo "*/5 * * * * cd /home/anicca/Downloads && bash restart_pods.sh")|crontab -
(crontab -l; echo "0 */24 * * *  cd /home/anicca/Downloads && bash restart_24th.sh")|crontab -

