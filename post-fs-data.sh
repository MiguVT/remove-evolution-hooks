#!/system/bin/sh

# Remove Evolution X Hook Properties
# Executed during post-fs-data phase for early removal

MODDIR=${0%/*}
LOGFILE="/data/adb/modules/remove-evolution-hooks/removal.log"

# Function to log messages
log_message() {
    echo "$(date): $1" >> "$LOGFILE"
}

# Start logging
log_message "=== Remove Evolution X Hooks Started ==="

# Remove problematic properties
log_message "Removing persist.sys.gphooks.enable..."
resetprop --delete persist.sys.gphooks.enable
if [ $? -eq 0 ]; then
    log_message "✅ persist.sys.gphooks.enable removed successfully"
else
    log_message "❌ Failed to remove persist.sys.gphooks.enable"
fi

log_message "Removing persist.sys.pphooks.enable..."
resetprop --delete persist.sys.pphooks.enable
if [ $? -eq 0 ]; then
    log_message "✅ persist.sys.pphooks.enable removed successfully"
else
    log_message "❌ Failed to remove persist.sys.pphooks.enable"
fi

log_message "Removing sys.init.perf_lsm_hooks..."
resetprop --delete sys.init.perf_lsm_hooks
if [ $? -eq 0 ]; then
    log_message "✅ sys.init.perf_lsm_hooks removed successfully"
else
    log_message "❌ Failed to remove sys.init.perf_lsm_hooks"
fi

# Remove additional Evolution X traces (optional)
log_message "Removing additional Evolution X properties..."
resetprop --delete persist.syspphooks.enable
resetprop --delete ro.evolution.build_type

# Clean up property cache files
log_message "Cleaning property cache..."
rm -f /data/property/persist.sys.*hooks* 2>/dev/null
rm -f /data/property/persist.*hooks* 2>/dev/null

log_message "=== Remove Evolution X Hooks Completed ==="
log_message ""
