data "template_file" "cloudinit" {                                                                                              
   template = file("${path.module}/Templates/cloudint_web.tpl")
 }


resource "azurerm_virtual_machine" "Web1" {
  count = var.vmcount
  name                  = "${var.webvmname}${count.index+1}"
  location              = azurerm_resource_group.main.location
  resource_group_name   = azurerm_resource_group.main.name
  network_interface_ids = [element(azurerm_network_interface.Web1.*.id, count.index)]
  vm_size               = var.webvmsize

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.webvmname}disk${count.index+1}"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "${var.webvmname}${count.index+1}"
    admin_username = var.admin_user
    admin_password = var.password
    custom_data    = data.template_file.cloudinit.rendered
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  
}




#azurerm_network_interface.Web1.*.name = [web-nic-1, web-nic-2, web-nic-3]
