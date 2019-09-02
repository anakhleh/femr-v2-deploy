rm -rf femr_version_env_vars.tmp
git clone https://github.com/FEMR/femr

FEMR_APP_VERSION=$( \
    grep 'val appVersion' femr/Build.sbt \
    | awk 'NF>1{print $NF}' \
    | sed 's/\"//g' \
)
FEMR_APP_SBT_VERSION=$(
    grep 'sbt.version' femr/project/build.properties \
    | awk -F= '{print $NF}'
)
FEMR_APP_SCALA_VERSION=$( \
    grep 'val currentScalaVersion' femr/Build.sbt \
    | awk 'NF>1{print $NF}' \
    | sed 's/\"//g' \
)

echo \
"SBT_VERSION=$FEMR_APP_SBT_VERSION
FEMR_APP_VERSION=$FEMR_APP_VERSION
FEMR_APP_SCALA_VERSION=$FEMR_APP_SCALA_VERSION"

echo \
"FEMR_APP_VERSION=$FEMR_APP_VERSION
FEMR_APP_SBT_VERSION=$FEMR_APP_SBT_VERSION
FEMR_APP_SCALA_VERSION=$FEMR_APP_SCALA_VERSION" \
>> femr_version_env_vars.tmp

rm -rf femr