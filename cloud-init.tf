data "template_file" "config" {
  template = "${file("${path.module}/init.tpl")}"

  vars {
    hostname = "${var.hostname}"
  }
}

data "template_file" "alias_nvme" {
  template = "${file("${path.module}/scripts/ebs_alias.sh.tpl")}"
}

data "template_file" "attach_nvme" {
  template = "${file("${path.module}/scripts/ebs_mount.sh.tpl")}"

  vars {
    volume_name = "/dev/xvdf"
    mount_point = "/data"
    file_system = "ext4"
  }
}

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false

  part {
    filename     = "terraform.tpl"
    content_type = "text/cloud-config"
    content      = "${data.template_file.config.rendered}"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.alias_nvme.rendered}"
  }

  part {
    content_type = "text/x-shellscript"
    content      = "${data.template_file.attach_nvme.rendered}"
  }
}
