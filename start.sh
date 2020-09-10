#! /bin/bash
echo "||||||||||||||||||||||||||||||"
echo "|||||||||| WARNING! ||||||||||"
echo "||||||||||||||||||||||||||||||"
echo ""
echo "this will stop all Docker PDC services"
read -p "Are you sure?(Y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Yy]$ ]]
then
	#Start
	sudo docker stack deploy -c docker-compose.yml pdc
	
	echo ""
	echo ""
	echo "||||||||||||||||||||||||||||||"
	echo "|||||        DONE        |||||"
	echo "||||||||||||||||||||||||||||||"
fi


