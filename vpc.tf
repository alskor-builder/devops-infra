provider "aws" {
  region = "eu-west-1"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.0"

  name = "my-vpc-1"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }

  public_subnet_tags = {
    "kubernetes.io/role/elb"             = 1
    "kubernetes.io/cluster/my-cluster-1" = "owned"
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb"     = 1
    "kubernetes.io/cluster/my-cluster-1"  = "owned"
  }
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}