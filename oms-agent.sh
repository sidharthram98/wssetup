#Load environment variables from the file
export $(grep -v '^#' .env | xargs)

sudo snap install helm --classic 
helm repo add $OMS_REPO_NAME $OMS_REPO_URL


helm install $STORE_NAME-logs --set omsagent.secret.wsid=a2a23cf2-b161-4631-85da-d9cf38e4553e,omsagent.secret.key=hymgpbf5F9EnVCiRzfojIDY0bMrHUtWC+oVro1XrREnTOOdjqq9Ga0lLZs8nWdICNsKYp8Zzkmjfhc1dKRLKSg==,omsagent.env.clusterName=oms_cluster microsoft/azuremonitor-containers
