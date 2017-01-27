#
# DO NOT DELETE THESE LINES!
#
# Your subnet ID is:
#
#     subnet-7e50c21a
#
# Your security group ID is:
#
#     sg-29ef374e
#
# Your AMI ID is:
#
#     ami-30217250
#
# Your Identity is:
#
#     autodesk-bear
#

variable "aws_access_key" {
  type = "string"
  default = "AKIAJMUSP5ENHWJYZJIA"
}

variable "aws_secret_key" {
  type = "string"
  default = "wFf5f0B0E77G7fj50qgDzQ/fY4mXeFh62J0428Ye"
}

variable "aws_region" {
  type = "string"
  default = "us-west-1"
}

variable "num_web" {
  default = "2"
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  count			 = 3
  instance_type          = "t2.micro"
  ami                    = "ami-30217250"
  subnet_id              = "subnet-7e50c21a"
  vpc_security_group_ids = ["sg-29ef374e"]

  tags {
    Name = "web ${count.index + 1}/${var.num_web}"
    Identity = "autodesk-bear"
    App = "Fusion"
    Instance_Type = "Web"
  }
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}
