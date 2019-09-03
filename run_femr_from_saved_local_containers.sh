#it is ok if there run when the images have already been loaded. They will not be loaded again.
docker load < dockerImages/mysql-5-7-27.tar
docker load < dockerImages/femr-app.tar

docker-compose -f docker-compose-deploy.yml up -d