output "instance_name" {
    description = "Name of the EC2 instance"
    value = aws_instance.instance_resource.tags.Name
}

output "public_ip" {
    description = "Public IP address of the EC2 instance"
    value = aws_instance.instance_resource.public_ip
}

output "public_dns" {
    description = "Public DNS of the EC2 instance"
    value = aws_instance.instance_resource.public_dns
}