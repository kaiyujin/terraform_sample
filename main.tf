
variable "access_key" {}
variable "secret_key" {}
variable "region" {}
variable "service_name" {}
variable "availability_zones" {
  type = "list"
  default = ["us-east-1a", "us-east-1c"]
}

provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region     = "${var.region}"
}

# default network gropps

resource "aws_vpc" "vpc" {
  cidr_block = "10.10.0.0/16"
  tags {
    Name = "${var.service_name}-vpc"
  }
}

resource "aws_subnet" "public-subnet" {
  count = 2

  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)}"
  availability_zone = "${var.availability_zones[count.index]}"
  tags {
    Name = "${var.service_name}-public-subnet-${var.availability_zones[count.index]}"
  }
}

resource "aws_internet_gateway" "igw" {

  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "${var.service_name}-igw"
  }
}

resource "aws_route_table" "public-rt" {

  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags {
    Name = "${var.service_name}-public-rt"
  }
}

resource "aws_route_table_association" "public-rta-1a" {
  count          = 2
  subnet_id      = "${element(aws_subnet.public-subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public-rt.id}"
}

