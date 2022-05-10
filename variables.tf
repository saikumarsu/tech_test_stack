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

