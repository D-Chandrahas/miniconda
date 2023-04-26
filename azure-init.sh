#!/bin/bash
# run this script as `source azure-init.sh` and give password whenever prompted to
# change user below
user=azureuser
repodir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
sudo apt update
sudo apt upgrade -y
sudo apt install htop ranger tmux
# increase swap to 4gb
sudo dd if=/dev/zero of=/swapfile.img bs=1M count=4000
sudo chmod 0600 /swapfile.img
sudo mkswap /swapfile.img
sudo echo "/swapfile.img swap swap sw 0 0" >> /etc/fstab
sudo swapon /swapfile.img
# install miniconda and copy config files
cd /home/$user
mkdir miniconda3
cd $repodir
bash miniconda.sh -b -f -p /home/$user/miniconda3
cp .condarc /home/$user
cp .sqliterc /home/$user
cd ..
rm -rf $repodir
source /home/$user/miniconda3/etc/profile.d/conda.sh
conda init bash
# git config
git config --global credential.helper store
# close and reopen terminal to activate conda profile