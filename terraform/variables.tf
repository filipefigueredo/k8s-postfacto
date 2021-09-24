variable "subscriptionID" {
  type        = string
  description = "Subscription ID"
}

variable "appID" {
  description = "Azure Kubernetes Service Cluster service principal"
}

variable "password" {
  description = "Azure Kubernetes Service Cluster password"
}

variable "tenantID" {
  description = "Azure Kubernetes Service Cluster tenant ID"
}

variable "resourceGroupName" {
  type        = string
  description = "Name of the resource group"
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

