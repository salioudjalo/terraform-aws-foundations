module "vpc" {
  source       = "./modules/vpc"
  vpc_cidr     = "10.0.0.0/16"
  environment  = "dev"
  project_name = "day08-full-vpc"
  list_az      = ["us-east-1a", "us-east-1b"] // do not mix Regions (us-east-1), and AZ (us-east-1a)
}

// no resource in root module for the moment