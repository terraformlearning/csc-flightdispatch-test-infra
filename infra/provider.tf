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