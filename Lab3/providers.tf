###############################################
# Providers
# Purpose: Configure AWS provider with shared config/credentials
###############################################
provider "aws" {
    region = var.aws_region
    shared_config_files = var.aws_config_paths
    shared_credentials_files = var.aws_credentials_paths
    profile = "default"
}