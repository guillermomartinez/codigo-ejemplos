#!/bin/bash
# * * * * * /bin/bash /home/user/reset-centos6.sh > /dev/null 2>&1
TOTAL_MEMORY=$(free | grep "Mem:" | awk '{print $2}')
FREE_MEMORY=$(free | grep "Mem:" | awk '{print $4}')
current=$(echo "scale=0;100-$FREE_MEMORY * 100 / $TOTAL_MEMORY" | bc -l)
LIMITE=98
LOG=/home/user/low-memory-fixer.log
APACHE_STATUS=$(/etc/init.d/httpd status | awk '{print $3}')
if [ "$current" -gt "$LIMITE" ] || [ "$APACHE_STATUS" ==  "ejecutando" ]
then
echo -e "$(date) - BEGIN Recarga de Apache - Memoria free es $FREE_MEMORY, memoria utilizada $current %." >> $LOG
# /etc/init.d/httpd stop
# /etc/init.d/httpd start
/etc/init.d/httpd restart
/etc/init.d/mysqld restart
echo -e "$(date) - END Estado de Apache es $APACHE_STATUS." >> $LOG
else
echo -e "$(date) - La memoria es todavía bueno. Memoria free es $FREE_MEMORY, memoria utilizada $current %." >> $LOG
fi
