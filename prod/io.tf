variable "assets_bucket_name" {}
variable "aws_region" {}
variable "domain_names" { type = "map" }
variable "ebs_encrypted" {}
variable "environment_name" {}
variable "kms_key_id" {}
variable "subnets" { type = "map" }
variable "vpc_cidr_block" {}
