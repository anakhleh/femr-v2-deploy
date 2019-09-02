#/bin/bash
#created the env file for docker to work off of. 
#its easier to get env vars here than inside a docker containers

#Get rid of any existing env or intermediary steps
rm -rf env
rm -rf femr_version_env_vars.tmp

#create env vile
cp env.base env

#generate what needs to be generated
python generate_env_vars.py

#get femr app and env related env vars
bash add_femr_version_env_vars.sh
cat femr_version_env_vars.tmp >> env

#for env var use in docker compose, some env vars need to be in .env
cp env .env

#cleanup
rm -rf femr_version_env_vars.tmp
