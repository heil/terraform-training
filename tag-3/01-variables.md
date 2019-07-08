# Variablen in Terraform


Um wirklich wiederverwendbar und versionskontrolliert zu sein, müssen wir den Code parametrisieren. Dazu werden Variablen benutzt.

Variablen dienen als Parameter in Terraform, sodass Aspekte des Codes angepasst werden können, ohne den Code selbst zu ändern.

## Typen von Variablen

Siehe

https://www.terraform.io/docs/configuration/types.html

### Simple Typen

* Zeichenketten (Strings)
* Ganzzahlen (Numbers)
* Wahrheitswerte (Bool)

### Komplexe Typen

* list
* map

## Deklaration von Variablen

```
variable "example_var" {
  type = string
}

variable "variable_list" {
  type    = list(string)
  default = ["a", "b", "c"]
}
```

* Variablen **ohne** `default`-Wert sind erforderlich
* Variablen **mit** `default`-Wert sind optional

## Benutzung von variablen

Siehe

[Variablen](../beispiele/tag-3/03-variables)

### Kommando-Zeile:

```
terraform apply -var="example_var=123456abcdef"
terraform apply -var='variable_list=["d","e","f"]'
```

### `tfvars` Datei

Inhalt der Datei namens `testing.tfvars`:

```
example_var = "123456abcdef"
variable_list = ["d", "e", "f"]
```

Benutzung:

```
terraform apply -var-file="testing.tfvars"
```

Automatisches Laden von Variablen ist ebenfalls möglich:

* Dateien mit Namen `terraform.tfvars` oder `terraform.tfvars.json`
 * Jede Datei deren Namen mit `.auto.tfvars` or `.auto.tfvars.json` endet

### Umgebungsvariablen

```
$ export TF_VAR_example_var=123456abcdef
$ terraform plan
```
