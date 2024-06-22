terraform {
  backend "s3" {
    bucket = "devops-exam-chkpnt-terra-state"
    key    = "devops-infra/terraform.tfstate"
    region = "eu-west-1"
  }
}
#TODO: 
#add dynamodb lock state
# Include if not present:
#dynamodb_table = "terraform-state-locking"  # For state locking