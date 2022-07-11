#Load environment variables from the file
export $(grep -v '^#' .env | xargs)

sudo snap install helm --classic 
helm repo add microsoft https://microsoft.github.io/charts/repo


helm install $STORE_NAME --set omsagent.secret.wsid=635f4b18-56de-418e-a18a-b5a6f06bdd59,omsagent.secret.key=//LCLMRtqSB4VdI+5gKK+rogCJbzorSD+vW/ChaI/irM2eVQCq7XKu/PWBI/edepwGWhRspR68MaV4hPbY0wuQ==,omsagent.env.clusterName=oms_cluster microsoft/azuremonitor-containers
