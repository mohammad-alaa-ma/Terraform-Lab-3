###############################################
# Backend & Remote State Configuration (S3+DDB)
# Purpose: Configure remote state storage and locking
###############################################
resource "aws_s3_bucket" "terraform_state" {
    bucket = "terraform-up-and-running-state-394343423"
    object_lock_enabled = true

    lifecycle {
        prevent_destroy = true
    }
}

resource "aws_s3_bucket_versioning" "enabled" {
    bucket = aws_s3_bucket.terraform_state.id
    versioning_configuration {
        status = "Enabled"
    }
}

resource "aws_dynamodb_table" "terraform_locks" {
    name = "terraform-up-and-running-locks"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"

    attribute {
        name = "LockID"
        type = "S"
    }
}


terraform {
    backend "s3" {
     
      bucket = "terraform-up-and-running-state-394343423"
      key = "state_files/terraform.tfstate"
      region = "us-east-1"
      dynamodb_table = "terraform-up-and-running-locks"
      encrypt = true
    }
}
