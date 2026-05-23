terraform {
  required_version = ">= 1.5.0"
}

resource "null_resource" "worker" {
  provisioner "local-exec" {
    command = "multipass launch 24.04 --name worker-tf --cpus 2 --memory 2G --disk 10G"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "multipass delete worker-tf --purge || true"
  }
}

resource "null_resource" "db" {
  depends_on = [null_resource.worker]

  provisioner "local-exec" {
    command = "sleep 10 && multipass launch 24.04 --name db-tf --cpus 1 --memory 1G --disk 8G"
  }

  provisioner "local-exec" {
    when    = destroy
    command = "multipass delete db-tf --purge || true"
  }
}
