# Cloud-Init

Cloud-Init ist ein weit verbreiteter Ansatz zum Anpassen einer Linux-VM beim ersten Start. Mit cloud-init können Pakete installiert, Dateien geschrieben oder Benutzer und Sicherheit konfiguriert werden. Da cloud-init während des ersten Startvorgangs aufgerufen wird, müssen keine zusätzlichen Schritte oder Agents zur Konfiguration angewandt werden:

```
#cloud-config
package_upgrade: true
packages:
  - httpd
```

## Benutzung

```
resource "aws_instance" "web" {
  ami              = "ami-d05e75b8"
  instance_type    = "t2.micro"
  user_data_base64 = base64encode(file("cloud-init.txt"))
}
```

### Dokumentationen

Siehe

https://cloudinit.readthedocs.io/en/latest/

In Terraform:

https://www.terraform.io/docs/providers/template/d/cloudinit_config.html
