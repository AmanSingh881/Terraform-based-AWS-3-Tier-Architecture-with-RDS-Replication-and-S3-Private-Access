# Terraform-based-AWS-3-Tier-Architecture-with-RDS-Replication-and-S3-Private-Access
A production-ready, modular Terraform project that provisions a secure, scalable 3-tier AWS architecture with public, private, and database subnets, RDS with read replicas, and private S3 access using a VPC endpoint.

**Project Description:**  
Modular Terraform solution deploying a secure, scalable AWS 3‑tier architecture with public, private, and database subnets; RDS primary with multi‑AZ read replicas; VPC endpoint for S3 access; and Auto Scaling Groups behind public and internal Load Balancers for automated scaling, high availability, and operational resilience; cost-effective, resilient, and secure networking.

---

## 📚 Overview

This project provisions a fully functional, production-grade 3-tier AWS architecture using Terraform. It separates concerns across public, private, and database layers, integrates managed services like RDS with replication, and configures secure communication paths using NAT Gateways, Internet Gateways, Load Balancers with Auto Scaling, and VPC Endpoints.

---

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
- **Internal Load Balancer**: Distributes traffic from public-tier instances to EC2 instances in private subnets. These backend instances are also part of an **Auto Scaling Group**, enabling automatic scaling for application workloads.

### ✅ RDS Setup
- **Primary Database**: Single primary RDS instance for read/write operations.
- **Read Replicas**: Two multi‑AZ read replicas for read scalability and high availability.
- **Database Subnets**: Isolated subnets with no direct internet access, enforcing a secure database tier.

### ✅ S3 VPC Endpoint
- **Gateway Endpoint**: Provides private connectivity between private subnets and S3, eliminating the need for internet routing.

---
