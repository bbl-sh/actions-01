provider "random" {}
resource "random_string" "random" {
  length  = 6
  special = false
  upper   = false
}
provider "azurerm" {
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id

  features {}
}
# Resource Group
resource "azurerm_resource_group" "dev" {
  name     = "rg-dev"
  location = "Central India" # You can change this region if needed
}

# Development Storage Account
resource "azurerm_storage_account" "dev_storage" {
  name                     = "devstorageacct${random_string.random.result}"
  resource_group_name      = azurerm_resource_group.dev.name
  location                 = azurerm_resource_group.dev.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }
}

# Staging Storage Account
resource "azurerm_storage_account" "stage_storage" {
  name                     = "stagestorageacct${random_string.random.result}"
  resource_group_name      = azurerm_resource_group.dev.name
  location                 = azurerm_resource_group.dev.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }
}

# Production Storage Account
resource "azurerm_storage_account" "prod_storage" {
  name                     = "prodstorageacct${random_string.random.result}"
  resource_group_name      = azurerm_resource_group.dev.name
  location                 = azurerm_resource_group.dev.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  static_website {
    index_document     = "index.html"
    error_404_document = "404.html"
  }
}

# Output the URLs of the static websites
output "dev_storage_url" {
  value = azurerm_storage_account.dev_storage.primary_web_endpoint
}

output "stage_storage_url" {
  value = azurerm_storage_account.stage_storage.primary_web_endpoint
}

output "prod_storage_url" {
  value = azurerm_storage_account.prod_storage.primary_web_endpoint
}

# Testing the application

# provider "random" {}
# resource "random_string" "random" {
#   length  = 6
#   special = false
#   upper   = false
# }
# provider "azurerm" {
#   subscription_id = var.subscription_id
#   client_id       = var.client_id
#   client_secret   = var.client_secret
#   tenant_id       = var.tenant_id

#   features {}
# }


# # Development Environment
# resource "azurerm_resource_group" "dev" {
#   name     = "rg-dev"
#   location = "Central India" # Aap change kr lena apne according
# }

# resource "azurerm_storage_account" "dev_storage" {
#   name                     = "devstorageacct${random_string.random.result}"
#   resource_group_name      = azurerm_resource_group.dev.name
#   location                 = azurerm_resource_group.dev.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

# # Staging Environment
# resource "azurerm_resource_group" "stage" {
#   name     = "rg-stage"
#   location = "Central India" # Aap change kr lena apne according
# }

# resource "azurerm_storage_account" "stage_storage" {
#   name                     = "stagestorageacct${random_string.random.result}"
#   resource_group_name      = azurerm_resource_group.stage.name
#   location                 = azurerm_resource_group.stage.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

# # Production Environment
# resource "azurerm_resource_group" "prod" {
#   name     = "rg-prod"
#   location = "Central India" # Aap change kr lena apne according
# }

# resource "azurerm_storage_account" "prod_storage" {
#   name                     = "prodstorageacct${random_string.random.result}"
#   resource_group_name      = azurerm_resource_group.prod.name
#   location                 = azurerm_resource_group.prod.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }
