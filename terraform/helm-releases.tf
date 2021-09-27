## ingress release
resource "helm_release" "ingress_nginx" {
  name            = "ingress-nginx"
  repository      = "https://kubernetes.github.io/ingress-nginx"
  chart           = "ingress-nginx"
  cleanup_on_fail = true
  namespace       = "ingress"

  values = [
    file("${path.root}/../helm/values/ingress-nginx.values.yaml")
  ]

  set {
    name  = "controller.service.loadBalancerIP"
    value = azurerm_public_ip.k8s_lb_public_ip.ip_address
  }

  #  set {
  #    name  = "controller.service.annotations.service\\.beta\\.kubernetes\\.io/azure-dns-label-name"
  #    value = azurerm_public_ip.k8s_lb_public_ip.fqdn
  #    type  = "string"
  #  }

  depends_on = [
    azurerm_kubernetes_cluster.k8s_postfacto,
    azurerm_public_ip.k8s_lb_public_ip,
    kubernetes_namespace.ingress,
  ]
}

## postfacto-v1
resource "helm_release" "postfacto_v1" {
  name            = "postfacto-v1"
  repository      = "${path.root}/../helm/charts"
  chart           = "postfacto"
  cleanup_on_fail = true
  namespace       = "postfacto"

  values = [
    file("${path.root}/../helm/values/postfacto-v1.values.yaml")
  ]

  depends_on = [
    azurerm_kubernetes_cluster.k8s_postfacto,
    kubernetes_namespace.postfacto,
    azurerm_managed_disk.postfacto_v1_redis,
    azurerm_managed_disk.postfacto_v1_postgresql,
    kubernetes_persistent_volume.postfacto_v1_postgresql_data,
    kubernetes_persistent_volume.postfacto_v1_redis_data,
    kubernetes_persistent_volume_claim.postfacto_v1_postgresql_data_claim,
    kubernetes_persistent_volume_claim.postfacto_v1_postgresql_data_claim,
  ]
}

## postfacto-v2
resource "helm_release" "postfacto_v2" {
  name            = "postfacto-v2"
  repository      = "${path.root}/../helm/charts"
  chart           = "postfacto"
  cleanup_on_fail = true
  namespace       = "postfacto"

  values = [
    file("${path.root}/../helm/values/postfacto-v2.values.yaml")
  ]

  depends_on = [
    azurerm_kubernetes_cluster.k8s_postfacto,
    kubernetes_namespace.postfacto,
    azurerm_managed_disk.postfacto_v2_redis,
    azurerm_managed_disk.postfacto_v2_postgresql,
    kubernetes_persistent_volume.postfacto_v2_postgresql_data,
    kubernetes_persistent_volume.postfacto_v2_redis_data,
    kubernetes_persistent_volume_claim.postfacto_v2_postgresql_data_claim,
    kubernetes_persistent_volume_claim.postfacto_v2_postgresql_data_claim,
  ]
}
