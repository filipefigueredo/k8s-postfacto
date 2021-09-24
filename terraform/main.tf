
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.71.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.5.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate9512"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  required_version = ">= 0.14"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {

  subscription_id = var.subscriptionID
  client_id       = var.appID
  client_secret   = var.password
  tenant_id       = var.tenantID
  features {}
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resourceGroupName
  location = var.location
  tags = {
    "source"      = "Terraform"
  }
}








