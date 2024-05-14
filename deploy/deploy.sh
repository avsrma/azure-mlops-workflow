# Deploy the registered model to AKS (Learn more: https://aka.ms/aml-template).
az ml online-deployment create --file $(FILE) --resource-group $(RESOURCE_GROUP) --workspace-name $(WORKSPACE_NAME) --all-traffic
