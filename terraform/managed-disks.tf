
resource "azurerm_managed_disk" "postfacto_v1_redis" {
  name     = "k8s_postfacto_v1_redis_disk"
  location = azurerm_resource_group.rg.location
  # If storage is ZRS, to make  ZRS available at multiple zones, leave the array empty
  # Note: ZRS uses CSI drive, which should be installed if k8s < 1.21.0 
  zones                = [1]
  resource_group_name  = azurerm_kubernetes_cluster.k8s_postfacto.node_resource_group
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = "4"

  tags = {
    source = "Terraform"
  }
}

resource "azurerm_managed_disk" "postfacto_v1_postgresql" {
  name     = "k8s_postfacto_v1_postgresql"
  location = azurerm_resource_group.rg.location
  # If storage is ZRS, to make  ZRS available at multiple zones, leave the array empty
  # Note: ZRS uses CSI drive, which should be installed if k8s < 1.21.0 
  zones                = [1]
  resource_group_name  = azurerm_kubernetes_cluster.k8s_postfacto.node_resource_group
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = "4"

  tags = {
    source = "Terraform"
  }
}



resource "azurerm_managed_disk" "postfacto_v2_redis" {
  name     = "k8s_postfacto_v2_redis_disk"
  location = azurerm_resource_group.rg.location
  # If storage is ZRS, to make  ZRS available at multiple zones, leave the array empty
  # Note: ZRS uses CSI drive, which should be installed if k8s < 1.21.0 
  zones                = [1]
  resource_group_name  = azurerm_kubernetes_cluster.k8s_postfacto.node_resource_group
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = "4"

  tags = {
    source = "Terraform"
  }
}

resource "azurerm_managed_disk" "postfacto_v2_postgresql" {
  name     = "k8s_postfacto_v2_postgresql"
  location = azurerm_resource_group.rg.location
  # If storage is ZRS, to make  ZRS available at multiple zones, leave the array empty
  # Note: ZRS uses CSI drive, which should be installed if k8s < 1.21.0
  zones                = [1]
  resource_group_name  = azurerm_kubernetes_cluster.k8s_postfacto.node_resource_group
  storage_account_type = "StandardSSD_LRS"
  create_option        = "Empty"
  disk_size_gb         = "4"

  tags = {
    source = "Terraform"
  }
}


