az login
az account set -s 773e2fb0-13ed-47a2-9f60-177d20388aa6

declare resourceGroupLocation="northeurope"
declare resourceGroupName="armstuff"
declare vaultResourceGroupName="armstuff"
declare vaultName="myvault"
declare clusterName="alysfcluster"
declare CertSubjectName="alysfcluster.northeurope.cloudapp.azure.com"
declare vmpassword="Password!1"
declare certpassword="Password4321"
declare vmuser="myadmin"
declare vmOs="UbuntuServer1604"
declare certOutputFolder="c:\certificates"
declare templateFilePath="azuredeploy.json"
declare parametersFilePath="azuredeploy.parameters.json"

az group delete --name $resourceGroupName 
az group create --name $resourceGroupName --location $resourceGroupLocation

# --template-uri
az group deployment validate \
    --resource-group $resourceGroupName \
    --template-file $templateFilePath \
    --parameters $parametersFilePath

