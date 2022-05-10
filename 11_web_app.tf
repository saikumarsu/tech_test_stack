/*
resource "kubernetes_deployment" "java" {
  metadata {
    name = "microservice-deployment"
    labels = {
      app  = "java-microservice"
    }
  }
spec {
    replicas = 2
selector {
      match_labels = {
        app  = "java-microservice"
      }
    }
template {
      metadata {
        labels = {
          app  = "java-microservice"
        }
      }
spec {
        container {
          image = "saikumarsu/webapp_java"
          name  = "java-microservice-container"
          port {
            container_port = 30188
         }
        }
      }
    }
  }
}
resource "kubernetes_service" "java" {
  depends_on = [kubernetes_deployment.java]
  metadata {
    name = "java-microservice-service"
  }
  spec {
    selector = {
      app = "java-microservice"
    }
    port {
      port        = 80
      target_port = 8080
    }
type = "LoadBalancer"
}
}
*/
