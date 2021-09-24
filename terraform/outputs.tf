output "k8s_public_ip" {
  value = azurerm_public_ip.k8s_lb_public_ip.ip_address
}

output "k8s_fqdn" {
  value = azurerm_public_ip.k8s_lb_public_ip.fqdn
}


output "client_certificate" {
  value = azurerm_kubernetes_cluster.k8s_postfacto.kube_config.0.client_certificate
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.k8s_postfacto.kube_config_raw

  sensitive = true
}
