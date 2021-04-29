resource "azurerm_virtual_network" "main" {
  name                = "tfdemo-vnet"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = ["10.0.0.0/16"]
  
}


resource "azurerm_subnet" "Apps" {
  name = "Apps"
  resource_group_name = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "Web" {
  name = "Web"
  resource_group_name = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.2.0/24"]
}


resource "azurerm_public_ip" "Web1" {
  count = var.vmcount
  name                = "${var.webvmname}-pip-${count.index+1}"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  allocation_method   = "Static"

}

# azurerm_public_ip.Web1.*.id = [web-pip-1, web-pip-2, web-pip-3]



resource "azurerm_network_interface" "Web1" {
  count               = var.vmcount
  name                = "${var.webvmname}-nic-${count.index+1}"                          
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.Web.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = element(azurerm_public_ip.Web1.*.id, count.index)
                                
                           
  }
}

#azurerm_network_interface.Web1.*.name = [web-nic-1, web-nic-2, web-nic-3]




