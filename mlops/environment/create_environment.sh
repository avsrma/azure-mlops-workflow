echo "Creating training environment in the workspace..."

cd mlops/environment 
# Update version when dependencies are modified
az ml environment create --file dev-environment.yml --registry-name ${WORKSPACE_NAME}-registry --version 1 
