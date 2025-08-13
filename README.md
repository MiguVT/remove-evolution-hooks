# Remove Evolution X Hooks

A Magisk module that continuously monitors and removes problematic Evolution X properties that cause root detection issues.

## 🔋 Power Efficiency Features

- **Adaptive Monitoring**: Starts with 60-second intervals, extends up to 5 minutes when idle
- **Intelligent Scaling**: Automatically adjusts check frequency based on activity
- **Efficient Sleep**: Uses system-friendly sleep that allows device to enter idle states
- **Early Boot Cleanup**: Removes properties early in boot process to minimize monitoring needs

## 🚀 Key Features

- **Continuous Monitoring**: Background watcher that automatically removes properties if they reappear
- **Properties Removed**:
  - `persist.sys.gphooks.enable`
  - `persist.sys.pphooks.enable`
  - `sys.init.perf_lsm_hooks`
  - `persist.syspphooks.enable`
- **Comprehensive Logging**: Detailed logs with timestamps and status tracking
- **Automatic Builds**: GitHub Actions workflow for automated releases
- **Auto-Update**: Built-in update checking through Magisk Manager

## 📱 Installation

1. Download the latest build from [Releases](../../releases)
2. Flash the ZIP file through Magisk Manager, KernelSU or any fork of them
3. Reboot your device

## 🔄 Auto-Update

The module supports automatic update checking through Magisk and KernelSU Manager, supporting a big range of forks, for update will be like this:

- Your root manager will periodically check for updates
- When a new version is available, you'll see an update notification
- Simply tap "Update" to download and install the latest version

> This process can change depending on your root manager, but the core functionality remains the same and it will be easy to follow.

**Update URL**: `https://raw.githubusercontent.com/MiguVT/remove-evolution-hooks/main/update.json`

## 🔧 How It Works

### Boot Process

1. **Post-FS-Data**: Early removal of properties before system services start
2. **Service**: Continuous monitoring starts after full boot

### Power Efficiency Logic

- **Active Mode**: 60-second intervals when properties are being removed
- **Idle Detection**: After 5 consecutive clean checks, extends interval by 30 seconds
- **Maximum Interval**: Caps at 5 minutes to balance battery life and effectiveness
- **Reset Logic**: Returns to 60-second intervals when activity is detected

## 📊 Monitoring

Check the status and logs:

```bash
# View current status
cat /data/adb/modules/remove_evolution_hooks/status

# Check logs
cat /data/adb/modules/remove_evolution_hooks/service.log

# View running watcher process
cat /data/adb/modules/remove_evolution_hooks/watcher.pid
```

## 🔄 Automated Builds

Every push to main triggers an automatic build with:

- Incremented build numbers
- Automated ZIP creation
- GitHub release with detailed changelog
- Build artifacts for download

## 🛠️ Development

The module consists of:

- `module.prop` - Module metadata
- `post-fs-data.sh` - Early boot cleanup
- `service.sh` - Continuous monitoring with adaptive intervals
- `uninstall.sh` - Cleanup script
- `.github/workflows/build-release.yml` - Automated build pipeline

## 📋 Requirements

- Android 7.0+ (API 24+)
- Magisk v20.4+
- Root access

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚠️ Disclaimer

This module is designed specifically for Evolution X ROM to resolve root detection issues. Use at your own risk. Always create a backup before flashing any modules.

---

_Battery life is precious. This module respects that._ 🔋
