module "vpc" {
  source = "./modules/vpc"

  vpc_cidr = "10.0.0.0/16"
}

module "iam" {
  source = "./modules/iam"
}

module "ec2" {
  source = "./modules/ec2"

  instance_type = var.instance_type
  instance_name = var.instance_name
  os_type = var.os_type

  subnet_id = module.vpc.subnet_id
  sg_id     = module.vpc.security_group_id

  instance_profile = module.iam.instance_profile
}