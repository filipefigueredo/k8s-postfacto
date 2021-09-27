## create ingress namespace
resource "kubernetes_namespace" "ingress" {
  metadata {
    name = "ingress"
    labels = {
      "app.kubernetes.io/name"       = "ingress"
      "app.kubernetes.io/part-of"    = "ingress"
      "app.kubernetes.io/managed-by" = "Terraform"
    }


  }
  depends_on = [azurerm_kubernetes_cluster.k8s_postfacto]
}

## create postafacto namespace
resource "kubernetes_namespace" "postfacto" {
  metadata {
    name = "postfacto"
    labels = {
      "app.kubernetes.io/name"       = "postfacto"
      "app.kubernetes.io/part-of"    = "postfacto"
      "app.kubernetes.io/managed-by" = "Terraform"
    }


  }
  depends_on = [azurerm_kubernetes_cluster.k8s_postfacto]
}
