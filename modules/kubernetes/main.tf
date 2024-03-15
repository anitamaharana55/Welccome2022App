resource "azurerm_resource_group" "resource_group" {
  name     = "${var.resource_group}"
  location = var.location
}

provider "azurerm" {
  //version = "~>2.0.0"
  features {}
}
resource "azurerm_kubernetes_cluster" "terraform-k8s" {
  name                = "${var.cluster_name}"
  location            = azurerm_resource_group.resource_group.location
  resource_group_name = azurerm_resource_group.resource_group.name
  dns_prefix          = var.dns_prefix

  linux_profile {
    admin_username = "ubuntu"

    ssh_key {
      key_data = file(var.ssh_public_key)
    }
  }

  default_node_pool {
    name            = "agentpool"
    node_count      = var.node_count
    vm_size         = "Standard_DS2_v2"
    # vm_size         = "standard_d2as_v5"      CHANGE IF AN ERROR ARISES 
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }

  tags = {
    Environment = var.environment
  }
}