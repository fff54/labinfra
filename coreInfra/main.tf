provider "aws" {
  region = "eu-west-1"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags {
    Name = "vpc-test-lab"
  }
}

resource "aws_subnet" "pub1" {
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "eu-west-1a"

  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "public_subnet_az1"
  }
}

resource "aws_subnet" "pub2" {
  vpc_id            = "${aws_vpc.main.id}"
  availability_zone = "eu-west-1b"

  cidr_block              = "10.0.2.0/24"
  map_public_ip_on_launch = true

  tags {
    Name = "public_subnet_az2"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"

  tags {
    Name = "public Internet gateway"
  }
}

resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.main.id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }

  tags {
    Name = "route table - lab 4 test"
  }
}
