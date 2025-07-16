data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default_subnets" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

module "network" {
  source    = "./modules/network"
  vpc_id    = data.aws_vpc.default.id
  subnet_ids = data.aws_subnets.default_subnets.ids
}

module "lb" {
  source             = "./modules/lb"
  target_group_arn   = module.asg.target_group_arn
  security_group_ids = [module.network.alb_sg_id]
  vpc_id             = data.aws_vpc.default.id
  subnet_ids         = data.aws_subnets.default_subnets.ids
}

module "asg" {
  source = "./modules/asg"

  vpc_id                = data.aws_vpc.default.id
  subnet_ids            = data.aws_subnets.default_subnets.ids
  instance_profile_name = module.iam.aws_iam_instance_profile_name
  security_group_ids    = [module.network.asg_sg_id]
  db_endpoint            = module.rds.db_endpoint

}



module "iam" {
  source = "./modules/iam"
}

module "cloudwatch" {
  source   = "./modules/cloudwatch"
  asg_name = module.asg.aws_autoscaling_group
}


module "s3" {
  source      = "./modules/s3"
  region      = "ap-southeast-2"
  bucket_name      = "teamnh-course-bucket-168"

}

module "rds" {
  source                = "./modules/rds"
  region                = 
  db_username           = 
  db_password           = 
  db_name               = 
  db_instance_class     = 
  db_allocated_storage  = 20
  vpc_security_group_ids = [module.network.rds_sg_id]
  subnet_ids            = data.aws_subnets.default_subnets.ids
}
