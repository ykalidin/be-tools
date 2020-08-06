# Azure OpenShift cluster setup

### Prerequisites
* Azure subscription. You need to have access to [Azure portal](https://portal.azure.com/)
* Install the [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
* Install [OpenShift CLI](https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/)

### Create an Azure Red Hat OpenShift 4 cluster
* Login to Azure CLI
```
az login
```

* Install az aro extension
```
az extension add -n aro --index https://az.aroapp.io/stable
```

* Register the resource provider
```
az provider register -n Microsoft.RedHatOpenShift --wait
```

* Verify the extension using:
```
az -v
```

* Create virtual network
  * Set the following variable
    ```
    LOCATION=eastus           # the location of your cluster
    RESOURCEGROUP=aro-rg      # the name of the resource group where you want to create your cluster
    CLUSTER=cluster           # the name of your cluster
    ```  
* Create a resource group
```
az group create --name $RESOURCEGROUP --location $LOCATION
```

* Create a virtual network
```
  az network vnet create \
  --resource-group $RESOURCEGROUP \
  --name aro-vnet \
  --address-prefixes 10.0.0.0/22
```

* Add an empty subnet for the master nodes
```
  az network vnet subnet create \
  --resource-group $RESOURCEGROUP \
  --vnet-name aro-vnet \
  --name master-subnet \
  --address-prefixes 10.0.0.0/23 \
  --service-endpoints Microsoft.ContainerRegistry
```

* Add an empty subnet for the worker nodes
```
  az network vnet subnet create \
  --resource-group $RESOURCEGROUP \
  --vnet-name aro-vnet \
  --name worker-subnet \
  --address-prefixes 10.0.2.0/23 \
  --service-endpoints Microsoft.ContainerRegistry
```

* Disable subnet private endpoint policies. This is required to connect and manage the cluster
```
  az network vnet subnet update \
  --name master-subnet \
  --resource-group $RESOURCEGROUP \
  --vnet-name aro-vnet \
  --disable-private-link-service-network-policies true
```
### Create the cluster
Create the cluster using following command. This may take around ~30 mins to create a cluster.
```
  az aro create \
   --resource-group $RESOURCEGROUP \
   --name $CLUSTER \
   --vnet aro-vnet \
   --master-subnet master-subnet \
   --worker-subnet worker-subnet
```
### Connect to Cluster
* Get login credentials of the OpenShift cluster you have created in the previous step.<br> Run following command:
```
  az aro list-credentials \
   --name $CLUSTER \
   --resource-group $RESOURCEGROUP
```

* Get the cluster console URL.
```
  az aro show \
   --name $CLUSTER \
   --resource-group $RESOURCEGROUP \
   --query "consoleProfile.url" -o tsv
```

  * Launch the console URL in a browser and login using the credentials obtained in the step-1.

* Access cluster
```
apiServer=$(az aro show -g $RESOURCEGROUP -n $CLUSTER --query apiserverProfile.url -o tsv)
oc login $apiServer -u kubeadmin -p <kubeadmin password>
```


## Setup Azure registry

 To Create an azure registry, see [setup azure registry](Setting%20Up%20an%20Azure%20Container%20Registry) 

