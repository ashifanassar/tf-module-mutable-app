resource "null_resource" "app_deploy" {
  # ...

  # Establishes connection to be used by all
  # generic remote provisioners (i.e. file/remote-exec)

  count = local.INSTANCE_COUNT
  connection {
    type     = "ssh"
    user     = "centos"
    password = "DevOps321"
    host     = element(local.INCTANCE_IPS, count.index)
  }

  provisioner "remote-exec" {
    inline = [
      "ansible-pull -U https://github.com/ashifanassar/ansible.git -e ENV=dev -e COMPONENT= roboshop-pull.yml"
    ]
  }
}