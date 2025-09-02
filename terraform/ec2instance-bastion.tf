module "bastionHostInstance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.1.1"
  name                   = "bastionHostInstance"
  associate_public_ip_address = true
  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = var.instance_keypair

  subnet_id              = module.vpc.public_subnets[0]
  vpc_security_group_ids = [module.bastionHostSG.security_group_id]
  tags = local.common_tags
}

