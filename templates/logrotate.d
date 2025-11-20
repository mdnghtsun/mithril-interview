/var/log/linuxserver/linux.log {
        rotate 7
        daily
        compress
        delaycompress
        missingok
        notifempty
        create 660 linuxuser linuxuser }