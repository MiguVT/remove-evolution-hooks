#!/system/bin/sh

# install.sh - Ejecuta acciones inmediatamente durante la instalación
# Esto permite funcionamiento sin reboot

MODDIR="$MODPATH"

ui_print "- Executing hook removal immediately..."

# Ejecutar inmediatamente las acciones de post-fs-data
if [ -f "$MODDIR/post-fs-data.sh" ]; then
    ui_print "- Removing problematic Evolution X properties..."
    
    # Ejecutar el script inmediatamente
    sh "$MODDIR/post-fs-data.sh"
    
    # Verificar resultado
    if ! getprop persist.sys.gphooks.enable >/dev/null 2>&1; then
        ui_print "✅ persist.sys.gphooks.enable removed"
    fi
    
    if ! getprop persist.sys.pphooks.enable >/dev/null 2>&1; then
        ui_print "✅ persist.sys.pphooks.enable removed"
    fi
    
    ui_print "- Properties removed successfully!"
    ui_print "- Module will also run on each boot"
else
    ui_print "❌ post-fs-data.sh not found"
fi
