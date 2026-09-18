terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
}

provider "yandex" {
  zone = "ru-central1-a"
}

data "yandex_compute_image" "ubuntu_2404_lts" {
  family = "ubuntu-2404-lts"
}

variable "ingress_ports" {
  type    = list(number)
  default = [22, 80, 443]
}

resource "yandex_vpc_network" "lab_net" {
  name = "lab-network"
}

resource "yandex_vpc_subnet" "lab_subnet" {
  name           = "lab-subnet-a"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.lab_net.id
  v4_cidr_blocks = ["10.0.1.0/24"]
}

resource "yandex_vpc_security_group" "lab_sg" {
  name       = "lab-security-group-vm"
  network_id = yandex_vpc_network.lab_net.id

  dynamic "ingress" {
    for_each = var.ingress_ports
    content {
      from_port      = ingress.value
      to_port        = ingress.value
      protocol       = "tcp"
      v4_cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port      = 0
    to_port        = 0
    protocol       = "tcp"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "yandex_compute_instance" "vm_1" {
  name = "otus-dz1"
  zone = "ru-central1-a"
  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_2404_lts.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.lab_subnet.id
    nat       = true
  }
  metadata = {
    ssh-keys           = "ubuntu:${file("/home/fse/.ssh/major.pub")}"
    serial-port-enable = "1"
  }

}

output "instance_public_ip" {
  value = yandex_compute_instance.vm_1.network_interface.0.nat_ip_address
}
