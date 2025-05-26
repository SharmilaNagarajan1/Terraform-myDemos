
resource "azurerm_service_plan" "service-plan" {
  name                = "demo-az-sp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1"
}

resource "azurerm_linux_web_app" "webapp1" {
  name                = "demo-webapp1-login"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.service-plan.id

  site_config {}
}

resource "azurerm_linux_web_app" "webapp2" {
  name                = "demo-webapp2-checkout"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.service-plan.id

  site_config {}
}

