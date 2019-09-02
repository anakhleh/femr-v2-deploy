#!/bin/bash
#Make sure mysql is up
# while !</dev/tcp/db/3306;
# do sleep 1;
# done;

#actually run the app

echo "ABOUT TO RUN FEMR"
/femr/target/universal/femr-"$FEMR_APP_VERSION"/bin/femr \
"-Dconfig.file=/femr/target/universal/femr-$FEMR_APP_VERSION/prod.conf" \
"-Dlogger.file=/femr/target/universal/femr-$FEMR_APP_VERSION/conf/prod-logger.xml" \
"-Duser.home=/femr/target/universal/femr-$FEMR_APP_VERSION" \
"-Dplay.http.secret.key=$FEMR_APP_SECRET_KEY"

exit 0