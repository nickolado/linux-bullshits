#!/bin/bash

# Corrigir o fuso horário
timedatectl set-timezone America/Bahia

# Criar pasta tivic na raiz
cd /
mkdir tivic
sleep 2

# Atualizar os rep
apt update
sleep 5
apt upgrade
sleep 5

# Instalação do Java

apt install default-jre
sleep 5 
apt install openjdk-8-jre-headless
sleep 5 
apt install default-jdk
sleep 5

# Instalação do Tomcat

wget https://archive.apache.org/dist/tomcat/tomcat-8/v8.5.87/bin/apache-tomcat-8.5.87.tar.gz
sleep 5
mkdir /opt/tomcat
sleep 5
tar -xvzf apache-tomcat-8.5.87.tar.gz -C /opt/tomcat --strip-components=1
sleep 5
chown -R $USER:$USER /opt/tomcat
sleep 2
chmod +x /opt/tomcat/bin/*.sh
sleep 2
cd /opt/tomcat/bin
./startup.sh
sleep 2

# Instalação do PostgreSQL 14

apt install postgresql-14

# Aplicar configuração no Postgres

sed -i "s/^local\s*all\s*postgres\s*peer/local   all   postgres   trust/" /etc/postgresql/14/main/pg_hba.conf
sleep 2
echo "host    all             all             192.168.1.0/24          md5" >> /etc/postgresql/14/main/pg_hba.conf
echo "password_encryption = md5" >> /etc/postgresql/14/main/postgresql.conf
echo "listen_addresses = '*'" >> /etc/postgresql/14/main/postgresql.conf