# Add the service principal application ID and secret here
$servicePrincipalClientId="<ENTER CLIENT ID HERE>"
$servicePrincipalSecret="<ENTER SECRET HERE>"

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

# Download the installation package
Invoke-WebRequest -Uri "https://aka.ms/azcmagent-windows" -TimeoutSec 30 -OutFile "$env:TEMP\install_windows_azcmagent.ps1"

# Install the hybrid agent
& "$env:TEMP\install_windows_azcmagent.ps1"
if($LASTEXITCODE -ne 0) {
    throw "Failed to install the hybrid agent"
}

# Run connect command
& "$env:ProgramW6432\AzureConnectedMachineAgent\azcmagent.exe" connect --service-principal-id "$servicePrincipalClientId" --service-principal-secret "$servicePrincipalSecret" --resource-group "arck8s_rg" --tenant-id "72f988bf-86f1-41af-91ab-2d7cd011db47" --location "eastus2" --subscription-id "bc0df350-c38b-4169-83d3-a3cf7ebf8a7a" --cloud "AzureCloud" --tags "CountryOrRegion=USA" --correlation-id "b31bbe35-7ebf-4827-8172-c0d02ebf1032"

if($LastExitCode -eq 0){Write-Host -ForegroundColor yellow "To view your onboarded server(s), navigate to https://ms.portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/Microsoft.HybridCompute%2Fmachines"}
