variable "instance_type" {
    description = "Type of EC2 size"
    type = string
    default = "t3.micro"
}

variable "key_name" {
    description = "Name of the key pair to use for the EC2 instance"
    type = string
    default = "MyPersonalFavoriteKeyPair"
}

variable "server_name" {
    description = "Name of the EC2 instance"
    type = string
}

variable "tags" {
    description = "Tags to apply to the EC2 instance"
    type = map(string)
    default = {}
}

variable "user_data" {
    description = "User data to configure the EC2 instance"
    type = string
    default = null
}

variable "associate_public_ip_address" {
    description = "Whether to associate a public IP address with the EC2 instance"
    type = bool
    default = true
}

variable "security_groups" {
    description = "List of security group IDs to associate with the EC2 instance"
    type = list(string)
    default = []
}

variable "iam_instance_profile" {
    description = "IAM instance profile for the EC2 instance"
    type = string
    default = null
}

variable "user_data_replace_on_change" {
    description = "Whether to replace the EC2 instance when user data changes"
    type = bool
    default = false
}