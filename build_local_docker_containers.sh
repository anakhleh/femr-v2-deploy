echo '[!] Running build_local_docker_containers.sh'

#set up env file for docker
echo '[i] -     Running set_up_docker_env_file.sh'
bash set_up_docker_env_file.sh

#get the ubuntu:16.04 image needed for creation of the femr image
#load it in so that building the femr image does not need to pull the 
#image from dockerhub

rm -rf dockerImages/*.tar

echo '[i] -     Getting Ubuntu Docker Image'
curl -L 'https://www.dropbox.com/s/2k5kgsxhxxpq7j7/ubuntu.16.04.tar?dl=1' --output dockerImages/ubuntu.16.04.tar
docker load -i dockerImages/ubuntu.16.04.tar

#create local docker image for femr
echo '[i] -     Building fEMR Docker Image'
docker-compose -f docker-compose-build-femr-image.yml build --force-rm
docker save femr-v2-deploy_femr-app:latest > ./dockerImages/femr-app.tar

#get mysql image tar from external source. Don't pull from docker because
#then we'd have to have a docker-hub account for this step.
echo '[i] -     Getting MySQL Docker Image'
curl -L 'https://www.dropbox.com/s/5trnxmhghlycowv/mysql.5.2.27.tar?dl=1' --output dockerImages/mysql.5.7.27.tar

echo '[!] Exiting build_local_docker_containers.sh'
