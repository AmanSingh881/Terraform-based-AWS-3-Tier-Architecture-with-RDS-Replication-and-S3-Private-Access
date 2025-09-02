module "bastionHostSG" {

  depends_on = [ module.vpc ]
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0" 

  name = "bastionHostSG"
  description = "Security Group with SSH port open for everybody (IPv4 CIDR)"
  vpc_id = module.vpc.vpc_id

  ingress_rules = ["ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules = ["all-all"]
  tags = local.common_tags
}
