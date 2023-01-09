variable "project_id" {
  type = string
}

variable "secret_id" {
  type = string
}

variable "data" {
  type = string
  sensitive   = true
}
