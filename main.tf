provider "aws" {
  region = "${var.aws_region}"
}

resource "aws_instance" "instance" {
  ami           = "${var.ami}"
  instance_type = "${var.instance_type}"

  user_data = "${data.template_cloudinit_config.config.rendered}"

  subnet_id = "${var.subnet_id}"
  key_name  = "${var.key_name}"

  tags {
    Name = "${var.hostname}"

    managed-by = "Terraform"
  }
}

resource "aws_ebs_volume" "nvme" {
  size              = 100
  availability_zone = "${var.availability_zone}"
  type              = "gp2"
}

resource "aws_volume_attachment" "nvme_mount" {
  device_name  = "/dev/xvdf"
  skip_destroy = true
  force_detach = true
  volume_id    = "${aws_ebs_volume.nvme.id}"
  instance_id  = "${aws_instance.instance.id}"
}
