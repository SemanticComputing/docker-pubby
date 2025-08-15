FROM secoresearch/tomcat-varnish:tomcat7
USER 0

ENV PATH_PUBBY_WEBAPP "$PATH_WEBAPP_ROOT"

RUN apt-get install -y unzip

WORKDIR /tmp

# Install latest ant version (1.9) compatible with Java 1.6

RUN wget https://archive.apache.org/dist/ant/binaries/apache-ant-1.9.9-bin.tar.gz
RUN tar xzvf apache-ant-1.9.9-bin.tar.gz
RUN mv apache-ant-1.9.9 /opt/
ENV ANT_HOME /opt/apache-ant-1.9.9
RUN rm apache-ant-1.9.9-bin.tar.gz

RUN wget -O pubby-0.3.3.zip https://github.com/cygri/pubby/archive/refs/tags/v0.3.3.zip
RUN unzip pubby-0.3.3.zip

WORKDIR /tmp/pubby-0.3.3
RUN /opt/apache-ant-1.9.9/bin/ant

RUN rm -r "$PATH_PUBBY_WEBAPP"

WORKDIR /tmp
RUN mv -T pubby-0.3.3/webapp "$PATH_PUBBY_WEBAPP"
RUN rm -rf pubby*

USER 10001
