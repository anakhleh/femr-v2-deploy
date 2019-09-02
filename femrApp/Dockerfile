
#####Get ubuntu environment
FROM ubuntu:16.04

#####Some settings so that python reads text as UTF-8. Reading as ASCII Causes Issues
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

#####don't need to sudo stuff
USER root
WORKDIR /

##### Get the needed programs to set up fEMR environment #####
RUN apt-get update
RUN apt-get install git unzip

# Get Java
RUN add-apt-repository ppa:webupd8team/java
RUN apt-get update
RUN apt-get install oracle-java8-installer

#Get SBT
RUN echo "deb https://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
RUN apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823
RUN apt-get update
RUN apt-get install sbt

##### Get, build, move femr #####

#Make directory to build femr
RUN mkdir -p /home/femr/Git
WORKDIR /home/femr/Git

#Get latest femr master and get app version
RUN git clone https://github.com/FEMR/femr
#(1)Get the line containing 'val appVersion', (2) The last word in the line, (3) Remove the quotes
RUN export FEMR_APP_VERSION=$(awk '/val appVersion/{print}' | awk 'NF>1{print $NF}' | sed 's/\"//g')

#Build femr
RUN sbt clean compile dist
RUN mkdir -p /opt/femr
RUN mv "/home/femr/Git/femr/target/universal/femr-$FEMR_APP_VERSION.zip" "/opt/femr/femr-$FEMR_APP_VERSION.zip"

#giving permissions to other user not needed because we are root of the docker container, and so did not create another user

#unzip
WORKDIR /opt/femr
RUN unzip "femr-$FEMR_APP_VERSION.zip"

#Create public/img folder and find a default image
RUN mkdir -p "femr-$FEMR_APP_VERSION/public"
RUN mkdir -p "femr-$FEMR_APP_VERSION/public/img"

##### Prepare the prod.conf file #####
RUN mv "femr-$FEMR_APP_VERSION/conf/application.conf" "femr-$FEMR_APP_VERSION/conf/prod.conf"
#Set random SuperUser Username
RUN sed "s/^default.admin.username=.*/default.admin.username=\"$FEMR_SUPERUSER_USERNAME\""
#Set random SuperUser Password
RUN sed "s/^default.admin.password=.*/default.admin.password=\"$FEMR_SUPERUSER_PASSWORD\""
#Set application secret
RUN sed "s/^play.http.secret.key=.*/play.http.secret.key=\"$FEMR_SECRET_KEY\""
#Set db connection urk
RUN sed "s/^db.default.url=.*/db.default.url=\"jdbc:mysql://localhost/femr?characterEncoding=UTF-8\""
#Set database default username
RUN sed "s/^db.default.username=.*/db.default.username=\"$MYSQL_USER\""
#Set database default password
RUN sed "s/^db.default.password=.*/db.default.password=\"$MYSQL_PASSWORD\""


#Run femr
ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]