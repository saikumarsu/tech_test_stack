
resource "aws_vpc" "eks-vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    "Name" =  "terraform-eks-node"
    "kubernetes.io/cluster/terraform-eks" =  "shared"
  }
}

resource "aws_subnet" "eks-subnet" {
  count = "${length(data.aws_availability_zones.available.names)}"
  availability_zone       = "${data.aws_availability_zones.available.names[count.index]}"
  cidr_block              = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  vpc_id                  = aws_vpc.eks-vpc.id
  tags = {
    "Name" =  "terraform-eks-node"
    "kubernetes.io/cluster/terraform-eks" =  "shared"
  }
}

resource "aws_internet_gateway" "eks-ig" {
  vpc_id = aws_vpc.eks-vpc.id
  tags = {
    Name = "terraform-eks"
  }
}

resource "aws_route_table" "eks-rt" {
  vpc_id = aws_vpc.eks-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.eks-ig.id
  }
}

resource "aws_route_table_association" "eks-rta" {
  count = "${length(data.aws_availability_zones.available.names)}"
  subnet_id      = aws_subnet.eks-subnet.*.id[count.index]
  route_table_id = aws_route_table.eks-rt.id
}
