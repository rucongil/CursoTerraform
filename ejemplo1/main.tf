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
  command = ["bash", "-c", "sleep 600"]


# crear 2 volumenes dentro del contenedor
#dynamic para declarar las variables que tenemos en la lista del fichero varaibles.tf
 volumes{
       host_path       = "/home/ubuntu/environment/cursoTerraform"
    container_path  = "/cursoTerraform"
 }

 volumes{
    host_path       = "/home/ubuntu/environment/ivan"
    container_path  =  "/ivan"
 }
    
    
#dynamic para declarar las variables que tenemos en la lista del fichero varaibles.tf
 dynamic "volumes" {
    for_each = var.volumenes
    content {
        #volume_name     = contains(volumes,         volumes.value["volume_name"]
        host_path       = volumes.value["host_path"]
        container_path  = volumes.value["container_path"]
    }
 }
    
}