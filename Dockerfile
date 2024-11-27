FROM secoresearch/tomcat-varnish:tomcat-7
USER 0

ENV PATH_PUBBY_WEBAPP "$PATH_WEBAPP_ROOT"

RUN apt-get install -y unzip
WORKDIR /tmp
RUN wget http://wifo5-03.informatik.uni-mannheim.de/pubby/download/pubby-0.3.3.zip
RUN unzip pubby-0.3.3.zip
RUN rm -r "$PATH_PUBBY_WEBAPP"
RUN mv -T pubby-0.3.3/webapp "$PATH_PUBBY_WEBAPP"
RUN cp -R pubby-0.3.3/* "$PATH_WEBAPPS"
RUN rm -rf tmp/*
RUN apt-get remove -y unzip

USER 10001
