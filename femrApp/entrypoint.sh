#!/bin/bash
#Make sure mysql is up
# while !</dev/tcp/db/3306;
# do sleep 1;
# done;

#actually run the app
FILE=/femr/target/universal/femr-$FEMR_APP_VERSION/RUNNING_PID

if [ -f $FILE ]
	then
		rm $FILE
fi

echo "ABOUT TO RUN FEMR: TRY 2";

/femr/target/universal/femr-"$FEMR_APP_VERSION"/bin/femr \
"-Dconfig.file=/femr/target/universal/femr-$FEMR_APP_VERSION/conf/prod.conf" \
"-Dlogger.file=/femr/target/universal/femr-$FEMR_APP_VERSION/conf/prod-logger.xml" \
"-Duser.home=/femr/target/universal/femr-$FEMR_APP_VERSION" 

exit 0