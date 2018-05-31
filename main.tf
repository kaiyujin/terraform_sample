
variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "service_name" {}

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region     = "${var.region}"
}

# default network gropps

resource "aws_vpc" "vpc-1" {
  cidr_block = "192.168.0.0/16"
  tags {
    Name = "${var.service_name}-vpc1"
  }
}
