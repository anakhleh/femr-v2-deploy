#Make sure mysql is up
while !</dev/tcp/db/3306;
do sleep 1;
done;

echo "$FEMR_APP_VERSION\n\n\n"

#actually run the app
iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to 8081

FILE=/home/kevin/fEMR/femr-2.2/RUNNING_PID

if [ -f $FILE ]
	then
		rm $FILE
fi

/opt/femr/femr-2.4.0/bin/femr -Dconfig.file=/opt/femr/femr-2.4.0/prod.conf -Dlogger.file=/opt/femr/femr-2.4.0/conf/prod-logger.xml -Duser.home=/home/femr &

exit 0