# Building ML Components 

Azure Machine Learning Studio provides a UI for building machine learning components and putting them together in pipelines for development workflows. 

As explained in Azure documentation, "an Azure Machine Learning component is a self-contained piece of code that does one step in a machine learning pipeline... It's a good engineering practice to build a machine learning pipeline to split a complete machine learning task into a multi-step workflow. Such that, everyone can work on the specific step independently. In Azure Machine Learning, a component represents one reusable step in a pipeline."

The corresponding `yml` files describe the input/output of components along with other aspects such as arguments or Environment that should be used. 

While Components can developed in Jupyter Notebooks and this experimental phase can be rather adaptable, and need not be comprehensively organized. When building a pipeline that will load, train, or evaluate a model, sensible to track the development of corresponding Python files of Components on Git. 

To develop experimental code in Jupyter Notebooks, simply create a Notebook in VS Code by opening the command palette and typing `Create: New Jupyter Notebook`, then select `Azure ML compute instances` as _Kernel_. 

Components offer several advantages, including:
- Flexibility and Reusability: Components provide a better amount of flexibility and reuse, allowing for the creation of more efficient and modular machine learning pipelines. 
- Improved Productivity: They help improve the productivity of pipeline building by allowing for independent work on specific steps and facilitating better amount of flexibility and reuse.

Upload individual components to the Workspace using CLI command: 
```
az ml component create -f $file
```
