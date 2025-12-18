module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  environment = "dev"
  project_name = "day08-full-vpc"
  list_az = ["us-east-1a","us-east-1b"]
}

// no ressource in root module for the moment