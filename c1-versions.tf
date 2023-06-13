# Terraform Block
terraform {
  required_version = ">= 1.4.6"
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = ">= 3.50.0" 
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 1.0"
    }
  }
# Terraform State Storage to Azure Storage Container
  backend "azurerm" {
    resource_group_name   = "ibrahim-san-RG"
    storage_account_name  = "trteststatefile01"
    container_name        = "tfstatefiles01"
    key                   = "AKSter007raform.tfstate"
  }  
}

# Provider Block
provider "azurerm" {
 features {}          
}


