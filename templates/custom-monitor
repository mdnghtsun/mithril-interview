var/log/custom-monitor/*.log {
    rotate 7
    daily
    compress
    missingok
    notifempty
    postrotate
        /etc/systemd/system/custom-monitor.service restart > /dev/null 2>/dev/null || true
    endscript
}
