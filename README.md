# femr-v2-deploy
Dockerization and OS Images for faster and easier deployment of Femr v2.x.x

#Dependencies to run 
Docker (should come with `docker-compose` cli tool), Python 3+ (I ran it on 3.7.2, but I think it will run at least on 3.2+), bash (or at least some way to run bash scripts and curl from bash).
Note: this is meant to be run on Ubuntu Server 18.04 LTS

#Usage
`bash set_up_docker_env_file.sh`
`bash build_local_docker_containers.sh`
`bash run_femr_from_saved_local_containers.sh`

Still needs some testing regarding docker ARGS/ENV and volumes. Still needs a script that clones this
repo, downloads docker (with docker-compose) and python3.7, sets up the computer to run `run_femr_from_saved_local_containers.sh` on boot, and to not put the system to sleep when the lid is closed. From there, i guess you could make an image of that. Don't make an image where the containers are built and part of the image, there is some randomly generated default user stuff that should not be kept common among femr systems.

#Notes
The femr docker image, when built, clones the current master of femr. It is dependent on 
the strings `val appVersion` and `val currentScalaVersion` being in file `femr/Build.sbt`
and `sbt.version=` being in file `femr/project/build.properties`. ALso, building the femr image takes forever.

##On MySQL
100MB push limit means I couldn't include the docker image tar in the repo, but `build_local_docker_containers.sh` now downloads the tar from a google drive link. that curl isnt tested, but it was simple enough i assumed it would work.

#What I'm unsure about
- How docker volumes work so that we know logs and db data is persisted across container/image deletion and boot/shutdown of system
- Do Docker ARGS or ENV need to be present only when building the image, or also for running it?

#QoL Improvements
- Maybe do more print statements in the bash scripts so we can look at the console output and know how far in we are.