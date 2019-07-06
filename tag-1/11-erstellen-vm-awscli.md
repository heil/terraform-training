# Erstellen einer virtuellen Maschine in AWS mit dem AWS CLI

## SSH-Schlüssel erzeugen

### Windows

<img src="https://www.ssh.com/s/pyttygen-created-ssh-key-479x471-reHlFacl.png" />

Public Key speichern unter `%USERPROFILE%\.ssh\id_rsa.aws.pub`.

### MacOS & Linux

```
ssh-keygen -t rsa -b 2048  -C "YOUR_NAME" -f ~/.ssh/id_rsa.aws
chmod 0400 ~/.ssh/id_rsa.aws
```

## Upload Keypair

```
aws ec2 import-key-pair --key-name "YOUR_NAME" \
    --public-key-material file://~/.ssh/id_rsa.aws.pub \
    --profile PROFILE_NAME
```

## Security Gruppe

```
aws ec2 create-security-group --group-name ssh-external \
    --description "Zugriff über SSH von extern" \
    --profile PROFILE_NAME

aws ec2 authorize-security-group-ingress --group-name ssh-external \
    --protocol tcp --port 22 --cidr 0.0.0.0/0 \
    --profile PROFILE_NAME
```
