set -e
echo "Uploading components to workspace..." 

env_name="dev-environment"
env_version=$(az ml environment list --name ${env_name} --registry-name  ${WORKSPACE_NAME}-registry --resource-group ${RESOURCE_GROUP} --query '[0].version' | sed 's/"//g')

env_registry="azureml://registries/${WORKSPACE_NAME}-registry/environments/$env_name/versions/$env_version"

for file in ml/*/*.yml; do
    az ml component create -f $file --resource-group ${RESOURCE_GROUP} --workspace-name ${WORKSPACE_NAME} --set environment=$env_registry
done
