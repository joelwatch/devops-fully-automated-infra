output "instance_id" {
    value = aws_instance.web-server.id
}

output "instance_public_ip" {
    value = aws_instance.web-server.public_ip
}