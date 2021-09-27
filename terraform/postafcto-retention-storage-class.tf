## Create a storage class in case we decido to use dynamic disks
resource "kubernetes_storage_class" "retention_standard_ssd" {
  metadata {
    name = "postfacto-retention"
    labels = {
      "app.kubernetes.io/name"       = "postgresql"
      "app.kubernetes.io/component"  = "persistent-volume"
      "app.kubernetes.io/part-of"    = "postfacto"
      "app.kubernetes.io/managed-by" = "Terraform"
    }

  }
  storage_provisioner = "kubernetes.io/azure-disk"
  reclaim_policy      = "Retain"

  parameters = {
    storageaccounttype = "StandardSSD_LRS"
    kind               = "Managed"
    cachingmode        = "ReadOnly"
  }

  depends_on = [azurerm_kubernetes_cluster.k8s_postfacto]
}
