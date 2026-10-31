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
  principal_id         = azuread_user.user.object_id
  scope                = data.azurerm_subscription.main.id
  role_definition_name = "Reader"
}


resource "azurerm_role_definition" "role_definition" {
  name  = "CustomeRole-Storage-Writer"
  scope = data.azurerm_subscription.main.id
  permissions {
    actions = [
      "Microsoft.Storage/storageAccounts/read",
      "Microsoft.Storage/storageAccounts/write",
      "Microsoft.Storage/storageAccounts/delete",
      "Microsoft.Storage/storageAccounts/blobServices/containers/write",
      "Microsoft.Storage/storageAccounts/blobServices/containers/delete",
      "Microsoft.Storage/storageAccounts/blobServices/containers/read",
      "Microsoft.Resources/deployments/validate/action",
      "Microsoft.Resources/deployments/write",
      "Microsoft.Resources/deployments/read",
      "Microsoft.Resources/deployments/delete",
      "Microsoft.Resources/deployments/cancel/action",
      "Microsoft.Resources/deployments/whatIf/action",
      "Microsoft.Resources/deployments/exportTemplate/action",
      "Microsoft.Storage/storageAccounts/fileServices/read",
      "Microsoft.Storage/storageAccounts/fileServices/write",
      "Microsoft.Storage/storageAccounts/fileServices/generateUserDelegationKey/action",
      "Microsoft.Storage/storageAccounts/blobServices/read",
      "Microsoft.Storage/storageAccounts/blobServices/write",
      "Microsoft.Storage/storageAccounts/blobServices/generateUserDelegationKey/action",
      "Microsoft.Storage/storageAccounts/blobServices/containers/setAcl/action",
      "Microsoft.Storage/storageAccounts/blobServices/containers/getAcl/action",
      "Microsoft.Storage/storageAccounts/blobServices/containers/lease/action",
      "Microsoft.Storage/storageAccounts/blobServices/containers/clearLegalHold/action",
      "Microsoft.Storage/storageAccounts/blobServices/containers/setLegalHold/action"
    ]
    not_actions = []
    data_actions = [
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/write",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/delete",
      "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/deleteBlobVersion/action"
    ]
    not_data_actions = []
  }
}

resource "azurerm_role_assignment" "custom_role" {
  principal_id         = azuread_user.user.object_id
  role_definition_name = azurerm_role_definition.role_definition.name
  scope                = data.azurerm_subscription.main.id

  depends_on = [azurerm_role_definition.role_definition, azuread_user.user]
}


