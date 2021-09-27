output "k8s_public_ip" {
  value = azurerm_public_ip.k8s_lb_public_ip.ip_address
}

output "k8s_internal_fqdn" {

  value = azurerm_public_ip.k8s_lb_public_ip.fqdn
}

output "postfacto_api_url" {

  value = azurerm_dns_cname_record.k8s_cname.fqdn

}
