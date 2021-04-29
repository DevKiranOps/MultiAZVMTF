
resource "azurerm_network_security_group" "Web" {
  name                = "tfdemo-web-nsg"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
}

resource "azurerm_network_security_rule" "SSH" {
  name                        = "SSH_TO_HOME"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "103.159.227.0/24"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.Web.name
}


resource "azurerm_network_security_rule" "HTTP" {
  name                        = "HTTP"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.main.name
  network_security_group_name = azurerm_network_security_group.Web.name
}


resource "azurerm_subnet_network_security_group_association" "Web" {
  subnet_id                 = azurerm_subnet.Web.id
  network_security_group_id = azurerm_network_security_group.Web.id
}