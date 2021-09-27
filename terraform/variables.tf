variable "aks_service_principal_app_id" {
  description = "Application ID/Client ID  of the service principal. Used by AKS to manage AKS related resources on Azure like vms, subnets."
}

variable "aks_service_principal_client_secret" {
  description = "Secret of the service principal. Used by AKS to manage Azure."
}


variable "resource_group_name" {
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Location of your resource group"
}

variable "k8s_cluster_dns_prefix" {
  type        = string
  description = "DNS prefix"
}

variable "k8s_cluster_dns_zone" {
  type        = string
  description = "DNS zone name"
}

variable "k8s_cluster_name" {
  type        = string
  description = "Cluster name"
}


variable "k8s_postfacto_v1_redis_volume_name" {
  type        = string
  description = "Postfacto v1 - Redis volume name"
}

variable "k8s_postfacto_v1_postgresql_volume_name" {
  type        = string
  description = "Postfacto v1 - postgreSQL volume name"
}

variable "k8s_postfacto_v2_redis_volume_name" {
  type        = string
  description = "Postfacto v2 - Redis volume name"
}

variable "k8s_postfacto_v2_postgresql_volume_name" {
  type        = string
  description = "Postfacto v2 - postgreSQL volume name"
}

#variable "tls_certificate_b64" {
#type        = string
#description = "Domain TLS Certificate (base64)"
#sensitive = true
#}

#variable "certificate_private_key_b64" {
#type        = string
#description = "Private key (base64)"
#sensitive = true
#}
