# Terraform Kommandos & States

## Kommandos

https://www.terraform.io/docs/commands/index.html

Die wichtigsten:

```
terraform init
```

```
terraform plan
```

```
terraform apply
```

## State

* Ist-Zustand der Infrastruktur
* Dient zum Vergleich mit dem Soll-Zustand
* JSON-Format, Datei-Endung ".tfstate"
* Kann auch remote gespeichert werden
* Enthält auch Metadaten
