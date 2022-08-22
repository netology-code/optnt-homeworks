resource "yandex_vpc_network" "vpc-study" {
  name = "vpc-study"
}

resource "yandex_vpc_subnet" "study-subnet-a" {
  name           = "study-subnet-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.vpc-study.id
  v4_cidr_blocks = ["10.77.1.0/24"]
}
