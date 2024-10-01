provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Environment = local.environment
      Project     = "hackathon-starter"
    }
  }
}
