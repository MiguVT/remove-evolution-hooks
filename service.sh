#!/system/bin/sh

# Backup script that runs after system boot
# Additional cleanup in case properties reappear

LOGFILE="/data/adb/modules/remove-evolution-hooks/service.log"

# Wait for system to fully boot
sleep 10

# Log service start
echo "$(date): Service script started" >> "$LOGFILE"

# Double-check and remove properties again
resetprop --delete persist.sys.gphooks.enable
resetprop --delete persist.sys.pphooks.enable  
resetprop --delete sys.init.perf_lsm_hooks
resetprop --delete persist.syspphooks.enable

echo "$(date): Service script completed" >> "$LOGFILE"
