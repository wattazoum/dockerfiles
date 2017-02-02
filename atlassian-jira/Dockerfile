FROM airdock/oracle-jdk:jdk-1.8 

ENV JIRA_PACK=atlassian-jira-software-7.3.0.tar.gz

ENV DATADIR=/opt/jira
ENV JIRA_HOME=$DATADIR/home
ENV TOMCAT_OVERLAY=$DATADIR/container

RUN apt-get update && apt-get -y install bash tar wget \
    && cd /tmp && wget -q https://www.atlassian.com/software/jira/downloads/binary/$JIRA_PACK \
    && mkdir /usr/share/jira $DATADIR \
    && tar xz --strip-components 1 -f /tmp/$JIRA_PACK -C /usr/share/jira 

RUN useradd --uid 1000 --home $DATADIR jira

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/lib/apt/lists/* /tmp/* /var/tmp/* /tmp/$JIRA_PACK

ADD run.sh /run.sh

VOLUME $DATADIR

WORKDIR $DATADIR

EXPOSE 8080

CMD /run.sh

