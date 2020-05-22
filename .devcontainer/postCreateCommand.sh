#!/bin/sh
sudo chown vscode -R $(pwd)

./configure --enable-debug
make
sudo make install
sudo mkdir $PGDATA
sudo chown -R postgres:postgres $PGDATA
/usr/local/pgsql/bin/initdb
cd
/usr/local/pgsql/bin/pg_ctl -l logfile start
/usr/local/pgsql/bin/createdb test

sudo chown -R postgres:postgres $WS

echo "Appending github.ibm.com to ~/.ssh/known_hosts"
mkdir ~/.ssh && /usr/bin/ssh-keyscan -H github.com >> ~/.ssh/known_hosts
