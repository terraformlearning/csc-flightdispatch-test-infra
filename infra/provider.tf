terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.64.0"
    }
  }

  backend "s3" {
    bucket       = "csc-replica-test-terraform-state-276719381578"
    key          = "test/terraform.tfstate"
    region       = "ap-south-1"
    use_lockfile = true
  }
}

provider "aws" {
  profile = "csc-test"
  region  = "ap-south-1"

  default_tags {
    tags = {
      workload         = "csc-replica"
      runtime-env      = "test"
      github-repo      = "csc-flightdispatch-test-infra"
      organization     = "learning"
      aws-organization = "test"
    }
  }
}