# Security Group for Public Load Balancer
module "databaseSG" {

  depends_on = [ module.vpc ]
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"  

  name = "databaseSG"
  description = "Security Group allow traffic from private subnet instances (IPv4 CIDR)"
  vpc_id = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      description              = "Allow traffic from Private Instance only"
      source_security_group_id = module.privateInstanceSG.security_group_id
    }
  ]

  egress_rules = ["all-all"]
  tags = local.common_tags
}


