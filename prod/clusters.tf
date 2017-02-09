module "cluster1" {
  source = "./cluster1"
  assets_bucket_name = "${var.assets_bucket_name}"
  aws_region = "${var.aws_region}"
  cluster = {
    name = "test-cluster1"
    pods_cidr_block = "10.251.0.0/16"
    services_cidr_block = "10.252.0.0/16"
  }
  domain_names = "${var.domain_names}"
  domain_zone_ids = "${module.common_dns.domain_zone_ids}"
  ebs_encrypted = "${var.ebs_encrypted}"
  hyperkube = {
    repository = "quay.io/coreos/hyperkube"
    version = "v1.5.2_coreos.1"
  }
  internet_gateway_id = "${module.vpc.internet_gateway_id}"
  kms_key_id = "${var.kms_key_id}"
  nat_gateway_ids = "${module.nat_gateway.gateway_ids}"
  subnets = {
    availability_zones = ["a","b","d"]
    private_cidr_blocks = ["10.0.10.0/24","10.0.11.0/24","10.0.12.0/24"]
    public_cidr_blocks = ["10.0.7.0/24","10.0.8.0/24","10.0.9.0/24"]
  }
  vpc_id = "${module.vpc.vpc_id}"
  vpc_cidr_block = "${var.vpc_cidr_block}"
}
