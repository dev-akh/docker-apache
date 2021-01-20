docker stop $(docker ps -a -q)
docker rm $(docker ps -a -q)
docker image prune -f -a
docker volume prune -f