#!/bin/bash

apt-get install python3 
sudo apt install python3-pip
pip3 install faker
 sudo apt-get install -y python3-venv
mkdir -p ~/.venvs/uxo
cd ~/.venvs
python3 -m venv uxo
source uxo/bin/activate
pip install faker
