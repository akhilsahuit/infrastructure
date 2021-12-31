# kgs
With this assignment below resources are created in Azure:
1) Resource Group
2) VNet
3) Subnet
4) NIC
5) Windows VM
6) OS disk

Commands used:
terraform init
terraform plan
terraform apply
terraform destroy
terraform graph > base.dot
terraform graph | dot -Tpng > graph.png

Approach used:
a) Created Service Principal in Azure and assigned Contributer access.
b) Configured mandatory params as env vairables using 'setx'(ARM_CLIENT_ID, ARM_TENANT_ID, ARM_CLIENT_SECRETARM_SUBSCRIPTION_ID) 
c) Terraform local backend has been used for the simplicity purpose *.
* Remote Backend will be covered in the assignment 2.0 (COntinous Integration)

Error faced:
SKUNotAvailable for the VM: Error was resolved by using proper SKU in the Central India Region.