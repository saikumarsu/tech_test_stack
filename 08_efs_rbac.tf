
/*
resource "kubernetes_cluster_role_binding" "cluster-role" {
  depends_on = [
    kubernetes_namespace.namespace
  ]
  metadata {
    name = "nfs-provisioner-role-binding"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "cluster-admin"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "default"
    namespace = "monitoring"
  }
}
*/

