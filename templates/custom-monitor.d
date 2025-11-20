var/log/custom-monitor/*.log {
    rotate 7
    daily
    compress
    missingok
    notifempty
    postrotate
    /sbin/service custom-monitor.service reload > /dev/null 2>/dev/null || true
    endscript
}
    

var/log/linuxserver/linux.log {
        rotate 7
        daily
        compress
        delaycompress
        missingok
        notifempty
        create 660 linuxuser linuxuser }