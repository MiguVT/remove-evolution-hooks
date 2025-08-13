#!/system/bin/sh

# Early boot script - runs before system services start
MODDIR=${0%/*}
LOGFILE="$MODDIR/service.log"

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S'): $1" >> "$LOGFILE"
}

# Create log file if it doesn't exist
mkdir -p "$(dirname "$LOGFILE")"
touch "$LOGFILE"

log_message "Post-FS-Data script started"

# Early property removal (one-time, minimal battery impact)
resetprop --delete persist.sys.gphooks.enable >/dev/null 2>&1
resetprop --delete persist.sys.pphooks.enable >/dev/null 2>&1
resetprop --delete sys.init.perf_lsm_hooks >/dev/null 2>&1
resetprop --delete persist.syspphooks.enable >/dev/null 2>&1

log_message "Post-FS-Data script completed"
