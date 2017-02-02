#!/bin/bash

# Defined in Docker Image
#
# ENV DATADIR=/opt/jira
# ENV JIRA_HOME=$DATADIR/home
# ENV TOMCAT_OVERLAY=$DATADIR/container


[ ! -d "$JIRA_HOME" ] && mkdir "$JIRA_HOME"

if [ -r "$TOMCAT_OVERLAY/bin/setenv.sh" ]
then 
    mv /usr/share/jira/bin/setenv.sh /usr/share/jira/bin/setenv.sh.orig
    cp "$TOMCAT_OVERLAY/bin/setenv.sh" /usr/share/jira/bin/
elif [ -r /usr/share/jira/bin/setenv.sh.orig ]
then
    rm /usr/share/jira/bin/setenv.sh
    mv /usr/share/jira/bin/setenv.sh.orig /usr/share/jira/bin/setenv.sh
fi

if [ -d "$TOMCAT_OVERLAY/lib" ]
then
    find "$TOMCAT_OVERLAY/lib" -type f -exec cp {} /usr/share/jira/lib \;
fi

chown -R jira:jira $DATADIR /usr/share/jira

exec su jira -c "/usr/share/jira/bin/start-jira.sh -fg"


