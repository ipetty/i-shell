#!/bin/sh
#
#
set -e

service iptables stop
chkconfig iptables off
yum install wget ntp zip unzip -y
chkconfig ntpd on
service ntpd start

./i-jdk.sh
./i-ant.sh
./i-maven.sh
./i-androidsdk.sh
./i-mysql.sh
./i-tomcat.sh
./get_api_code.sh
./get_client_code.sh
./get_server_code.sh
./pub_server.sh
./pub_server_unlock.sh