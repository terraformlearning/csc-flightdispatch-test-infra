resource "aws_s3_bucket" "terraform_state" {
  bucket = "csc-replica-test-terraform-state-276719381578"

  tags = {
    workload         = "csc-replica"
    runtime-env      = "test"
    github-repo      = "csc-flightdispatch-test-infra"
    organization     = "learning"
    aws-organization = "test"
  }
}