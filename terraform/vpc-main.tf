# Create VPC Terraform Module
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.0.1"

  # VPC Basic Details
  name = "${local.name}-${var.vpc_name}"
  cidr = var.vpc_cidr_block
  azs             = var.vpc_availability_zones
  public_subnets  = var.vpc_public_subnets
  private_subnets = var.vpc_private_subnets
  database_subnets    = var.vpc_database_subnets

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true 
  
  # NAT Gateways - Outbound Communication
  enable_nat_gateway = var.vpc_enable_nat_gateway 
  single_nat_gateway = var.vpc_single_nat_gateway

  # VPC DNS Parameters
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = local.common_tags
  vpc_tags = local.common_tags

  # Additional Tags to Subnets
  public_subnet_tags = {
    Type = "Public Subnets"
    Terraform = "true"
  }
  private_subnet_tags = {
    Type = "Private Subnets"
    Terraform = "true"
  }  
  database_subnet_tags = {
    Type = "Database Subnets"
    Terraform = "true"
  }
}