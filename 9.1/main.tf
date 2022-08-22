
#====================================================================

data "yandex_compute_image" "ubuntu-20-04" {
  family = "ubuntu-2004-lts"
}

data "template_file" "cloud_init" {
  template = file("cloud-init.tmpl.yaml")  #<--- file in local repo
    vars = {
    user = var.user                        #<--- set username in variables.tf
    ssh_key = file(var.public_key_path)    #<--- set ssh-key in variables.tf
  }
}

resource "yandex_compute_instance" "study-vm1" {
  name = "study-vm"
#  folder_id = var.folder_id   #<---can get in from yandex CLI "yc resource-manager folder list",  we already set it in provider.tf
  platform_id = "standard-v2"
  zone = "ru-central1-a"

  resources {
    cores = 2
    memory = 2
    core_fraction = 20

  }
  boot_disk {
    mode = "READ_WRITE"
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu-20-04.id
      type = "network-ssd"
      size = 100
    }
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.study-subnet-a.id  #<--- described in vpc.tf
    nat = true
  }

  metadata = {
    user-data = data.template_file.cloud_init.rendered
    serial-port-enable = 1
  }

  provisioner "remote-exec" {
    inline = [
      "echo '${var.user}:${var.study_password}' | sudo chpasswd", #<--- set password and user in variables.tf
      "sudo apt-get update",
      "sudo apt-get install nginx -y",
      "sudo systemctl enable nginx",
    ]
    connection {
      type = "ssh"
      user = var.user
      private_key = file(var.private_key_path)
      host = self.network_interface[0].nat_ip_address  #<--- will connect to vm's ip and do remote-exec
    }
  }
  timeouts {
    create = "10m"
  }
}

/*
resource "yandex_compute_instance" "default1" {
  #count = "3"
  name        = "my-cisco1"
  platform_id = "standard-v3"   #v1-Intel Broadwell v2-Intel Cascade Lake  v3-Intel Ice Lake
  zone        = "ru-central1-a"
  resources {
    cores  = 2
    memory = 4
    core_fraction = 20
  }
  metadata = {
      serial-port-enable = 1
    }
  
  boot_disk {
    initialize_params {
      image_id = "fd8aa37clt511qqfcu5f" #<-----  can get from yandex cli "yc compute image list --folder-id standard-images"
    }
  }
  network_interface {
    subnet_id = "e9brgi4o3k0ir9biniu0"   #<-----  can get from yandex cli "yc vpc network list-subnets --name default"
      }
  labels = {
    environment = "test"
  }
  scheduling_policy  { 
      preemptible = "true"
  }
}
*/
