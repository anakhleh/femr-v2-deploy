#set up env file for docker
bash set_up_docker_env_file.sh

#create local docker images we can run femr off of
docker-compose build --compress --force-rm

#