#! /bin/bash

cd "$(dirname "$0")"

#||||||SOURCE DOWNLOAD AND IMG BUILD||||||

echo "||||||||||||||||||||||||||||||"
echo "|| PDC DEV ENVIROMENT SETUP ||"
echo "||||||||||||||||||||||||||||||"

read -p "Install PDC development enviroment?(Y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
    	
    	git clone https://github.com/Personal-Data-Center/pdc_dev.git

	#authorizator

	git clone https://github.com/Personal-Data-Center/authorizator.git
	echo ""
	echo ""
	echo "--BUILDING AUTHORIZATOR DOCKER IMAGE--"
	echo ""
	echo ""
	cd authorizator

	sudo docker build . -t pdc/authorizator

	cd ..

	#creating database persistence folder
	mkdir db
	

	#||||||DOCKER SETUP||||||

	#setup cluster

	sudo docker swarm init
	
	echo ""
	echo ""
	echo "--DEPLOYING DOCKER STACK--"
	echo ""
	echo ""

	sudo docker stack deploy -c docker-compose.yml pdc
	
	echo ""
	echo ""
	echo "||||||||||||||||||||||||||||||"
	echo "||||||  SETUP FINISHED  ||||||"
	echo "||||||      HEAD TO     ||||||"
	echo "|||||| http://localhost ||||||"
	echo "||||||||||||||||||||||||||||||"

fi




