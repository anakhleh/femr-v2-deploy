#it is ok if there run when the images have already been loaded. They will not be loaded again.
# docker load -i dockerImages/ubuntu.16.04.tar
docker load -i dockerImages/mysql.5.7.27.tar
docker load -i dockerImages/femr-app.tar

#Run femr and db
docker-compose -f docker-compose-deploy.yml up 