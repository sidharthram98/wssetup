#! /bin/bash
/usr/local/bin/kubectl get pods | awk '/Running/' | awk {'print $1'} | tee pods.txt
while read pod; do
  getLogs=$(/usr/local/bin/kubectl logs $pod --since 1m)
    if [ "$getLogs"!="" ]; then
       echo "${pod} pod is working fine!">>restart_pods.log
       continue
    else
      echo "logs not found --- Restarting Pod" $pod>>restart_pods.log
      kubectl delete pod $pod
    fi
done<pods.txt


/usr/local/bin/kubectl get pods | awk '/CrashLoopBackOff/' | awk {'print $1'} | tee pods.txt
while read pod; do
  kubectl delete $pod
  echo 'Restarting '$pod>>restart_pods.log
done<pods.txt
echo '--------------------------------'>>restart_pods.log
date | tee -a restart_pods.log
echo '--------------------------------------------------------------'>>restart_pods.log
exit 0
