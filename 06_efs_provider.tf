/*
data "aws_efs_file_system" "eks-efs" {
    creation_token = "efs-sc"
}

output "eks-efs" {
    value = data.aws_efs_file_system.eks-efs
}

resource "kubernetes_namespace" "namespace" {
  metadata {
    name = "monitoring"
  }
}
*/

