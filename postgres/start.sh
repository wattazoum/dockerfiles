#!/bin/bash

DATADIR="/var/lib/postgresql/9.2/main"
CONF="/etc/postgresql/9.2/main/postgresql.conf"
POSTGRES="/usr/local/pgsql/bin/postgres"
INITDB="/usr/local/pgsql/bin/initdb"

# test if DATADIR is existent
if [ ! -d $DATADIR ]; then
  echo "Creating Postgres data at $DATADIR"
  mkdir -p $DATADIR
fi

# test if DATADIR has content
if [ ! "$(ls -A $DATADIR)" ]; then
  echo "Initializing Postgres Database at $DATADIR"
  chown -R postgres $DATADIR
  su postgres sh -c "$INITDB $DATADIR"
  su postgres sh -c "$POSTGRES --single -D $DATADIR -c config_file=$CONF" <<< "CREATE USER $USERNAME WITH SUPERUSER PASSWORD '$PASSWORD';"
fi

trap "echo \"Sending SIGTERM to postgres\"; killall -s SIGTERM postgres" SIGTERM

su postgres sh -c "$POSTGRES -D $DATADIR -c config_file=$CONF" &

wait $!
