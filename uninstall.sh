#!/system/bin/sh

# Enhanced uninstall script with proper cleanup
MODDIR=${0%/*}
PIDFILE="$MODDIR/watcher.pid"
LOGFILE="$MODDIR/service.log"
STATUSFILE="$MODDIR/status"

ui_print "- Stopping property watcher..."

# Kill the property watcher if running
if [ -f "$PIDFILE" ]; then
    old_pid=$(cat "$PIDFILE")
    if kill -0 "$old_pid" 2>/dev/null; then
        kill "$old_pid"
        ui_print "- Property watcher stopped (PID: $old_pid)"
    else
        ui_print "- Property watcher was not running"
    fi
    rm -f "$PIDFILE"
fi

# Note: MODDIR itself will be removed by Magisk/KernelSU

ui_print "- Module files cleaned up"
ui_print "- Remove Evolution X Hooks uninstalled successfully"
ui_print "- Reboot required to complete removal"
