# Data Sources


Datenquellen ermöglichen das Abrufen oder Berechnen von Daten zur Verwendung an anderer Stelle im Terraform-Code. Die Verwendung von Datenquellen ermöglicht Informationen zu verwenden, die außerhalb von Terraform oder durch eine andere separate Terraform-Konfiguration definiert wurden.

Jeder Provider kann neben seinen Ressourcen auch Datenquellen anbieten.

```
data "aws_ami" "bionic" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}
```

## Benutzung

Können mittels der Syntax `data.<TYPE>.<NAME>.<ATTRIBUTE>` verwendet werden:

```
resource "aws_instance" "example-01" {
  ami             = data.aws_ami.bionic.id
  instance_type   = "t2.nano"
}
```
