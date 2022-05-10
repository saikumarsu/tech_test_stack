provider "aws" {
  region = "eu-west-1"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

/*
provider "kubectl" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  config_path = "~/.kube/config"
}
*/


provider "kubernetes" {
  #host                   = data.aws_eks_cluster.eks-cluster.endpoint
  #cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks-cluster.certificate_authority.0.data)
  #token                  = data.aws_eks_cluster_auth.eks-cluster.token
  config_path    = "~/.kube/config"
  config_context = "arn:aws:eks:eu-west-1:830132395139:cluster/terraform-eks"
}


data "aws_region" "current" {}

data "aws_availability_zones" "available" {
  state = "available"
}

provider "http" {}




