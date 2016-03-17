# Geoserver in a container
#
# VERSION               0.0.1
#
############################################

FROM armhf/debian:8.3
MAINTAINER Sasyan Valentin <https://github.com/VSasyan>

# Installation of java 1.8 jdk 
RUN rm -rf /usr/lib/jvm

COPY jdk1.8.0_73 /usr/lib/jvm/jdk1.8.0_73

RUN update-alternatives --install /usr/bin/java  java  /usr/lib/jvm/jdk1.8.0_73/bin/java  1100
RUN update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/jdk1.8.0_73/bin/javac 1100

# Installation of tomcat7
RUN apt-get update && \
    apt-get -y install tomcat7 && \
    apt-get autoremove && apt-get clean

COPY tomcat7 /etc/default/tomcat7
RUN touch /var/log/tomcat7/catalina.out
RUN mkdir -p /usr/share/tomcat7/common/classes
RUN mkdir -p /usr/share/tomcat7/server/classes
RUN mkdir -p /usr/share/tomcat7/shared/classes
RUN chown -R tomcat7:tomcat7 /usr/share/tomcat7
RUN chown -R tomcat7:tomcat7 /var/log/tomcat7

# Copy geoserver
COPY geoserver.war /var/lib/tomcat7/webapps/geoserver.war

# Start tomcat service
#RUN service tomcat7 start

