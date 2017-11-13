output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "subnets" {
  value = ["${aws_subnet.pub1.id}", "${aws_subnet.pub2.id}"]
}
