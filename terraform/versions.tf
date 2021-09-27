

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=2.78.0"
    }

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.5.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "2.3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate9512"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
  required_version = ">= 1.0.0"
}
