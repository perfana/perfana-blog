docker-compose stop $1 && docker-compose rm -f $1 && docker-compose --compatibility up -d $1
