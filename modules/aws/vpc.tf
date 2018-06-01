# default network gropps

resource "aws_vpc" "vpc" {
  cidr_block = "10.10.0.0/16"
  tags {
    Name = "${var.prefix}-vpc"
  }
}

resource "aws_subnet" "public-subnet" {
  count = 2

  vpc_id            = "${aws_vpc.vpc.id}"
  cidr_block        = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)}"
   availability_zone = "${var.availability_zones[count.index]}"
  tags {
    Name = "${var.prefix}-public-subnet-${var.availability_zones[count.index]}"
  }
}

resource "aws_internet_gateway" "igw" {

  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "${var.prefix}-igw"
  }
}

resource "aws_route_table" "public-rt" {

  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags {
    Name = "${var.prefix}-public-rt"
  }
}

resource "aws_route_table_association" "public-rta-1a" {
  count          = 2
  subnet_id      = "${element(aws_subnet.public-subnet.*.id, count.index)}"
  route_table_id = "${aws_route_table.public-rt.id}"
}
