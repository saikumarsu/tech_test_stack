/*
variable "private_subnet_ids" {
  description = "List of private subnet IDs"
  default = ["subnet-0c7c894adbea22857", "subnet-08f3bf3c8bb885d3d", "subnet-022ce16ca21b1bc19"]
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
  type        = list(string)
}
*/

variable "cluster-name" {
  default = "terraform-eks"
  type    = string
}

/*
variable "public_subnets" {
  description = "List of public subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
}

variable "private_app_subnets" {
  description = "List of private app subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
}

variable "private_data_subnets" {
  description = "List of private data subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones"
  default     = ["eu-west-1a", "eu-west-1b", "eu-west-1c"]
}
*/
