
#####Get ubuntu environment
FROM ubuntu:16.04

#####Some settings so that python reads text as UTF-8. Reading as ASCII Causes Issues
ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8

#####don't need to sudo stuff
USER root
WORKDIR /

##### Get the needed programs to set up fEMR environment #####
RUN apt-get update \
    && apt-get -y install software-properties-common git unzip curl \
    && apt-get -y install openjdk-8-jdk \
    && mkdir -p /home/femr/Git \
    && git clone https://github.com/FEMR/femr /home/femr/Git/ \
    && export FEMR_APP_VERSION=$(awk '/val appVersion/{print}' /home/femr/Git/femr/Build.sbt | awk 'NF>1{print $NF}' | sed 's/\"//g') \
    && echo $(awk '/val appVersion/{print}' /home/femr/Git/femr/Build.sbt) \
    && echo $(awk '/val appVersion/{print}' /home/femr/Git/femr/Build.sbt | awk 'NF>1{print $NF}') \
    && echo "FEMR_APP_VERSION IS $FEMR_APP_VERSION" \
    && export SBT_VERSION=$(awk '/sbt.version=/{print}' /home/femr/Git/femr/project/build.properties | cut -d "=" -f 2 ) \
    && echo $(awk '/sbt.version=/{print}' /home/femr/Git/femr/project/build.properties) \
    && echo "SBT_VERSION IS $SBT_VERSION" \
    && export SCALA_VERSION=$(awk '/val currentScalaVersion/{print}' /home/femr/Git/femr/Build.sbt | awk 'NF>1{print $NF}' | sed 's/\"//g') \
    && echo "SCALA_VERSION IS $SCANA_VERSION" \
    && curl -L -o sbt-$SBT_VERSION.deb https://dl.bintray.com/sbt/debian/sbt-$SBT_VERSION.deb \
    && dpkg -i sbt-$SBT_VERSION.deb \
    && rm sbt-$SBT_VERSION.deb \
    && apt-get update \
    && apt-get install sbt \
    && sbt sbtVersion \
    && sbt clean compile dist /home/femr/Git/femr \
    && mkdir -p /opt/femr \
    && mv "/home/femr/Git/femr/target/universal/femr-$FEMR_APP_VERSION.zip" "/opt/femr/femr-$FEMR_APP_VERSION.zip"

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


# #Run femr
# ENTRYPOINT ["/bin/bash", "./entrypoint.sh"]