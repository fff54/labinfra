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
