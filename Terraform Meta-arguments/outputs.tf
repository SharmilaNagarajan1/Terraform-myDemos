output "resource_group_name" {
  value = azurerm_resource_group.rg[*].name
}

output "storage_account_names" {
    value = [for sa in azurerm_storage_account.storage : sa.name]
  
}