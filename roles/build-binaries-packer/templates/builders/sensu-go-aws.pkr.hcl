source "amazon-ebs" "amazon1" {
    ami_name = "whatever1"
    skip_create_ami = true
    instance_type = "{{packer_build_aws_instance_types['x86_64']}}"
    source_ami = "{{amazon_ami_x86_64}}"
    associate_public_ip_address = true
    region = "{{aws_region}}"
    security_group_id = "{{aws_security_group}}"
    subnet_id = "{{aws_subnet_id}}"
    vpc_id = "{{aws_vpc_id}}"
    ssh_interface = "private_ip"
    ssh_pty = true
    ssh_timeout = "5m"
    ssh_username = "ec2-user"
    user_data_file = "./aws_user_data.sh"
    run_tags = {
        packer = "true"
        Name = "packer-build-amazon-x86_64"
    }
    run_volume_tags = {
        packer = "true"
    }
}

source "amazon-ebs" "amazon2" {
    ami_name = "whatever2"
    skip_create_ami = true
    instance_type = "{{packer_build_aws_instance_types['aarch64']}}"
    source_ami = "{{amazon_ami_arm64}}"
    associate_public_ip_address = true
    region = "{{aws_region}}"
    security_group_id = "{{aws_security_group}}"
    subnet_id = "{{aws_subnet_id}}"
    vpc_id = "{{aws_vpc_id}}"
    ssh_interface = "private_ip"
    ssh_pty = true
    ssh_timeout = "5m"
    ssh_username = "ec2-user"
    user_data_file = "./aws_user_data.sh"
    run_tags = {
        packer = "true"
        Name = "packer-build-amazon-aarch64"
    }
    run_volume_tags = {
        packer = "true"
    }
}

source "amazon-ebs" "centos1" {
    ami_name = "whatever3"
    skip_create_ami = true
    instance_type = "{{packer_build_aws_instance_types['x86_64']}}"
    source_ami = "{{centos_ami_x86_64}}"
    associate_public_ip_address = true
    region = "{{aws_region}}"
    security_group_id = "{{aws_security_group}}"
    subnet_id = "{{aws_subnet_id}}"
    vpc_id = "{{aws_vpc_id}}"
    ssh_interface = "private_ip"
    ssh_pty = true
    ssh_timeout = "5m"
    ssh_username = "ec2-user"
    user_data_file = "./aws_user_data.sh"
    run_tags = {
        packer = "true"
        Name = "packer-build-centos-x86_64"
    }
    run_volume_tags = {
        packer = "true"
    }
}

source "amazon-ebs" "centos2" {
    ami_name = "whatever4"
    skip_create_ami = true
    instance_type = "{{packer_build_aws_instance_types['aarch64']}}"
    source_ami = "{{centos_ami_arm64}}"
    associate_public_ip_address = true
    region = "{{aws_region}}"
    security_group_id = "{{aws_security_group}}"
    subnet_id = "{{aws_subnet_id}}"
    vpc_id = "{{aws_vpc_id}}"
    ssh_interface = "private_ip"
    ssh_pty = true
    ssh_timeout = "5m"
    ssh_username = "ec2-user"
    user_data_file = "./aws_user_data.sh"
    run_tags = {
        packer = "true"
        Name = "packer-build-centos-aarch64"
    }
    run_volume_tags = {
        packer = "true"
    }
}

build {
    sources = [
        "source.amazon-ebs.centos1",
        "source.amazon-ebs.centos2",
        "source.amazon-ebs.amazon1",
        "source.amazon-ebs.amazon2"
    ]
    provisioner "ansible" {
        playbook_file = "{{playbook_dir}}/packer-build-tasks-{{packer_runtime}}.yml"
        inventory_directory = "{{playbook_dir}}/inventory/packer-build"
        host_alias = "packerhost"
        ansible_env_vars = ["ANSIBLE_HOST_KEY_CHECKING=False", "ANSIBLE_REMOTE_TMP=/tmp/.ansible/tmp"]
        use_proxy = false
        extra_arguments = [
            "--extra-vars",
            "'ansible_python_interpreter=/bin/python'"
        ]
        user = "ec2-user"
    }
}
