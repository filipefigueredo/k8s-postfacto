
resource "kubernetes_service" "postfacto_v2_external_service" {
  metadata {
    name      = "postfacto-v2-external-service"
    namespace = "ingress"
    labels = {
      "app.kubernetes.io/name" : "postfacto"
      "app.kubernetes.io/instance" : "postfacto"
      "app.kubernetes.io/component" : "ingress"
      "app.kubernetes.io/part-of" : "postfacto"
    }
  }
  spec {
    type          = "ExternalName"
    external_name = "postfacto-v2.postfacto.svc.cluster.local"
  }

  depends_on = [
    kubernetes_namespace.ingress,
    azurerm_kubernetes_cluster.k8s_postfacto,
    helm_release.postfacto_v2,
  ]
}

resource "kubernetes_ingress" "postfacto_routes" {
  wait_for_load_balancer = true

  metadata {
    name      = "postfacto-routes"
    namespace = "ingress"
    labels = {
      "app.kubernetes.io/name" : "postfacto"
      "app.kubernetes.io/instance" : "postfacto"
      "app.kubernetes.io/component" : "ingress"
      "app.kubernetes.io/part-of" : "postfacto"
    }
    annotations = {
      //"kubernetes.io/ingress.class" : "nginx"
      "nginx.ingress.kubernetes.io/ssl-redirect" : "true"
      "nginx.ingress.kubernetes.io/configuration-snippet" = <<EOF
          if ( $http_x_postfacto_version = "4.1.0" ){
          proxy_pass http://postfacto-v1.postfacto.svc.cluster.local:80;
          }

          if ( $http_x_postfacto_version = "4.2.0" ){
          proxy_pass http://postfacto-v2.postfacto.svc.cluster.local:80;
          }
        EOF
    }
  }
  spec {
    ingress_class_name = "nginx"
    rule {
      host = "postfacto.api0.live"
      http {
        path {
          path = "/"
          backend {
            service_name = kubernetes_service.postfacto_v2_external_service.metadata.0.name
            service_port = 80
          }
        }
      }
    }
    tls {
      secret_name = "postfacto.api0.live-tls.secret"
      hosts       = ["postfacto.api0.live"]

    }

  }


  depends_on = [
    azurerm_kubernetes_cluster.k8s_postfacto,
    kubernetes_namespace.ingress,
    helm_release.ingress_nginx,
    helm_release.postfacto_v1,
    helm_release.postfacto_v2,
    kubernetes_service.postfacto_v2_external_service
  ]
}
