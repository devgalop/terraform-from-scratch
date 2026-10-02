resource "aws_instance" "master" {
    ami = "ami-0fef201115eefe936"  # AMI ID from the AWS Management Console or your preferred source
    instance_type = var.master_type
    subnet_id     = var.public_subnet_id
    vpc_security_group_ids = [var   .security_group_id]
    associate_public_ip_address = true # Ensure the instance gets a public IP address
    key_name = var.key_name # Specify the key pair name for SSH access Must be created previously
    root_block_device {
        volume_size = var.root_volume_size
        volume_type = var.root_volume_type
        delete_on_termination = true # Automatically delete the root volume when the instance is terminated
        encrypted   = true # Ensure the root volume is encrypted
    }
    user_data = <<-EOF
                    #!/bin/bash
                    
                    dnf update -y
                    dnf install -y httpd

                    systemctl enable --now httpd
                    EOF
    tags = {
        Name = "MasterInstance-${terraform.workspace}"
    }
}

output "worker_instance_id" {
    value = aws_instance.master.id
}