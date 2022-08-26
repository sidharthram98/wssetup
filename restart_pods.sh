#! /bin/bash
microk8s kubectl get pods | awk '/Running/' | awk {'print $1'} | tee pods.txt

while read pod; do
  getLogs=$(microk8s kubectl logs $pod --since 1m)

    if [ "$getLogs"!="" ]; then
       echo "${pod} pod is fine!"
       continue
    else
      echo "logs not found --- Restarting Pod ${pod}"
      microk8s kubectl delete pod $pod
    fi
done<pods.txt


microk8s kubectl get pods | awk '/CrashLoopBackOff/' | awk {'print $1'} | tee pods.txt
while read pod; do
  microk8s kubectl delete $pod
  echo 'Restarting ${pod}'
done<pods.txt
exit 0
