terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "2.56.0"
      
    }
    
  }
}

provider "azurerm" {
    
  # Configuration options
  features {

  }
}

resource "azurerm_resource_group" "main" {
  name     = var.MainRG
  location = var.region
}


