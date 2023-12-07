FROM ubuntu:22.04
# install required packages
RUN apt-get update && sudo apt-get upgrade -y
RUN apt-get install hdparm samba avahi-daemon -y
# prepare the storage

# mount backups partition

# optional: putting hard drive to sleep

# make pi storage network accessible

# create backup user

# configure samba

# configure avahi (and make it pretty)
