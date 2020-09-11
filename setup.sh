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
    	
    	#Install dependencies
    	
    	sudo apt install docker.io git atom > /dev/null 2>&1
    	
    	#Launcher

	git clone https://github.com/Personal-Data-Center/launcher.git > /dev/null 2>&1
	echo ""
	echo ""
	echo "--BUILDING LAUNCHER DOCKER IMAGE--"
	echo ""
	echo ""
	cd launcher

	sudo docker build . -t pdc/launcher > /dev/null 2>&1

	cd ..

	#store

	git clone https://github.com/Personal-Data-Center/store.git > /dev/null 2>&1
	echo ""
	echo ""
	echo "--BUILDING STORE DOCKER IMAGE--"
	echo ""
	echo ""
	cd store

	sudo docker build . -t pdc/store > /dev/null 2>&1

	cd ..


	#authorizator

	git clone https://github.com/Personal-Data-Center/authorizator.git > /dev/null 2>&1
	echo ""
	echo ""
	echo "--BUILDING AUTHORIZATOR DOCKER IMAGE--"
	echo ""
	echo ""
	cd authorizator

	sudo docker build . -t pdc/authorizator > /dev/null 2>&1

	cd ..

	#system

	git clone https://github.com/Personal-Data-Center/system.git > /dev/null 2>&1
	echo ""
	echo ""
	echo "--BUILDING SYSTEM DOCKER IMAGE--"
	echo ""
	echo ""
	cd system

	sudo docker build . -t pdc/system > /dev/null 2>&1

	cd ..

	#creating database persistence folder
	mkdir db
	
	echo ""
	echo ""
	echo "--CREATING DATABASE FILE--"
	echo ""
	echo ""
	
	file="db/setup.sql"
	echo "CREATE DATABASE IF NOT EXISTS launcher;" > $file 
	echo "CREATE DATABASE IF NOT EXISTS system;" >> $file
	echo "CREATE DATABASE IF NOT EXISTS store;" >> $file 
	echo "CREATE DATABASE IF NOT EXISTS authorizator;" >> $file
	cat $file
	
	echo ""
	echo ""
	echo "--DATABASE PERSISTENCE FOLDER CREATED--"
	echo ""
	echo ""

	#||||||DOCKER SETUP||||||

	#setup cluster

	sudo docker swarm init > /dev/null 2>&1
	
	echo ""
	echo ""
	echo "--DEPLOYING DOCKER STACK--"
	echo ""
	echo ""

	until sudo docker stack deploy -c docker-compose.yml pdc > /dev/null 2>&1
	do
	    tput cuu 1 && tput el
	    echo -e 'WAITING STACK DEPLOYMENT'
	    sleep 1
	    tput cuu 1 && tput el
	    echo -e 'WAITING STACK DEPLOYMENT .'
	    sleep 1
	    tput cuu 1 && tput el
	    echo -e 'WAITING STACK DEPLOYMENT . .'
	    sleep 1
	    tput cuu 1 && tput el
	    echo -e 'WAITING STACK DEPLOYMENT . . .'
	done
	
	echo ""
	echo ""
	echo "CREATING DATABASES"
	echo ""
	echo ""
	
	echo 'WAITING FOR CREATION'
	
	until sudo docker exec -ti pdc_mariadb.1.$(sudo docker service ps -f 'name=pdc_mariadb' pdc_mariadb -q --no-trunc | head -n1) bash -c 'mariadb --user=root --password=pdc_dev < /var/lib/mysql/setup.sql' > /dev/null 2>&1
	do
	    tput cuu 1 && tput el
	    echo -e 'WAITING FOR CREATION'
	    sleep 1
	    tput cuu 1 && tput el
	    echo -e 'WAITING FOR CREATION .'
	    sleep 1
	    tput cuu 1 && tput el
	    echo -e 'WAITING FOR CREATION . .'
	    sleep 1
	    tput cuu 1 && tput el
	    echo -e 'WAITING FOR CREATION . . .'
	done	
	
	echo ""
	echo ""
	echo "||||||||||||||||||||||||||||||"
	echo "||||||  SETUP FINISHED  ||||||"
	echo "||||||      HEAD TO     ||||||"
	echo "|||||| http://localhost ||||||"
	echo "||||||||||||||||||||||||||||||"

fi




