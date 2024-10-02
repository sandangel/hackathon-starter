module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  version            = "5.13.0"
  name               = "eks-vpc"
  cidr               = "10.0.0.0/19"
  azs                = ["us-west-2a", "us-west-2b"]
  private_subnets    = ["10.0.1.0/21", "10.0.9.0/21"]
  public_subnets     = ["10.0.17.0/25", "10.0.17.128/25"]
  enable_nat_gateway = true
}
