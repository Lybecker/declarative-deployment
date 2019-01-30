KEYVAULT_NAME=alyfisk
RESOURCEGROUP=newrg
MY_SECRET=my-secret
MY_SECRET_VALUE=mysecret
LOCATION=westeurope
WEBAPP=nnvniher43
PLANNAME=myappplan

# set -x -e

az group create -n $RESOURCEGROUP -l $LOCATION

az keyvault create --name $KEYVAULT_NAME --resource-group $RESOURCEGROUP --enabled-for-template-deployment
az keyvault secret set --vault-name $KEYVAULT_NAME --name $MY_SECRET --value $MY_SECRET_VALUE

az appservice plan create --name $PLANNAME --resource-group $RESOURCEGROUP --location $LOCATION --sku S1
az webapp create --name $WEBAPP --resource-group $RESOURCEGROUP --plan $PLANNAME

az webapp identity assign --name $WEBAPP --resource-group $RESOURCEGROUP

IDENTITY_ID=$(az webapp identity show --name $WEBAPP --resource-group $RESOURCEGROUP --query principalId -o tsv)

az webapp config appsettings set --name $WEBAPP --resource-group $RESOURCEGROUP --settings fisk=true

az keyvault set-policy --secret-permissions get -n $KEYVAULT_NAME -g $RESOURCEGROUP --object-id $IDENTITY_ID