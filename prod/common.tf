provider "aws" { region = "${var.aws_region}" }

module "common_dns" {
  source = "git::https://github.com/icereval/kubit.git?ref=feature/multi-cluster//modules/common_dns"
  domain_names = "${var.domain_names}"
  vpc_id = "${module.vpc.vpc_id}"
}

module "vpc" {
  source = "git::https://github.com/icereval/kubit.git?ref=feature/multi-cluster//modules/vpc"
  cidr_block = "${var.vpc_cidr_block}"
  name = "${var.environment_name}"
  region = "${var.aws_region}"
}

module "subnet_public" {
  source = "git::https://github.com/icereval/kubit.git?ref=feature/multi-cluster//modules/subnet_public"
  internet_gateway_id = "${module.vpc.internet_gateway_id}"
  name = "${var.environment_name}"
  region = "${var.aws_region}"
  subnets = "${var.subnets}"
  vpc_id = "${module.vpc.vpc_id}"
}

module "nat_gateway" {
  source = "git::https://github.com/icereval/kubit.git?ref=feature/multi-cluster//modules/nat_gateway"
  public_subnet_ids = ["${module.subnet_public.subnet_ids}"]
  subnets = "${var.subnets}"
}

module "subnet_private" {
  source = "git::https://github.com/icereval/kubit.git?ref=feature/multi-cluster//modules/subnet_private"
  nat_gateway_ids = "${module.nat_gateway.gateway_ids}"
  name = "${var.environment_name}"
  region = "${var.aws_region}"
  subnets = "${var.subnets}"
  vpc_id = "${module.vpc.vpc_id}"
}
