resource "null_resource" "app_deploy" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)

  count = local.INSTANCE_COUNT
  triggers = {
    always_run = timestamp()
  }
  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = element(local.INCTANCE_IPS, count.index)
  }

  provisioner "remote-exec" {
    inline = [
      "ansible-pull -U https://github.com/b57-clouddevops/ansible.git -e ENV=dev -e COMPONENT=${var.COMPONENT} -e APP_VERSION=${var.APP_VERSION} roboshop-pull.yml"
    ]
  }
}