provider "aws" {
  region = "eu-west-1"
}

# Create a new instance of the latest Ubuntu 14.04 on an
# t2.micro node with an AWS Tag naming it "HelloWorld"

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-trusty-14.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "web" {
  ami                    = "${data.aws_ami.ubuntu.id}"
  instance_type          = "t2.micro"
  subnet_id              = "${element(data.terraform_remote_state.coreinfra.subnets,0)}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  key_name               = "gitD2SI"

  tags {
    Name = "test - recette VPC"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_all"
  description = "Allow ssh trafic"
  vpc_id      = "${data.terraform_remote_state.coreinfra.vpc_id}"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
