# Konfiguration AWS CLI

## Erstellen eines Profils

### Standard-Profil (default)

```
$ aws configure
AWS Access Key ID [None]: AKIAIOSFODNN7EXAMPLE
AWS Secret Access Key [None]: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
Default region name [None]: eu-central-1
Default output format [None]: json
```

### Zusätzliches Profil

```
$ aws configure --profile terraform-training
AWS Access Key ID [None]: AKIAI44QH8DHBEXAMPLE
AWS Secret Access Key [None]: je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY
Default region name [None]: eu-central-1
Default output format [None]: text
```

## Konfigurationsdateien

In `~/.aws/credentials` (Linux und Mac) oder `%USERPROFILE%\.aws\credentials` (Windows):

```
[default]
aws_access_key_id=AKIAIOSFODNN7EXAMPLE
aws_secret_access_key=wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY

[terraform-training]
aws_access_key_id=AKIAI44QH8DHBEXAMPLE
aws_secret_access_key=je7MtGbClwBF/2Zp9Utk/h3yCo8nvbEXAMPLEKEY
```

In `~/.aws/config` (Linux und Mac) oder `%USERPROFILE%\.aws\config` (Windows):

```
[default]
region=eu-central-1
output=json

[profile terraform-training]
region=eu-central-1
output=text
```
