
data "azurerm_resource_group" "azure_rg_existing" {
    name = "tuxvalidations"
}

resource "azurerm_virtual_network" "image_testing_vnet" {
  name                = "image-testing-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = data.azurerm_resource_group.azure_rg_existing.location
  resource_group_name = data.azurerm_resource_group.azure_rg_existing.name
}

resource "azurerm_subnet" "image_testing_subnet" {
  name                 = "internal"
  resource_group_name  = data.azurerm_resource_group.azure_rg_existing.name
  virtual_network_name = azurerm_virtual_network.image_testing_vnet.name
  address_prefix       = "10.0.2.0/24"
}

resource "azurerm_network_interface" "gen1_nic" {
  name                = "image-gen1-nic"
  location            = data.azurerm_resource_group.azure_rg_existing.location
  resource_group_name = data.azurerm_resource_group.azure_rg_existing.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.image_testing_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface" "gen2_nic" {
  name                = "image-gen2-nic"
  location            = data.azurerm_resource_group.azure_rg_existing.location
  resource_group_name = data.azurerm_resource_group.azure_rg_existing.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.image_testing_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}