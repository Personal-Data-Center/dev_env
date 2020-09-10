#! /bin/bash
echo "||||||||||||||||||||||||||||||"
echo "|||||||||| WARNING! ||||||||||"
echo "||||||||||||||||||||||||||||||"
echo ""
echo "this will delete all the files and reinstall"
read -p "Are you sure?(Y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	#Stop PDC services
	sudo docker stack rm pdc

	#Remove all folders
	sudo rm -r launcher
	sudo rm -r authorizator
	sudo rm -r system
	sudo rm -r store
	sudo rm -r db

	./setup.sh
fi


