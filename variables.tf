###############################################
# Root Variables
# Purpose: Inputs for provider and global configuration
###############################################
variable "aws_region" {
  type        = string
  description = "AWS region for all resources (e.g., us-east-1)"
}

variable "aws_config_paths" {
  type        = list(string)
  description = "Path(s) to AWS config file(s) for the provider"
  # default     = ["/home/alaa/.aws/config"]
}

variable "aws_credentials_paths" {
  type        = list(string)
  description = "Path(s) to AWS credentials file(s) for the provider"
  # default     = ["/home/alaa/.aws/credentials"]
}

