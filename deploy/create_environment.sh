echo "Creating prod environment in the registry..."

cd deployment/environment 
# Update version when dependencies are modified
az ml environment create --file environment.yml --registry-name ${WORKSPACE_NAME}-registry --version 1 
