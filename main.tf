terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "google" {
  project     = var.gcp_project_id
  region      = var.gcp_region
  credentials = file("gcp-key.json")
}

module "vpc" {
  source       = "./modules/vpc"
  project_name = var.project_name
  environment  = var.environment
  aws_region   = var.aws_region
}

module "iam" {
  source       = "./modules/iam"
  project_name = var.project_name
}

module "s3" {
  source       = "./modules/s3"
  project_name = var.project_name
  environment  = var.environment
}

module "ec2" {
  source                = "./modules/ec2"
  project_name          = var.project_name
  environment           = var.environment
  vpc_id                = module.vpc.vpc_id
  public_subnet_id      = module.vpc.public_subnet_id
  instance_profile_name = module.iam.instance_profile_name
}

module "gcp_vm" {
  source         = "./modules/gcp_vm"
  project_name   = var.project_name
  environment    = var.environment
  gcp_region     = var.gcp_region
  gcp_project_id = var.gcp_project_id
}
