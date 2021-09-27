# terraform.tfvars

resource_group_name = "nmbrs-challenge-task2"
location            = "West Europe"

k8s_cluster_name       = "nmbrs-api-cluster"
k8s_cluster_dns_prefix = "nmbrs-task2"
k8s_cluster_dns_zone   = "api0.live"

k8s_postfacto_v1_redis_volume_name      = "postfacto-v1-redis-data"
k8s_postfacto_v1_postgresql_volume_name = "postfacto-v1-postgresql-data"
k8s_postfacto_v2_redis_volume_name      = "postfacto-v2-redis-data"
k8s_postfacto_v2_postgresql_volume_name = "postfacto-v2-postgresql-data"
