echo "Do you also want to deploy the model after the pipeline finishes? (y/n)" 
read input

echo "Creating a pipeline job ..." 
run_id=$(az ml job create --file mlops/pipeline-job.yml --resource-group $(RESOURCEGROUP) --workspace-name $(WORKSPACENAME) --query name --output tsv)

if [ "$input" = "y" ]; then
    ./mlops/create_endpoint_deployment.sh
fi 
