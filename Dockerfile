FROM maven:3.8.6-openjdk-11-slim AS BUILD_IMAGE
COPY ./ vprofile-project
RUN cd vprofile-project &&  mvn install 

FROM tomcat:9-jre11-temurin-noble
LABEL "project"="vprofile"
LABEL "author"="root"
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=BUILD_IMAGE vprofile-project/target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
