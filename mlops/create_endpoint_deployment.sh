echo "Checking if online endpoint exists ..."
# Check if "dev" endpoint exists 
existing_ep=$(az ml online-endpoint list --query "[?starts_with(name, 'dev')]" --resource-group $RESOURCE_GROUP --workspace-name $WORKSPACE_NAME)

# If no DEV endpoint is found, create new 
if [ ! -z "$existing_ep" ]; then
    # Extract the name using jq
    echo "Dev endpoint exists"
    ENDPOINT_NAME=$(echo "$existing_ep" | jq -r '.[0].name')
else
    echo "No dev endpoint found, creating new ..."
    # Generate a random name
    export ENDPOINT_NAME=dev-ep-credit-default-`echo $RANDOM`

    # <create_endpoint>
    az ml online-endpoint create --name $ENDPOINT_NAME -f deploy/endpoint.yml --resource-group $(RESOURCE_GROUP) --workspace-name $(WORKSPACE_NAME)
    # </create_endpoint>
fi 

echo "Checking if deployment exists ..."
existing_deployment=$(az ml online-deployment list --endpoint-name $(ENDPOINT_NAME) --resource-group $(RESOURCE_GROUP) --workspace-name $(WORKSPACE_NAME) | jq -r '.[0].name')

# Check if deployment already exists, else create new 
if [ ! -z "$existing_deployment" ]; then
    echo "Deployment exists. Updating existing ..."
    az ml online-deployment update -f deploy/blue-deployment.yml --set model=azureml://registries/$(WORKSPACE_NAME)-registry/models/$(REG_MODEL_NAME)/versions/$(REG_MODEL_VERSION) endpoint_name=$(ENDPOINT_NAME) --resource-group $(RESOURCE_GROUP) --workspace-name $(WORKSPACE_NAME) 

else           
    # Create deployment 
    echo "No existing deployment found. Creating new ..."
    az ml online-deployment create -f deploy/blue-deployment.yml --set model=azureml://registries/$(WORKSPACE_NAME)-registry/models/$(REG_MODEL_NAME)/versions/$(REG_MODEL_VERSION) endpoint_name=$(ENDPOINT_NAME) --resource-group $(RESOURCE_GROUP) --workspace-name $(WORKSPACE_NAME) --all-traffic
fi
