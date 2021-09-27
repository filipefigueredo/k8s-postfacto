# Configure the Microsoft Azure Provider
provider "azurerm" {

  #subscription_id = var.subscriptionID
  #client_id       = var.aks_service_principal_app_id
  #client_secret   = var.password
  #tenant_id       = var.tenantID
  features {}
}

provider "kubernetes" {
  host                   = azurerm_kubernetes_cluster.k8s_postfacto.kube_config.0.host
  username               = azurerm_kubernetes_cluster.k8s_postfacto.kube_config.0.username
  password               = azurerm_kubernetes_cluster.k8s_postfacto.kube_config.0.password
  client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s_postfacto.kube_config.0.client_certificate)
  client_key             = base64decode(azurerm_kubernetes_cluster.k8s_postfacto.kube_config.0.client_key)
  cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s_postfacto.kube_config.0.cluster_ca_certificate)
}

provider "helm" {
  kubernetes {
    host                   = azurerm_kubernetes_cluster.k8s_postfacto.kube_config.0.host
    username               = azurerm_kubernetes_cluster.k8s_postfacto.kube_config.0.username
    password               = azurerm_kubernetes_cluster.k8s_postfacto.kube_config.0.password
    client_certificate     = base64decode(azurerm_kubernetes_cluster.k8s_postfacto.kube_config.0.client_certificate)
    client_key             = base64decode(azurerm_kubernetes_cluster.k8s_postfacto.kube_config.0.client_key)
    cluster_ca_certificate = base64decode(azurerm_kubernetes_cluster.k8s_postfacto.kube_config.0.cluster_ca_certificate)
  }
}

# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
  tags = {
    "source" = "Terraform"
  }
}








