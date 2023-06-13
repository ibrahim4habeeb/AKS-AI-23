# Input Variables Placeholder file

variable "secret_name" {
  description = "Key Vault secret name in Azure"
  type = string
}


variable "secret_value" {
  description = "Key Vault secret value in Azure"
  type = string
  sensitive = true
}