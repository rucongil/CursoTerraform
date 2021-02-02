# mi primer ejercicio en terraform
terraform{
    required_providers{
        docker={
           #he actualizado el repo del provider de docker
           source = "kreuzwerker/docker" 
        }
    }
}

provider"docker" { }

resource "docker_image" "imagen-ubuntu" {
  #name = var.nombre_imagen
  name = "ubuntu:${var.version_imagen}"
}

resource "docker_container" "contenedor-ubuntu" {
  name  = "mi_contenedor_ubuntu"
  image = docker_image.imagen-ubuntu.latest
}

# crear 2 volumenes dentro del contenedor

resource "docker_volume" "shared_volume" {
  name = "shared_volume"
}