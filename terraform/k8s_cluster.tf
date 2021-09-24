resource "azurerm_kubernetes_cluster" "k8s_postfacto" {
  name                = var.k8s_cluster_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = var.k8s_cluster_dns_prefix

  default_node_pool {
    name                  = "main"
    enable_auto_scaling   = true
    enable_node_public_ip = false
    node_count            = 1
    min_count             = 1
    max_count             = 10
    type                  = "VirtualMachineScaleSets"
    vm_size               = "Standard_A2_v2"
    availability_zones    = ["1", "2", "3"]
  }

  service_principal {
    client_id     = var.appID
    client_secret = var.password
  }

  role_based_access_control {
    enabled = true
  }

  tags = {
    source = "Terraform"
  }

  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "databases" {
  name                  = "databases"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s_postfacto.id
  enable_auto_scaling   = true
  node_count            = 1
  min_count             = 1
  max_count             = 10
  vm_size               = "Standard_DS1_v2"
  os_type               = "Linux"
  mode                  = "User"
  availability_zones    = ["1", "2", "3"]
  node_labels = {
    "node.kubernetes.io/workload" = "databases"
  }

  tags = {
    source = "Terraform"
  }

  lifecycle {
    ignore_changes = [node_count]

  }
  depends_on = [azurerm_kubernetes_cluster.k8s_postfacto]
}

resource "azurerm_kubernetes_cluster_node_pool" "applications" {
  name                  = "applications"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.k8s_postfacto.id
  enable_auto_scaling   = true
  node_count            = 1
  min_count             = 1
  max_count             = 10
  vm_size               = "Standard_DS1_v2"
  os_type               = "Linux"
  mode                  = "User"
  availability_zones    = ["1", "2", "3"]
  node_labels = {
    "node.kubernetes.io/workload" = "applications"
  }

  tags = {
    environment = "production"
    source      = "Terraform"
  }

  depends_on = [azurerm_kubernetes_cluster.k8s_postfacto]

  lifecycle {
    ignore_changes = [node_count]
  }


}

resource "azurerm_public_ip" "k8s_lb_public_ip" {
  name                = "nmbrs-task02-lb-publicIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_kubernetes_cluster.k8s_postfacto.node_resource_group
  sku                 = "Standard"
  allocation_method   = "Static"
  ip_version          = "IPv4"
  domain_name_label   = "nmbrs-api"
  tags = {
    source = "Terraform"
  }


  depends_on = [azurerm_kubernetes_cluster.k8s_postfacto]


}



