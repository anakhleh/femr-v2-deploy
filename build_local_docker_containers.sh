#set up env file for docker
bash set_up_docker_env_file.sh

#create local docker image for femr
docker-compose -f docker-compose-build-femr-image.yml build --force-rm
docker save femr-v2-deploy_femr-app:latest > ./dockerImages/femr-app.tar

#get mysql image tar from google drive link
curl https://drive.google.com/open?id=1gd5Cbs54Vptj5loqe6_oJirv5w8KhDq1 --output dockerImages/mysql-5-7-27.tar