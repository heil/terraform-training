output "web-01-private_ip" {
  value = aws_instance.web-01.private_ip
}

output "web-02-private_ip" {
  value = aws_instance.web-01.private_ip
}
