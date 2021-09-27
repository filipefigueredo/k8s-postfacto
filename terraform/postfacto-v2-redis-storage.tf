
## Persistent volume claim
resource "kubernetes_persistent_volume_claim" "postfacto_v2_redis_data_claim" {
  metadata {
    name      = "${var.k8s_postfacto_v2_redis_volume_name}-claim"
    namespace = kubernetes_namespace.postfacto.metadata.0.name
    labels = {
      "app.kubernetes.io/name"       = "redis"
      "app.kubernetes.io/component"  = "persistent-volume-claim"
      "app.kubernetes.io/part-of"    = "postfacto"
      "app.kubernetes.io/managed-by" = "Terraform"
    }
  }

  spec {
    access_modes       = ["ReadWriteOnce"]
    storage_class_name = ""
    resources {
      requests = {
        storage = "4Gi"
      }
    }

    volume_name = var.k8s_postfacto_v2_redis_volume_name

  }

  depends_on = [kubernetes_namespace.postfacto, azurerm_managed_disk.postfacto_v2_redis]
}




## Persistent volume

resource "kubernetes_persistent_volume" "postfacto_v2_redis_data" {

  metadata {
    name = var.k8s_postfacto_v2_redis_volume_name
    labels = {
      "app.kubernetes.io/name"       = "redis"
      "app.kubernetes.io/component"  = "persistent-volume"
      "app.kubernetes.io/part-of"    = "postfacto"
      "app.kubernetes.io/managed-by" = "Terraform"
    }

  }
  spec {
    access_modes                     = ["ReadWriteMany"]
    persistent_volume_reclaim_policy = "Retain"
    storage_class_name               = ""
    capacity = {
      storage = "4Gi"
    }

    persistent_volume_source {
      azure_disk {
        data_disk_uri = azurerm_managed_disk.postfacto_v2_redis.id
        disk_name     = azurerm_managed_disk.postfacto_v2_redis.name
        kind          = "Managed"
        caching_mode  = "ReadOnly"
        fs_type       = ""
        read_only     = false
      }
    }

    claim_ref {
      name      = "${var.k8s_postfacto_v2_redis_volume_name}-claim"
      namespace = kubernetes_namespace.postfacto.metadata.0.name
    }
  }

  depends_on = [kubernetes_namespace.postfacto, azurerm_managed_disk.postfacto_v2_redis]
}




