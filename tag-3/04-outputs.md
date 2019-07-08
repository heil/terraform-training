# Outputs

Outputs werden verwendet, um bestimmte Werte in der CLI-Ausgabe auszugeben, nachdem `terraform apply` ausgeführt wurde:

```
output "example" {
  value = "123456abcdef"
}
```

### Optionale Argumente von Outputs

* `sensitive`
* `description`
* `depends_on`

Siehe

https://www.terraform.io/docs/configuration/outputs.html
