#!/bin/bash
set -e

MYSQL_SOCKET=/var/run/mysqld/mysqld.sock
MYSQL_INIT="/var/lib/mysql/.initialized"

if [ ! -f "$MYSQL_INIT" ]; then

  mysqld --user=mysql --skip-networking --socket=$MYSQL_SOCKET &
  child_pid="$!"

  for i in {0..30}; do
    if mysqladmin ping --silent --socket=$MYSQL_SOCKET; then
      break
    fi
    sleep 1
  done

  /usr/local/bin/scripts/init.sh
  /usr/local/bin/scripts/secure.sh

  touch "$MYSQL_INIT"

  mysqladmin shutdown -uroot --socket="$MYSQL_SOCKET"
  wait "$child_pid"
else
  echo "$(date '+%F %k:%M:%S') $$ [INFO] Data base is already initialized"
fi

exec "$@"
