module "privateInstanceSG" {
  depends_on = [ module.bastionHostSG,module.loadbalancerSG,module.vpc ]
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"     
  
  name = "privateInstanceSG"
  description = "Allow HTTP from ALB SG and SSH from Bastion SG"
  vpc_id      = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      from_port                = 80
      to_port                  = 80
      protocol                 = "tcp"
      description              = "Allow HTTP from ALB only"
      source_security_group_id = module.loadbalancerSG.security_group_id
    },
    {
      from_port                = 22
      to_port                  = 22
      protocol                 = "tcp"
      description              = "Allow SSH from Bastion only"
      source_security_group_id = module.bastionHostSG.security_group_id
    }
  ]

  egress_rules = ["all-all"] 
  tags         = local.common_tags

}

