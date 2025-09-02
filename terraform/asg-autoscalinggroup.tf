module "autoscalinggroup" {
  source  = "terraform-aws-modules/autoscaling/aws"
  version = "9.0.1"
  
  
  name = "asg"

  min_size                  = 1
  max_size                  = 5
  desired_capacity          = 2
  wait_for_capacity_timeout = 0
  health_check_type         = "EC2"

  vpc_zone_identifier       = module.vpc.private_subnets

  # Traffic source attachment
  traffic_source_attachments = {
    ex-alb = {
      traffic_source_identifier = module.loadbalancer.target_groups["mytg1"].arn
      traffic_source_type       = "elbv2" # default
    }
  }

  placement = {
    availability_zone = "us-east-1"
  }

  # Launch template
  launch_template_name        = "asg_launch_tamplate"
  launch_template_description = "Launch template"
  update_default_version      = true

  image_id          = "ami-00ca32bbc84273381"
  key_name          = var.instance_keypair 
  instance_type     = "t3.micro"
  user_data = filebase64("${path.module}/user-data.sh")

  network_interfaces = [
    {
      delete_on_termination = true
      description           = "eth0"
      device_index          = 0
      security_groups       = [module.privateInstanceSG.security_group_id]
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