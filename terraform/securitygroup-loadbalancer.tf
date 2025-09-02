# Security Group for Public Load Balancer
module "loadbalancerSG" {

  depends_on = [ module.vpc ]
  source  = "terraform-aws-modules/security-group/aws"
  version = "5.3.0"  

  name = "loadbalancerSG"
  description = "Security Group with HTTP open for Load Balancer (IPv4 CIDR)"
  vpc_id = module.vpc.vpc_id

  ingress_rules = ["http-80-tcp", "https-443-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]

  egress_rules = ["all-all"]
  tags = local.common_tags
}


