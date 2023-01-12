sudo -s
docker stop $(docker ps -qa)
docker system prune -af