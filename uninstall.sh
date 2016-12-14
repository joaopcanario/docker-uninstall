#!/bin/bash

# Uninstall Script

if [ "${USER}" != "root" ]; then
	echo "$0 must be run as root!"
	exit 2
fi

while true; do
  read -p "Remove all Docker Machine VMs? (Y/N): " yn
  case $yn in
    [Yy]* ) docker-machine rm -f $(docker-machine ls -q); break;;
    [Nn]* ) break;;
    * ) echo "Please answer yes or no."; exit 1;;
  esac
done

echo "Stop boot2docker and delete the VBox image"

boot2docker stop
boot2docker delete

echo "Remove boot2docker & docker app"

sudo rm -rf /Applications/boot2docker
sudo rm -rf /Applications/Docker

echo "Remove all Docker and boot2docker command line tools"

sudo rm -f /usr/local/bin/docker
sudo rm -f /usr/local/bin/boot2docker
sudo rm -f /usr/local/bin/docker-machine
sudo rm -r /usr/local/bin/docker-machine-driver*
sudo rm -f /usr/local/bin/docker-compose

echo "Remove docker packages"

sudo pkgutil --forget io.docker.pkg.docker
sudo pkgutil --forget io.docker.pkg.dockercompose
sudo pkgutil --forget io.docker.pkg.dockermachine
sudo pkgutil --forget io.boot2dockeriso.pkg.boot2dockeriso

echo "Remove boot2docker VBox image"

sudo rm -rf /usr/local/share/boot2docker
rm -rf ~/.boot2docker

echo "Remove boot2docker ssh keys"

rm ~/.ssh/id_boot2docker*

echo "Remove additional boot2docker files in /private folder"

sudo rm -f /private/var/db/receipts/io.boot2docker.*
sudo rm -f /private/var/db/receipts/io.boot2dockeriso.*

echo "Remove docker toolbox config folder"

rm -rf ~/.docker

echo "Remove the environmental variable DOCKER_HOST in case you have fixed it somewhere like e.g. in .bash_profile."
echo "All Done!"