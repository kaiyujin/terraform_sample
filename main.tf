variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "service_name" {}
variable "availability_zones" {
type = "list"
}

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region     = "${var.region}"
}


module "aws" {
  source = "./modules/aws"
  prefix = "${terraform.env}-${var.service_name}"
  availability_zones = "${var.availability_zones}"
}
