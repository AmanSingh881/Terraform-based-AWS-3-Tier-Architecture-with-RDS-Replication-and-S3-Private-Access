# Terraform AWS Network Load Balancer (NLB)
module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "9.16.0"

  name_prefix = "mylb-"
  load_balancer_type               = "application"
  vpc_id                           = module.vpc.vpc_id
  dns_record_client_routing_policy = "availability_zone_affinity"
  security_groups = [module.loadbalancer_sg.security_group_id]

  subnets = module.vpc.public_subnets

  # For example only
  enable_deletion_protection = false

  listeners = {
      ex-http-https-redirect = {
        port     = 80
        protocol = "HTTP"
        redirect = {
          port        = "443"
          protocol    = "HTTPS"
          status_code = "HTTP_301"
        }
      }
      ex-https = {
        port            = 443
        protocol        = "HTTPS"
        certificate_arn = data.aws_acm_certificate.example_cert.arn

        forward = {
          target_group_key = "mytg1"
        }
      }
    }

# Target Groups
  target_groups = { 
    # Target Group-1: mytg1
    mytg1 = {
      create_attachment = false          
      name_prefix          = "mytg1-"
      protocol             = "HTTP"
      port                 = 80
      target_type          = "instance"
      deregistration_delay = 10
      health_check = {
        enabled             = true
        interval            = 30
        path                = "/app1/index.html"
        port                = "traffic-port"
        healthy_threshold   = 3
        unhealthy_threshold = 3
        timeout             = 6
      }# End Health Check Block
    }# End Target Group-1: mytg1
  }
  tags = local.common_tags
}# End NLB Module
