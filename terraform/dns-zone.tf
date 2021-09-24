
resource "azurerm_dns_zone" "k8s_domain" {
  name                = var.k8s_cluster_dns_zone
  resource_group_name = azurerm_resource_group.rg.name
  tags = {
    source = "Terraform"
  }

  lifecycle {
    ignore_changes = [number_of_record_sets]
  }
}

resource "azurerm_dns_cname_record" "k8s_cname" {
  name                = "postfacto"
  resource_group_name = azurerm_resource_group.rg.name
  zone_name           = azurerm_dns_zone.k8s_domain.name
  ttl                 = 60
  record              = azurerm_public_ip.k8s_lb_public_ip.fqdn
  tags = {
    environment = "production"
    source      = "Terraform"
  }
  depends_on = [azurerm_kubernetes_cluster.k8s_postfacto, azurerm_dns_zone.k8s_domain]


}