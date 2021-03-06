#!/bin/sh
#
# 
# chenyongkang@kedacom

echo "=================config centos system================"
FILE=./ip_apnic
rm -f $FILE
wget http://ftp.apnic.net/apnic/stats/apnic/delegated-apnic-latest -O $FILE
grep 'apnic|CN|ipv4|' $FILE | cut -f 4,5 -d'|'|sed -e 's/|/ /g' | while read ip cnt
do
echo $ip:$cnt
        mask=$(cat << EOF | bc | tail -1
pow=32;
define log2(x) {
if (x<=1) return (pow);
pow--;
return(log2(x/2));
}
log2($cnt)
EOF)
       echo $ip/$mask>> cn.net
if whois $ip@whois.apnic.net | grep -i ".*chinanet.*\|.*telecom.*">/dev/null;then
echo $ip/$mask >> chinanet
elif whois $ip@whois.apnic.net | grep -i ".*unicom.*">/dev/null;then
echo $ip/$mask >> unicom
else
echo $ip/$mask >> others
fi
done

echo "==========================ok=========================" 