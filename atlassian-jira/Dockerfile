FROM airdock/oracle-jdk:jdk-1.8 

ENV JIRA_PACK=atlassian-jira-software-7.3.0.tar.gz
ENV JIRA_HOME /opt/jira

RUN useradd --uid 1000 jira --home $JIRA_HOME 

RUN apt-get update && apt-get -y install bash tar wget \
    && cd /tmp && wget -q https://www.atlassian.com/software/jira/downloads/binary/$JIRA_PACK \
    && mkdir /usr/share/jira $JIRA_HOME \
    && tar xz --strip-components 1 -f /tmp/$JIRA_PACK -C /usr/share/jira \
    && mv /usr/share/jira/logs /var/log/jira \
    && ln -s /var/log/jira /usr/share/jira/logs \
    && chown -R jira:jira /var/log/jira /usr/share/jira $JIRA_HOME

RUN apt-get clean \
    && rm -rf /var/lib/apt/lists/* /var/lib/apt/lists/* /tmp/* /var/tmp/*

USER jira

WORKDIR $JIRA_HOME

VOLUME $JIRA_HOME

EXPOSE 8080

CMD /usr/share/jira/bin/start-jira.sh -fg

