terraform {
  backend "s3" {
    bucket         = "terraform-porject-backend"   # S3 bucket name
    key            = "terraform.tfstate" # Path inside bucket
    region         = "us-east-1"                    # Your AWS region
    use_lockfile = "true"               # s3 state locking
    encrypt        = true
  }
}
