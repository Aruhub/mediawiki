Flow
Github <--> Azure Pipeline


Pre-requisites:
1. Github used as repo and AzDO used to execute the pipeline.
2. Create a Bakcend Storage Account to store the state in remote
3. Create a Service Connection in AzDO, which connects to Azure to create resources in Azure Portal
4. Install Terraform and run TF Commands
5. Install Kubectl and Git


Post VM Creation Steps:
1. trigger set to none hence any changes in code at GitHub will not run the build in Azure pipeline.
2. Install kubectl and git on the RHEL machine
3. Clone the git repo in RHEL and run the kube_manifests which is incorporated in vm.tf file
