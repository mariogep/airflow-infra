#!/bin/bash
sudo dnf update -y
sudo dnf install docker -y
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker $USER
newgrp docker

# docker compose
sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# portainer
sudo docker volume create portainer_data
sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest

# airflow
cd /home/ec2-user
curl -LfO 'https://raw.githubusercontent.com/mariocstack/docker-airflow/main/v251/dockerfile'
curl -LfO 'https://raw.githubusercontent.com/mariocstack/docker-airflow/main/v251/docker-compose.yaml'

# sudo rm requirements.txt
curl -LfO 'https://raw.githubusercontent.com/mariocstack/docker-airflow/main/v251/requirements.txt'

mkdir -p ./dags ./logs ./plugins ./config
sudo chmod +777 ./dags ./logs ./plugins ./config
echo -e "AIRFLOW_UID=$(id -u)" > .env
AIRFLOW_UID=50000
sudo docker-compose up airflow-init
sudo docker-compose up