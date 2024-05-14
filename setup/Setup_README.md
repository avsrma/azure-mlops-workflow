# Setting up the Experimental Pipeline 
## Create a new resource group 
Follow instructions on creating a new [Resource Group in Azure](https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/manage-resource-groups-portal#create-resource-groups). 

Further instructions on managing the Access Control (IAM) can be found on [Assign Azure roles using the Azure portal
](https://learn.microsoft.com/en-us/azure/role-based-access-control/role-assignments-portal). 

## Create a new workspace 

Follow instructions on creating a new [ML Workspace in Azure](https://learn.microsoft.com/en-us/azure/machine-learning/how-to-manage-workspace?tabs=azure-portal&view=azureml-api-2#create-a-workspace). 

## Install Azure CLI (v2) 
Follow instructions to [setup Azure CLI](https://learn.microsoft.com/en-us/azure/machine-learning/how-to-configure-cli?view=azureml-api-2&tabs=public).

## Install Azure ML extension in VS Code 
Follow instructions to [set up Visual Studio Code desktop with the Azure Machine Learning extension](https://learn.microsoft.com/en-us/azure/machine-learning/how-to-setup-vs-code?view=azureml-api-2). 

## Setting up requirements 
The provided shell script creates the necessary prerequisites, a Registry, a sample Environment, and a Compute Cluster. 

```
export RESOURCE_GROUP=<your-resource-group-name>
export WORKSPACE_NAME=<your-workspace-name>
bash setup/setup.sh
```
The created Registry is named after your workspace, `<your-workspace-name>-registry`, the Environment is named `sample-environment`, and the Compute Cluster `cpu-cluster`. 

Note that this script just creates a starter Environment and you would need to customize the `sample-conda.yml` as per your project needs. I recommend creating one Environment for development and a separate one for Production purposes. You would find them under [mlops](../mlops/environment/) and [deploy](../deploy/) directories. 

Similarly, the Compute Cluster must be adapted based on your hardware requirements. For this, modifications to the [cpu-cluster.yml](clusters/cpu-cluster.yml) file may be necessary. 


### Why create a Registry? 
Registry facilitates sharing components, environments, models, and data assets with collaborators within your organization. You can also see this as a way to track your staging or production assets. Additionally, you can control who has access to them! 

The excerpt below from Azure Documentation further expands on the utility.

There are two scenarios where you'd want to use the same set of models, components and environments in multiple workspaces: 

- Cross-workspace MLOps: You're training a model in a dev workspace and need to deploy it to test and prod workspaces. In this case you, want to have end-to-end lineage between endpoints to which the model is deployed in test or prod workspaces and the training job, metrics, code, data and environment that was used to train the model in the dev workspace.
- Share and reuse models and pipelines across different teams: Sharing and reuse improve collaboration and productivity. In this scenario, you may want to publish a trained model and the associated components and environments used to train it to a central catalog. From there, colleagues from other teams can search and reuse the assets you shared in their own experiments.

Additional documentation can be found [here](https://learn.microsoft.com/en-us/azure/machine-learning/how-to-share-models-pipelines-across-workspaces-with-registries). 