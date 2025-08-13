#!/system/bin/sh

# Service script with intelligent property monitoring
MODDIR=${0%/*}
LOGFILE="$MODDIR/service.log"
PIDFILE="$MODDIR/watcher.pid"
STATUSFILE="$MODDIR/status"

# Properties to monitor
PROPS_TO_DELETE=(
    "persist.sys.gphooks.enable"
    "persist.sys.pphooks.enable"
    "sys.init.perf_lsm_hooks"
    "persist.syspphooks.enable"
)

log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S'): $1" >> "$LOGFILE"
}

delete_properties() {
    local deleted_count=0
    for prop in "${PROPS_TO_DELETE[@]}"; do
        if resetprop "$prop" >/dev/null 2>&1; then
            resetprop --delete "$prop"
            log_message "Deleted property: $prop"
            deleted_count=$((deleted_count + 1))
        fi
    done
    return $deleted_count
}

# Adaptive watcher with power-efficient intervals
property_watcher() {
    log_message "Property watcher started (PID: $$)"
    echo $$ > "$PIDFILE"

    local check_interval=60  # Start with 60 seconds
    local max_interval=300   # Max 5 minutes
    local no_activity_count=0

    while true; do
        delete_properties
        deleted_count=$?

        if [ $deleted_count -gt 0 ]; then
            log_message "Removed $deleted_count properties - resetting interval"
            check_interval=60  # Reset to frequent checking
            no_activity_count=0
            echo "active" > "$STATUSFILE"
        else
            no_activity_count=$((no_activity_count + 1))

            # Gradually increase interval if no activity (battery optimization)
            if [ $no_activity_count -gt 5 ] && [ $check_interval -lt $max_interval ]; then
                check_interval=$((check_interval + 30))
                log_message "No activity detected, extending interval to ${check_interval}s"
                echo "idle" > "$STATUSFILE"
            fi
        fi

        # Use efficient sleep that allows system to idle
        sleep $check_interval
    done
}

# Wait for system to fully boot
sleep 15

# Create necessary directories
mkdir -p "$(dirname "$LOGFILE")"

log_message "Service script started"

# Initial cleanup
delete_properties
initial_deleted=$?
log_message "Initial cleanup: removed $initial_deleted properties"

# Kill existing watcher if running
if [ -f "$PIDFILE" ]; then
    old_pid=$(cat "$PIDFILE")
    if kill -0 "$old_pid" 2>/dev/null; then
        kill "$old_pid"
        log_message "Killed existing watcher (PID: $old_pid)"
    fi
    rm -f "$PIDFILE"
fi

# Start background property watcher with battery optimization
property_watcher &

log_message "Service setup completed"
