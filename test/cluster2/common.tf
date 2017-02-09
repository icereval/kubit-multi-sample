/*
Copyright 2017 Michael Goodness

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/

# provider "aws" { region = "${var.aws_region}" }

module "bastion" {
  source = "git::https://github.com/icereval/kubit.git?ref=feature/multi-cluster//modules/bastion"
  cluster_name = "${var.cluster["name"]}"
  public_subnet_id = "${element(module.subnet_public.subnet_ids, 0)}"
  security_groups = ["${module.security_groups.bastion}"]
  ssh_key_name = "${aws_key_pair.key_pair.key_name}"
}

module "iam" {
  source = "git::https://github.com/icereval/kubit.git?ref=feature/multi-cluster//modules/iam"
  assets_bucket_name = "${var.assets_bucket_name}"
  cluster_name = "${var.cluster["name"]}"
}

module "security_groups" {
  source = "git::https://github.com/icereval/kubit.git?ref=feature/multi-cluster//modules/security_groups"
  cluster_name = "${var.cluster["name"]}"
  vpc_cidr_block = "${var.vpc_cidr_block}"
  vpc_id = "${var.vpc_id}"
}

module "subnet_public" {
  source = "git::https://github.com/icereval/kubit.git?ref=feature/multi-cluster//modules/subnet_public"
  internet_gateway_id = "${var.internet_gateway_id}"
  name = "${var.cluster["name"]}"
  region = "${var.aws_region}"
  subnets = "${var.subnets}"
  vpc_id = "${var.vpc_id}"
}

module "subnet_private" {
  source = "git::https://github.com/icereval/kubit.git?ref=feature/multi-cluster//modules/subnet_private"
  nat_gateway_ids = "${var.nat_gateway_ids}"
  name = "${var.cluster["name"]}"
  region = "${var.aws_region}"
  subnets = "${var.subnets}"
  vpc_id = "${var.vpc_id}"
}

resource "aws_key_pair" "key_pair" {
  key_name = "${var.cluster["name"]}"
  public_key = "${file(format("${path.module}/keys/%s.pub", var.cluster["name"]))}"
}
