#cloud-config
system_info:
  default_user:
    name: ec2-user

runcmd:
    - sed -i -e 's/^Defaults\s\+requiretty/# \0/' /etc/sudoers
    - service sshd restart
