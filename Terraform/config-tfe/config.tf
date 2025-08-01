
variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "tag_name" {}
variable "instance_type" {}

provider "aws" {
  region  = "us-east-1"
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  version = "v2.70.0"
}

terraform {
  backend "remote" {
    hostname = "app.terraform.io"
    token = "J9ObsldOLFYdOg.atlasv1.simtbFQhuayoBf6kwFCGEBQ81ARzEjqcylCPTivDqZqdhHaItHL8BuciyCkkFEAy2Q0"
    organization = "naman-cdp-test"

    workspaces {
      name = "aws-resource-test"
    }
  }
}

#terraform {
#  backend "s3" {
#    key    = "terraform.tfstate"
#    region = "us-east-1"
#  }
#}

resource "aws_instance" "tf_instance" {
  ami           = "ami-0922553b7b0369273"
  instance_type = "t2.micro"
  tags = {
    Name = "${var.tag_name}"
  }
}

resource "aws_s3_bucket" "bucket" {
  bucket = "tf-test-bucket-automation-${var.tag_name}"
  acl    = "private"
}

/*resource "aws_security_group" "web-sg" {
  name = "${var.tag_name}-sg"
  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = [
      "0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
*/
  
output "region" {
  value = "us-east-1"
}

output "tags" {
  value = "${aws_instance.tf_instance.tags}"
}

