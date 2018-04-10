#!/bin/bash

# https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/device_naming.html#available-ec2-device-names

echo "Create a temporary symbolic link to retrieve UUID on first boot"

VOLUMES_NAME=$(find /dev | grep -i 'nvme[0-21]n1$')
echo "---> volumes list:"
echo $${VOLUMES_NAME[@]} | tr " " "\n"

for VOLUME in $${VOLUMES_NAME}
do
 ALIAS=$(nvme id-ctrl -v "$${VOLUME}"| grep -Po '/dev/(sd[b-z]|xvd[b-z])')
 if [ ! -z "$${ALIAS}" ]; then
  echo "---> create link from $${VOLUME} to $${ALIAS}"
  ln -s "$${VOLUME}" "$${ALIAS}"
 fi
done