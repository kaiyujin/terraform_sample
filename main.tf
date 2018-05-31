
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

resource "aws_vpc" "vpc-1" {
  cidr_block = "10.10.0.0/16"
  tags {
    Name = "${var.service_name}-vpc1"
  }
}

resource "aws_subnet" "vpc-1-public-subnet" {
  count = 2

  vpc_id            = "${aws_vpc.vpc-1.id}"
  cidr_block        = "${cidrsubnet(aws_vpc.vpc-1.cidr_block, 8, 0)}"
  availability_zone = "us-east-1a"
  tags {
    Name = "${var.service_name}-vpc-1-public-subnet-1a"
  }
}

resource "aws_internet_gateway" "vpc-1-igw" {
  vpc_id = "${aws_vpc.vpc-1.id}"
  tags {
    Name = "${var.service_name}-vpc-1-igw"
  }
}

resource "aws_route_table" "vpc-1-public-rt" {
  vpc_id = "${aws_vpc.vpc-1.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.vpc-1-igw.id}"
  }
  tags {
    Name = "${var.service_name}-vpc-1-public-rt"
  }
}

resource "aws_route_table_association" "public-rta-1a" {
  subnet_id      = "${aws_subnet.vpc-1-public-subnet.id}"
  route_table_id = "${aws_route_table.vpc-1-public-rt.id}"
}


