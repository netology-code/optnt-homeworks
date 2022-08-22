variable "token" {
  description = "Yandex Cloud security OAuth token"
  default     = "nope" #generate yours by this https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token
}

variable "folder_id" {
  description = "Yandex Cloud Folder ID where resources will be created"
  default     = "b1xxxxxxxxxxxxxxxx"
}

variable "cloud_id" {
  description = "Yandex Cloud ID where resources will be created"
  default     = "b1xxxxxxxxxxxxxxxxxx"
}

variable "public_key_path" {
  description = "Path to ssh public key, which would be used to access workers"
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Path to ssh private key, which would be used to access workers"
  default     = "~/.ssh/id_rsa"
}

variable "study_password" {
  type = string
  default = "1q2w3e4R"
}

variable "user" {
  type = string
  default = "study"
}
