output "ipv4_address" {
  value = resource.aws_instance.this.public_ip
}