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
      "ansible-pull -U https://github.com/ashifanassar/ansible.git -e ENV=dev -e COMPONENT=${var.COMPONENT} -e DOCDB_ENDPOINT=${data.terraform_remote_state.db.outputs.DOCDB_ENDPOINT} -e REDIS_ENDPOINT=${data.terraform_remote_state.db.outputs.REDIS_ENDPOINT[0]} -e APP_VERSION=${var.APP_VERSION} roboshop-pull.yml"
    ]
  }
}