# pvc
resource "kubernetes_persistent_volume_claim" "prom_pvc" {
  depends_on = [
    kubernetes_namespace.namespace,
  ]
  metadata {
    name      = "tf-prometheus-pvc"
    annotations = {
      "volume.beta.kubernetes.io/storage-class" = "eks-efs" 
    }
    namespace = "monitoring"
    labels = {
      vol = "prom-store-pvc"
    }
  }
  spec {
    access_modes = ["ReadWriteMany"]
    resources {
      requests = {
        storage = "5Gi"
      }
    }
  }
}



