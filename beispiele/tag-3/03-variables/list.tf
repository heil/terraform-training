variable "list-users" {
  type    = "list"
  default = ["root", "user1", "user2"]
}

output "list-users" {
  value = var.list-users[2]
}
