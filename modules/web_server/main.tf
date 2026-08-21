data "aws_ami" "amazon_linux" {
    most_recent = true
    owners = ["amazon"]
    filter {
        name = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
    }
}

resource "aws_instance" "instance_resource" {
    ami = data.aws_ami.amazon_linux.id
    instance_type = var.instance_type
    key_name = var.key_name
    associate_public_ip_address = var.associate_public_ip_address
    security_groups = var.security_groups
    iam_instance_profile = var.iam_instance_profile
    tags = merge(
        {
            Name = var.server_name
        },
        var.tags
    )
    user_data = var.user_data
    user_data_replace_on_change = var.user_data_replace_on_change
}