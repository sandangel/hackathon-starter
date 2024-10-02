variable "region" {
  description = "The AWS region to create resources in"
  default     = "us-west-2"
}

variable "s3_bucket_name" {
  description = "The name of the S3 bucket for Terraform state"
}

variable "dynamodb_table_name" {
  description = "The name of the DynamoDB table for Terraform state locking"
}
