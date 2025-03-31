#!/bin/bash

Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
 echo "You must be a root user to run this script, please run sudo ./install.sh" 2>&1
 exit 1
fi

username=$(id -u -n 1000)
builddir=$(pwd)

# Installing Essential Programs
apt install docker-compose -y

# setup docker
sudo usermod -aG docker $USER
sudo systemctl restart docker

# auto cleanup
sudo apt autoremove

printf "\e[1;32mYour system is ready to run docker! Thanks you.\e[0m\n"
