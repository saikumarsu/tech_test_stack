

/*
resource "aws_security_group" "eks-efs" {
  name        = "terraform-efs"
  description = "Communication to efs"
  vpc_id      = aws_vpc.eks-vpc.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "terraform-efs"
  }
}

resource "aws_efs_file_system" "eks-efs" {
  creation_token = "efs-sc"
  tags = {
    Name = "EKS"
  }
}

resource "aws_efs_mount_target" "efs-mount" {
  count          = "${length(data.aws_availability_zones.available.names)}"
  file_system_id = aws_efs_file_system.eks-efs.id
  subnet_id      = aws_subnet.eks-subnet.*.id[count.index]
  security_groups = ["${aws_security_group.eks-efs.id}"]
}

resource "aws_efs_access_point" "efs-access" {
  file_system_id = aws_efs_file_system.eks-efs.id
}

*/




