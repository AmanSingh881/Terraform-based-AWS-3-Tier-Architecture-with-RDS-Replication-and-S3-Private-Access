module "autoscaling" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "8.2.0"
  
  
  name = "example-asg"

  min_size                  = 1
  max_size                  = 5
  desired_capacity          = 2
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"

  vpc_zone_identifier       = module.vpc.private_subnets

  # Traffic source attachment
  traffic_source_attachments = {
    ex-alb = {
      traffic_source_identifier = module.nlb.target_groups["mytg1"].arn
      traffic_source_type       = "elbv2" # default
    }
  }

  placement = {
    availability_zone = "us-east-1"
  }

  # Launch template
  launch_template_name        = "example-asg"
  launch_template_description = "Launch template example"
  update_default_version      = true

  image_id          = data.aws_ami.amzlinux2.image_id
  key_name          = var.instance_keypair 
  instance_type     = "t3.micro"
  user_data = filebase64("${path.module}/app1-install.sh")

  network_interfaces = [
    {
      delete_on_termination = true
      description           = "eth0"
      device_index          = 0
      security_groups       = [module.private_sg.security_group_id]
    }
  ]

  ebs_optimized     = true
  enable_monitoring = true


  scaling_policies = {
    avg-cpu-policy-greater-than-50 = {
      policy_type               = "TargetTrackingScaling"
      estimated_instance_warmup = 1200
      target_tracking_configuration = {
        predefined_metric_specification = {
          predefined_metric_type = "ASGAverageCPUUtilization"
        }
        target_value = 50.0
      }
    }
  }

}