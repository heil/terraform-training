#abs
variable "cidr" {
  type    = "string"
  default = "10.11.127.0/20"
}

output "host" {
  value = cidrhost(var.cidr, 16)
}

output "abs" {
  value = abs(-1.2)
}

#basename
variable "path" {
  default = "/home/terraform/template.tf"
}

output "path" {
  value = var.path
}

output "basename_path" {
  description = "basename of path"
  value       = basename(var.path)
}

variable "string" {
  default = "some_string"
}

variable "empty_string" {
  default = ""
}

# coalesce
output "coalesce" {
  value = coalesce(var.empty_string, var.string)
}
