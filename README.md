# 🌐 Infrastructure as Code: Scalable Web Hosting Architecture with AWS and Terraform

This project demonstrates how to host a secure and scalable website on AWS using EC2 instances in private subnets, an Internet-Facing Application Load Balancer (ALB), Auto Scaling Group (ASG), and Route 53 + AWS Certificate Manager (ACM) for domain management and HTTPS support — all managed with Terraform infrastructure as code (IaC).

## 🚀 Features
- Fully automated infrastructure deployment using Terraform
- EC2 instances launched in private subnets via Auto Scaling Group
- Internet-facing Application Load Balancer (ALB) routing traffic to private instances
- Custom domain name managed through Route 53
- SSL/TLS certificate provisioning via AWS Certificate Manager (ACM)
- Secure HTTPS access for end users
- Highly available and scalable architecture
- Infrastructure follows best security practices

## ⚙️ Key Components

### ✅ VPC and Networking
- **VPC**: Custom Virtual Private Cloud with three subnet types—public, private, and database.
- **Subnets**: Distributed across multiple Availability Zones for high availability and fault tolerance.
- **CIDR Blocks**: Organized to avoid address overlap and allow for future growth.

### ✅ Internet Gateway and NAT Gateway
- **Internet Gateway**: Enables internet access for resources in public subnets.
- **NAT Gateway**: Deployed in public subnets to allow instances in private subnets to initiate outbound connections without direct internet exposure.

### ✅ Load Balancers and Auto Scaling
- **Public Load Balancer**: Routes incoming traffic from the internet to EC2 instances in the public subnet. These instances are managed by an **Auto Scaling Group** to scale based on demand and ensure high availability.

---
