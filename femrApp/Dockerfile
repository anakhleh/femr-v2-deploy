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

RUN git clone https://github.com/FEMR/femr

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

#Set Application Secret
RUN sed -i "/play\.http\.secret\.key=.*/c\play\.http\.secret\.key=\"${FEMR_SECRET_KEY}\"" "femr/target/universal/femr-$FEMR_APP_VERSION/conf/application.conf"

#This will not support the internet connection functionality. Just make sure just in case it is set to yes
RUN sed -i "/internetconnection.enableInternetConnectivityFunctionality.*/c\internetconnection.enableInternetConnectivityFunctionality = \"false\"" femr/conf/application.conf

RUN cat femr/conf/application.conf

RUN mv "femr/target/universal/femr-$FEMR_APP_VERSION/conf/application.conf" "femr/target/universal/femr-$FEMR_APP_VERSION/conf/prod.conf"

# COPY /docker_setup [ "/bin/bash", "./entrypoint.sh" ]

# #For development purposes, check the config files
# RUN cat femr/conf/application.conf





# RUN git clone https://github.com/FEMR/femr
# WORKDIR /femr

# RUN git clone https://github.com/FEMR/femr
# WORKDIR /femr
# ENV FEMR_APP_VERSION "$(grep 'appVersion' Build.sbt)"
# RUN echo "APP VERSION IS $FEMR_APP_VERSION"
# RUN apt-get update \
#     && apt-get -y install software-properties-common git unzip curl \
#     && apt-get -y install openjdk-8-jdk \
#     && mkdir -p /home/femr/Git \
#     && git clone https://github.com/FEMR/femr /home/femr/Git/ \
#     && export FEMR_APP_VERSION=$(awk '/val appVersion/{print}' /home/femr/Git/femr/Build.sbt | awk 'NF>1{print $NF}' | sed 's/\"//g') \
#     && echo $(awk '/val appVersion/{print}' /home/femr/Git/femr/Build.sbt) \
#     && echo $(awk '/val appVersion/{print}' /home/femr/Git/femr/Build.sbt | awk 'NF>1{print $NF}') \
#     && echo "FEMR_APP_VERSION IS $FEMR_APP_VERSION" \
#     && export SBT_VERSION=$(awk '/sbt.version=/{print}' /home/femr/Git/femr/project/build.properties |  ) \
#     && echo $(awk '/sbt.version=/{print}' /home/femr/Git/femr/project/build.properties) \
#     && echo "SBT_VERSION IS $SBT_VERSION" \
#     && export SCALA_VERSION=$(awk '/val currentScalaVersion/{print}' /home/femr/Git/femr/Build.sbt | awk 'NF>1{print $NF}' | sed 's/\"//g') \
#     && echo "SCALA_VERSION IS $SCANA_VERSION" \
#     && curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb \
#     && dpkg -i sbt-$SBT_VERSION.deb \
#     && rm sbt-$SBT_VERSION.deb \
#     && apt-get update \
#     && apt-get install sbt \
#     && sbt sbtVersion \
#     && sbt clean compile dist /home/femr/Git/femr \
#     && mkdir -p /opt/femr \
#     && mv "/home/femr/Git/femr/target/universal/femr-$FEMR_APP_VERSION.zip" "/opt/femr/femr-$FEMR_APP_VERSION.zip"

#the first one gets you `add-apt-repository`

# Get Java - old one does t work because you need an account now
# RUN add-apt-repository ppa:webupd8team/java
# RUN apt-get update
# RUN apt-get -y install oracle-java8-installer
# RUN 


##### Get, build, move femr #####

#Make directory to build femr
# RUN 
# WORKDIR /home/femr/Git

#Get latest femr master and get app version
# RUN 
#(1)Get the line containing 'val appVersion', (2) The last word in the line, (3) Remove the quotes
# RUN 
# RUN echo "$FEMR_APP_VERSION"

#Get SBT
# RUN echo "deb http://dl.bintray.com/sbt/debian /" | tee -a /etc/apt/sources.list.d/sbt.list
# RUN apt-key adv --keyserver hkps://keyserver.ubuntu.com:443 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823

# RUN 
# RUN echo "$SBT_VERSION"

# ENV SCALA_DEB http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.deb
# RUN \
#   curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb && \
#   dpkg -i sbt-$SBT_VERSION.deb && \
#   rm sbt-$SBT_VERSION.deb && \
#   apt-get update && \
#   apt-get install sbt && \
#   sbt sbtVersion

# #Build femr
# RUN 

# #giving permissions to other user not needed because we are root of the docker container, and so did not create another user

# #unzip
# WORKDIR /opt/femr
# RUN unzip "femr-$FEMR_APP_VERSION.zip"
# '
#  && mkdir -p "/opt/femr/femr-$FEMR_APP_VERSION/public \
#  && mkdir -p "/opt/femr/femr-$FEMR_APP_VERSION/public/img \
#  && mv "/opt/femr/femr-$FEMR_APP_VERSION/conf/application.conf" "/opt/femr/femr-$FEMR_APP_VERSION/conf/prod.conf"
#  && cd "/opt/femr/femr-$FEMR_APP_VERSION" \
#  && sed -i "s/^default.admin.username=.*/default.admin.username=\"$FEMR_SUPERUSER_USERNAME\"" conf/prod.conf \
#  && sed -i "s/^default.admin.password=.*/default.admin.password=\"$FEMR_SUPERUSER_PASSWORD\"""s/^default.admin.password=.*/default.admin.password=\"$FEMR_SUPERUSER_PASSWORD\"" conf/prod.conf
# 
# '
# #Create public/img folder and find a default image
# RUN"
# RUN "

# ##### Prepare the prod.conf file #####
# RUN mv "/opt/femr/femr-$FEMR_APP_VERSION/conf/application.conf" "/opt/femr/femr-$FEMR_APP_VERSION/conf/prod.conf"
# #Set random SuperUser Username
# RUN sed "s/^default.admin.username=.*/default.admin.username=\"$FEMR_SUPERUSER_USERNAME\""
# #Set random SuperUser Password
# RUN sed "s/^default.admin.password=.*/default.admin.password=\"$FEMR_SUPERUSER_PASSWORD\""
# #Set application secret
# RUN sed "s/^play.http.secret.key=.*/play.http.secret.key=\"$FEMR_SECRET_KEY\""
# #Set db connection urk
# RUN sed "s/^db.default.url=.*/db.default.url=\"jdbc:mysql://localhost/femr?characterEncoding=UTF-8\""
# #Set database default username
# RUN sed "s/^db.default.username=.*/db.default.username=\"$MYSQL_USER\""
# #Set database default password
# RUN sed "s/^db.default.password=.*/db.default.password=\"$MYSQL_PASSWORD\""

COPY . /docker_setup

# #Run femr
ENTRYPOINT [ "/bin/bash", "/docker_setup/wait-for-it.sh", "db:3306", "--", "/docker_setup/entrypoint.sh"]