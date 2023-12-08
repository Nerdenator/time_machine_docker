FROM dperson/samba
# install required packages
RUN apt-get update && apt-get upgrade -y
RUN apt-get install hdparm avahi-daemon -y
# prepare the storage

# mount backups partition
RUN mkdir /mnt/backups
RUN echo 'LABEL=backups /mnt/backups ext4 noexec,nodev,noatime,nodiratime 0 0' | sudo tee - a /etc/fstab
RUN mount /mnt/backups
# optional: putting hard drive to sleep

# create backup user
RUN adduser --disabled-password --gecos "" keeper
# create subdir for Samba sharing:
RUN mkdir /mnt/backups/backups
# set ownership of backups to keeper, made above
RUN chown -R keeper: /mnt/backups
# configure samba
RUN echo -e '\n[backups]\n\tcomment = Backups\n\tpath = /mnt/backups/backups\n\tvalid users = keeper\n\treadonly = no\n\tvfs objects = catia fruit streams_xattr\n\tfruit:time machine = yes' | tee -a /etc/samba/smb.conf
# add keeper to Samba's password file
RUN smbpasswd -a keeper
# should find some way to check if things worked using a config check... maybe later.
# reload Samba service
RUN service smbd reload
# configure avahi (and make it pretty)
EXPOSE 445
