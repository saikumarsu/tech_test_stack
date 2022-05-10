/*
resource "kubernetes_storage_class" "storage-class" {
  metadata {
    name = "eks-efs"
  }
  storage_provisioner = "eks-sc/eks-efs"
  reclaim_policy      = "Retain"
}

resource "kubernetes_deployment" "storage-provisioner" {
  depends_on = [
      kubernetes_storage_class.storage-class,
      kubernetes_namespace.namespace
  ]
  metadata {
    name = "efs-provisioner"
    namespace = "monitoring"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "efs-provisioner"
      }
    }
    strategy {
      type = "Recreate"
    }
    template {
      metadata {
        labels = {
          app = "efs-provisioner"
        }
      }
      spec {
        automount_service_account_token = true
        container {
          image = "quay.io/external_storage/efs-provisioner:v0.1.0"
          name  = "efs-provisioner"
          env {
            name  = "FILE_SYSTEM_ID"
            value = "${data.aws_efs_file_system.eks-efs.file_system_id}"
          }
          env {
            name  = "AWS_REGION"
            value = "eu-west-1"
          }
          env {
            name  = "PROVISIONER_NAME"
            value = "${kubernetes_storage_class.storage-class.storage_provisioner}"
          }
          volume_mount {
            name       = "pv-volume"
            mount_path = "/persistentvolumes"
          }
        }
        volume {
          name = "pv-volume"
          nfs {
            server = "${data.aws_efs_file_system.eks-efs.dns_name}"
            path   = "/"
          }
        }
      }
    }
  }
}


*/
/*
module "efs_csi_driver" {
  source = "DrFaust92/efs-csi-driver/kubernetes"
  version = "0.12.6"
}

*/
