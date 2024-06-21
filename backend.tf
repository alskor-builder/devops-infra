terraform {
  backend "s3" {
    bucket = "devops-exam-chkpnt-terra-state"
    key    = "devops-infra/terraform.tfstate"
    region = "eu-west-1"
  }
}
