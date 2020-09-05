#! /bin/bash

#||||||SOURCE DOWNLOAD AND IMG BUILD||||||

#Launcher

git clone https://github.com/Personal-Data-Center/launcher.git

echo "BUILDING LAUNCHER DOCKER IMAGE\n\n"

cd launcher

sudo docker build . -t pdc/launcher

cd ..

#store

git clone https://github.com/Personal-Data-Center/store.git

echo "BUILDING STORE DOCKER IMAGE\n\n"

cd store

sudo docker build . -t pdc/store

cd ..


#authorizator

git clone https://github.com/Personal-Data-Center/authorizator.git

echo "BUILDING AUTHORIZATOR DOCKER IMAGE\n\n"

cd authorizator

sudo docker build . -t pdc/authorizator

cd ..

#system

git clone https://github.com/Personal-Data-Center/system.git

echo "BUILDING SYSTEM DOCKER IMAGE\n\n"

cd system

sudo docker build . -t pdc/system

cd ..


#||||||DOCKER SETUP||||||

#setup cluster

sudo docker swarm init

sudo docker stack deploy -c docker-compose.yml pdc


