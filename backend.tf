terraform {
  backend "azurerm" {
    resource_group_name  = "digi-tfstate-rg"
    storage_account_name = "digidevstate"
    container_name       = "tfstatecontainer"
    key                  = "dev-terraform.tfstate"
  }
}
