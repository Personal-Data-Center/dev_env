#! /bin/bash

#||||||SOURCE DOWNLOAD AND IMG BUILD||||||

echo "||||||||||||||||||||||||||||||"
echo "|| PDC DEV ENVIROMENT SETUP ||"
echo "||||||||||||||||||||||||||||||"

read -p "Install PDC development enviroment?(Y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    	
    	#Install dependencies
    	
    	sudo apt install docker.io git atom
    	
    	#Launcher

	git clone https://github.com/Personal-Data-Center/launcher.git
	echo ""
	echo ""
	echo "BUILDING LAUNCHER DOCKER IMAGE"
	echo ""
	echo ""
	cd launcher

	sudo docker build . -t pdc/launcher

	cd ..

	#store

	git clone https://github.com/Personal-Data-Center/store.git
	echo ""
	echo ""
	echo "BUILDING STORE DOCKER IMAGE"
	echo ""
	echo ""
	cd store

	sudo docker build . -t pdc/store

	cd ..


	#authorizator

	git clone https://github.com/Personal-Data-Center/authorizator.git
	echo ""
	echo ""
	echo "BUILDING AUTHORIZATOR DOCKER IMAGE"
	echo ""
	echo ""
	cd authorizator

	sudo docker build . -t pdc/authorizator

	cd ..

	#system

	git clone https://github.com/Personal-Data-Center/system.git
	echo ""
	echo ""
	echo "BUILDING SYSTEM DOCKER IMAGE"
	echo ""
	echo ""
	cd system

	sudo docker build . -t pdc/system

	cd ..

	#creating database persistence folder
	mkdir db
	
	echo "DATABASE PERSISTENCE FOLDER CREATED"
	echo ""
	echo ""

	#||||||DOCKER SETUP||||||

	#setup cluster

	sudo docker swarm init

	sudo docker stack deploy -c docker-compose.yml pdc
	echo ""
	echo ""
	echo "||||||||||||||||||||||||||||||"
	echo "||||||| SETUP FINISHED |||||||"
	echo "||||||||||||||||||||||||||||||"

fi




