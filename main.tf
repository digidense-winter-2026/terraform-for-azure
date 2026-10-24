resource "azurerm_resource_group" "mainvg" {
  location = "eastus2"
  name     = "digi-acc-rg"
}

data "azurerm_subscription" "main" {
  subscription_id = "b04c64e3-9b14-4b9b-a8a2-70791013f622"
}


resource "azuread_user" "user" {
  display_name          = "Rakesh dev"
  user_principal_name   = "rakesh_dev@digidense.com"
  password              = "P@ssw0rd123"
  force_password_change = true
}

resource "azurerm_role_assignment" "role_attachment" {
  principal_id = azuread_user.user.object_id
  scope        = data.azurerm_subscription.main.id
  role_definition_name = "Reader"
}

