# datasource that reads the info from vpc statefile 
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "terraformbasicdevopsstatebucket"
    key    = "dev/vpc/terraform.tfstate"
    region = "us-east-1"
  }
}


data "aws_ami" "ami" {

  most_recent      = true
  name_regex       = "centos8-with-ansible"
  owners           = ["590183768065"]

}

data "terraform_remote_state" "alb" {
  backend = "s3"
  config = {
    bucket = "terraformbasicdevopsstatebucket"
    key    = "dev/alb/terraform.tfstate"
    region = "us-east-1"
  }
}

data "terraform_remote_state" "db" {
  backend = "s3"
  config = {
    bucket = "terraformbasicdevopsstatebucket"
    key    = "dev/db/terraform.tfstate"
    region = "us-east-1"
  }
}