#####Get ubuntu environment
FROM ubuntu:16.04

#Define what args we want to use from the docker-compose
ARG FEMR_APP_VERSION
ARG FEMR_APP_SBT_VERSION
ARG FEMR_APP_SCALA_VERSION
ARG FEMR_SUPERUSER_USERNAME
ARG FEMR_SUPERUSER_PASSWORD
ARG FEMR_ADMIN_USERNAME
ARG FEMR_ADMIN_PASSWORD
ARG FEMR_SECRET_KEY
ARG FEMR_DB_CONNECTION_STRING
ARG MYSQL_USER
ARG MYSQL_PASSWORD

#####Some settings so that python reads text as UTF-8. Reading as ASCII Causes Issues
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

#####don't need to sudo stuff
USER root
WORKDIR /

##### Get the needed programs to set up fEMR environment #####
RUN apt-get update
# RUN  apt-get -y install software-properties-common git unzip curl
RUN apt-get -y install git software-properties-common unzip curl openjdk-8-jdk 
RUN echo $FEMR_APP_SBT_VERSION
RUN \
  curl -L -o "sbt-$FEMR_APP_SBT_VERSION.deb" "https://dl.bintray.com/sbt/debian/sbt-$FEMR_APP_SBT_VERSION.deb" && \
  dpkg -i "sbt-$FEMR_APP_SBT_VERSION.deb" && \
  rm "sbt-$FEMR_APP_SBT_VERSION.deb" && \
  apt-get update && \
  apt-get install sbt && \
  sbt sbtVersion

# Assumes femr will be cloned into this folder
COPY femr /femr
COPY ./entrypoint.sh /docker_setup/entrypoint.sh
COPY ./wait-for-it.sh /docker_setup/wait-for-it.sh

WORKDIR femr
RUN sbt clean compile dist
RUN ls .

WORKDIR /
RUN unzip "femr/target/universal/femr-$FEMR_APP_VERSION.zip" -d "femr/target/universal/"
RUN mkdir -p "femr/target/universal/femr-$FEMR_APP_VERSION/public/img"
RUN ls "femr/target/universal/femr-$FEMR_APP_VERSION/"

#Set Superuser Credentials
RUN sed -i "/default\.superuser\.username=.*/c\default\.superuser\.username=\"${FEMR_SUPERUSER_USERNAME}\"" "femr/target/universal/femr-$FEMR_APP_VERSION/conf/application.conf"
RUN sed -i "/default\.superuser\.password=.*/c\default\.superuser\.password=\"${FEMR_SUPERUSER_PASSWORD}\"" "femr/target/universal/femr-$FEMR_APP_VERSION/conf/application.conf"

#Set Default Admin Credentials
RUN sed -i "/default\.admin\.username=.*/c\default\.admin\.username=\"${FEMR_ADMIN_USERNAME}\"" "femr/target/universal/femr-$FEMR_APP_VERSION/conf/application.conf"
RUN sed -i "/default\.admin\.password=.*/c\default\.admin\.password=\"${FEMR_ADMIN_PASSWORD}\"" "femr/target/universal/femr-$FEMR_APP_VERSION/conf/application.conf"

#Set DB connection info
RUN sed -i "/db\.default\.username=.*/c\db\.default\.username=\"${MYSQL_USER}\"" "femr/target/universal/femr-$FEMR_APP_VERSION/conf/application.conf"
RUN sed -i "/db\.default\.password=.*/c\db\.default\.password=\"${MYSQL_PASSWORD}\"" "femr/target/universal/femr-$FEMR_APP_VERSION/conf/application.conf"
RUN sed -i "/db\.default\.url=.*/c\db\.default\.url=\"${FEMR_DB_CONNECTION_STRING}\"" "femr/target/universal/femr-$FEMR_APP_VERSION/conf/application.conf"

#Set Application Secret. Note, the build process removes it from the file
RUN ls
RUN echo "\n\nplay.http.secret.key=\"${FEMR_SECRET_KEY}\"" >> "femr/target/universal/femr-$FEMR_APP_VERSION/conf/application.conf"
RUN echo "play.evolutions.db.default.autoApply=true" >> "femr/target/universal/femr-$FEMR_APP_VERSION/conf/application.conf"
# RUN sed -i "/play\.http\.secret\.key=.*/c\play\.http\.secret\.key=\"${FEMR_SECRET_KEY}\"" "femr/target/universal/femr-$FEMR_APP_VERSION/conf/application.conf"


#This will not support the internet connection functionality. Just make sure just in case it is set to yes
RUN sed -i "/internetconnection.enableInternetConnectivityFunctionality.*/c\internetconnection.enableInternetConnectivityFunctionality = \"false\"" "femr/target/universal/femr-$FEMR_APP_VERSION/conf/application.conf"

RUN cat "femr/target/universal/femr-$FEMR_APP_VERSION/conf/application.conf"

RUN mv "femr/target/universal/femr-$FEMR_APP_VERSION/conf/application.conf" "femr/target/universal/femr-$FEMR_APP_VERSION/conf/prod.conf"

RUN cat "femr/target/universal/femr-$FEMR_APP_VERSION/conf/prod.conf"

RUN ls "femr/target/universal/femr-$FEMR_APP_VERSION"

RUN ls "femr/target/universal/femr-$FEMR_APP_VERSION/bin/"


#Run femr
ENTRYPOINT /bin/bash /docker_setup/wait-for-it.sh db:3306 -- "/femr/target/universal/femr-$FEMR_APP_VERSION/bin/femr" "-Dconfig.file=/femr/target/universal/femr-$FEMR_APP_VERSION/conf/prod.conf" "-Dlogger.file=/femr/target/universal/femr-$FEMR_APP_VERSION/conf/prod-logger.xml" "-Duser.home=/femr/target/universal/femr-$FEMR_APP_VERSION"