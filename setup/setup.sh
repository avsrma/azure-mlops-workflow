az configure --defaults group=${RESOURCE_GROUP} workspace=${WORKSPACE_NAME}

registry_name=$(az ml registry show --name ${WORKSPACE_NAME}-registry --query name -o tsv)
if [[ -z "$registry_name" ]]
then 
    echo "Azure ML registry does not exist. Creating registry..."
    az ml registry create --file setup/registry.yml --name ${WORKSPACE_NAME}-registry
else
    echo "Existing registry found: $registry_name"
    exit 0
fi

echo "Creating sample environment in registry..."
az ml environment create --file setup/environments/sample-environment.yml --registry-name ${WORKSPACE_NAME}-registry

compute_name=$(az ml compute show -n cpu-cluster --query name -o tsv)
if [[ -z "$compute_name" ]]
then
    echo "Compute does not exists. Creating the cluster..."
    az ml compute create -f setup/clusters/cpu-cluster.yml 
else
    echo "Compute exists. Skipping cluster creation."
    exit 0
fi
