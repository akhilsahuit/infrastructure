terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.46.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

# Creating a Resource Group
resource "azurerm_resource_group" "kgs_rg" {
  name     = "${var.prefix}-rg"
  location = "Central India"
}

# Creating a VNet
resource "azurerm_virtual_network" "kgs_vnet" {
  name                = "${var.prefix}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.kgs_rg.location
  resource_group_name = azurerm_resource_group.kgs_rg.name
}

# Creating a subnet
resource "azurerm_subnet" "kgs_subnet" {
  name                 = "${var.prefix}-subnet01"
  resource_group_name  = azurerm_resource_group.kgs_rg.name
  virtual_network_name = azurerm_virtual_network.kgs_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "kgs_nic" {
  name                = "${var.prefix}-nic"
  location            = azurerm_resource_group.kgs_rg.location
  resource_group_name = azurerm_resource_group.kgs_rg.name

  ip_configuration {
    name                          = "config1"
    subnet_id                     = azurerm_subnet.kgs_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

# Creating a VM
resource "azurerm_windows_virtual_machine" "kgs_vm" {
  name                = "${var.prefix}-vm"
  resource_group_name = azurerm_resource_group.kgs_rg.name
  location            = azurerm_resource_group.kgs_rg.location
  size                = "Standard_F2"
  admin_username      = "adminuser"
  admin_password      = "P@$$w0rd1234!"
  network_interface_ids = [
    azurerm_network_interface.kgs_nic.id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2016-Datacenter"
    version   = "latest"
  }

  tags = {
    company = "kgs"
  }
}

output "azurerm_virtual_machine" {
  value       = azurerm_windows_virtual_machine.kgs_vm.name
  description = "Name of the Azure VM."
}
