#!/bin/bash
#I actually can't test this at the moment, but this is speculative and what I think
#something close to the final script would be, so yeah.

#RUN THIS AS SUDO

#You'd clone this repo into theh home directore of the ubuntu user, and
#run this from the home directory of the ubuntu user (~/femr), probably.
#and probably as sudo, just cause we are editing settings in /etc/systemdlogind.conf

apt-get update
apt-get -y install docker git curl

#build the docker containers
bash build_local_docker_containers.sh

#set the computer such that it does not go to sleep when the lid is closed
sed -i "/#HandleLidSwitch=.*/c\HandleLidSwitch=ignore/" /etc/systemd/logind.conf

#Edit rc.local so that femr starts on boot. note that ${SUDO_USER:-${USER}} will be the
#name of the user who sudo-ed to run this file. I dont think the quotes are needed around
#bash, but I did it to be on the safe side. Note that in ubuntu 18.04 lts, that rc.local
#does not exist by default. The newline after the shebang is needed in the echo so separate.
#the lines in the file.
echo '#!/bin/bash
' \
'bash' \
/home/${SUDO_USER:-${USER}}/femr-v2-deploy/run_femr_from_saved_local_containers.sh \
> /etc/rc.local

#set permissions
chmod 644 /etc/rc.local

#enable rc.local
systemctl enable rc-local
systemctl start rc-local

#reboot the system. If everything else was good, then this 
#will cause femr to boot.
reboot -f