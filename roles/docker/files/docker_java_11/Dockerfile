FROM ubuntu:20.04

# docker common
COPY .docker_common /tmp/.docker_common
RUN ./tmp/.docker_common

# java
RUN apt-get update --fix-missing
RUN	apt-get install -y \
    openjdk-11-jdk \
    maven && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo 'ping localhost &' >  /bootstrap.sh
RUN echo 'sleep infinity' >>  /bootstrap.sh
RUN chmod +x /bootstrap.sh

USER bbst
WORKDIR /home/bbst

RUN echo 'DOCKER-JAVA-11' > /tmp/docker_type

CMD /bootstrap.sh
