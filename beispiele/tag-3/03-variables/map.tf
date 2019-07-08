variable "map-plans" {
  type = "map"
  default = {
    "5USD"  = "1xCPU-1GB"
    "10USD" = "1xCPU-2GB"
    "20USD" = "2xCPU-4GB"
  }
}

output "map-plans" {
  value = var.map-plans["5USD"]
}
