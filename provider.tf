terraform {
 required_providers {
 aws = {
 source = "hashicorp/aws"
 version = "~> 4.16"
 }
 }
 required_version = ">= 1.2.0"
}

provider "aws" {
    region   = "ap-southeast-2"
    max_retries         = 5
}

