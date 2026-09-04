terraform{
    #Configure the required providers for this Terraform configuration
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  #Configure the backend to store the state file locally
  #The state file can be stored in a remote backend like S3, but for this example, we will store it locally
  backend "local"{
    path = "./state/terraform.tfstate"
  }
}

#Configure the AWS Provider
provider "aws" {
  region = "${var.aws_region}"
  profile = "${var.aws_profile}"
}