

provider "yandex" {
  # Configuration options
  token                    = "AQxxxxxx"  #<---can get https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs
  cloud_id                 = "b1xxxxxxxx"                     #<---can get from yandex cli "yc resource-manager cloud list"
  folder_id                = "b1xxxxxxxxx"                     #<---can get from yandex cli "yc resource-manager folder list"
  zone                     = "ru-central1-a"                          
}

terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}
