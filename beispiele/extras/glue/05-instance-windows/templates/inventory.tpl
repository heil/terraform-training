[win]
${ip_address}

[win:vars]
ansible_connection=winrm
ansible_ssh_pass=${admin_pw}
ansible_ssh_port=5985
ansible_ssh_user=${admin_user}
ansible_winrm_server_cert_validation=ignore
ansible_winrm_transport=ntlm
