assets_bucket_name = "terraform-kubit-test-local"
aws_region = "us-east-1"
domain_names = { external = "k8s.test.kubit.io", internal = "k8s.test.kubit.local" }
ebs_encrypted = true
environment_name = "test"
kms_key_id = ""
subnets = {
  availability_zones = ["a","b","c"]
  private_cidr_blocks = ["10.0.4.0/24","10.0.5.0/24","10.0.6.0/24"]
  public_cidr_blocks = ["10.0.1.0/24","10.0.2.0/24","10.0.3.0/24"]
}
vpc_cidr_block = "10.0.0.0/16"
