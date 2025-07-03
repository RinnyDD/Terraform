data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}


module "asg" {
  source = "./modules/asg"

  vpc_id               = data.aws_vpc.default.id
  subnet_ids           = data.aws_subnets.default_subnets.ids
  instance_profile_name = module.iam.aws_iam_instance_profile_name
  security_group_ids = [module.network.asg_sg_id]
}

module "network" {
  source = "./modules/network"
  vpc_id               = data.aws_vpc.default.id
  subnet_ids           = data.aws_subnets.default_subnets.ids

}

module "lb" {
  source = "./modules/lb"
  target_group_arn = module.asg.target_group_arn
  security_group_ids = [module.network.alb_sg_id]
  vpc_id               = data.aws_vpc.default.id
  subnet_ids           = data.aws_subnets.default_subnets.ids
}

module "iam" {
  source = "./modules/iam"
}

module "cloudwatch" {
  source               = "./modules/cloudwatch"
  asg_name             = module.asg.aws_autoscaling_group
}
