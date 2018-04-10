# Terraform Demo: Mount your EBS NVME

## Goal

For C5 and M5 type instances, EBS volumes are exposed as NVMe block devices. 
The device names are /dev/nvme0n1, /dev/nvme1n1, and so on. 
The device name that you specify in a block device mapping are renamed using NVMe device naming convention (/dev/nvme[0-26]n1).

Here we offer a simple example to link your current volume name with this new naming

## FAQ

- We created a volume with the name /dev/xdvf but my volume now mounts on /dev/nvme[0-26]n1
- My volume name /dev/nvme[0-26]n1 is not identical between instances
- How we can retrieve the volume name to format and mount this
- How we can manage the discrepqncy between old and new instances

## Prerequisites

[Terraform](https://terraform.io/intro/getting-started/install.html)

[Aws Account](https://aws.amazon.com/)

[Cloud-Init](http://cloudinit.readthedocs.io)

## Ready to go

```
terraform plan
terraform apply
```

Step 1: The machine is created

Step 2: Cloud-init installs nvme-cli

Step 3: Cloud-init runs a script to retrieve the volume name with tag /dev/(sd[b-z]|xvd[b-z]) and creates a temporary symbolic link ( removed after reboot )

Step 4: Cloud-init runs a script to retrieve the UUID from the new symlink, formats, mounts and adds to fstab by UUID

Your environment is ready

# Contributing

You can contribute or implement your own things.

# License

MIT