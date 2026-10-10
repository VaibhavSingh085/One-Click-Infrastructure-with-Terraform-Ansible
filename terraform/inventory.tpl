[web]
web1 ansible_host=${public_ip}

[web:vars]
ansible_user=ubuntu
ansible_ssh_private_key_file=${private_key_path}
