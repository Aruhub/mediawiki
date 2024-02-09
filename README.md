1.Create a Bakcend Storage Account to store the state in remote
2. Create a Service Connection in AzDO, which connects to Azure to create resources in Azure Portal
3. Install Terraform Extensions in AzDo which help us to install Terraform and run TF commands
4. Create a pipeline with two stages, one to validate the terraform and other to deploy RHEL VM.
5. After VM creation, it install git, kubectl 
