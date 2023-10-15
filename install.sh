#!/bin/bash
sudo apt update -y
sudo wget https://nodejs.org/dist/v18.18.2/node-v18.18.2-linux-x64.tar.xz
sudo tar -xvf node-v18.18.2-linux-x64.tar.xz
sudo echo "PATH=$PATH:/home/ubuntu/node-v18.18.2-linux-x64/bin" >> ~/.bashrc
source  ~/.bashrc
npm install --global yarn
sudo apt install -y g++ gcc libgcc libstdc++ linux-headers make python libtool automake autoconf nasm wkhtmltopdf vips vips-dev libjpeg-turbo libjpeg-turbo-dev -y
sudo wget https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.jammy_amd64.deb
sudo dpkg -i wkhtmltox_0.12.6.1-2.jammy_amd64.deb
sudo apt --fix-broken install -y 
sudo apt install -y git
git clone https://github.com/AquilaCMS/AquilaCMS.git
cd AquilaCMS/
yarn install
npm start

