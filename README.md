With this assignment below resources are created in Azure:
1) Resource Group
2) VNet
3) Subnet
4) NIC
5) Windows VM
6) OS disk

Commands used:
1) terraform init
2) terraform plan
3) terraform apply
4) terraform destroy
5) terraform graph > base.dot
6) terraform graph | dot -Tpng > graph.png

Approach used:
1) Created Service Principal in Azure and assigned Contributer access.
2) Configured mandatory params as env vairables using 'setx'(ARM_CLIENT_ID, ARM_TENANT_ID, ARM_CLIENT_SECRETARM_SUBSCRIPTION_ID) 
3) Terraform local backend has been used for the simplicity purpose *.
4) * Remote Backend will be covered in the assignment 2.0 (COntinous Integration)

Error faced:
SKUNotAvailable for the VM: Error was resolved by using proper SKU in the Central India Region.