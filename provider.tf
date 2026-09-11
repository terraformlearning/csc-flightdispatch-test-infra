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