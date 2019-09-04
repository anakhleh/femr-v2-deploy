#!/bin/bash
#Make sure mysql is up

# pwd | echo;
# echo "ABOUT TO RUN FEMR: TRY 2";
# ls /femr | echo;
# ls /femr/target | echo;
# ls /femr/target/universal | echo;
# ls "/femr/target/universal/$FEMR_APP_VERSION" | echo;
# ls "/femr/target/universal/$FEMR_APP_VERSION/bin" | echo;
echo "RUNNING FEMR"
/femr/target/universal/femr-$FEMR_APP_VERSION/bin/femr \
"-Dconfig.file=/femr/target/universal/femr-$FEMR_APP_VERSION/conf/prod.conf" \
"-Dlogger.file=/femr/target/universal/femr-$FEMR_APP_VERSION/conf/prod-logger.xml" \
"-Duser.home=/femr/target/universal/femr-$FEMR_APP_VERSION" 

exit 0