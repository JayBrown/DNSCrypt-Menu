![bbdnsc-platform-macos](https://img.shields.io/badge/platform-macOS-lightgrey.svg)
![bbdnsc-code-shell](https://img.shields.io/badge/code-shell-yellow.svg)
[![bbdnsc-prereq-dnsc](https://img.shields.io/badge/prerequisite-dnscrypt--proxy%202.x-green.svg)](https://github.com/jedisct1/dnscrypt-proxy)
[![bbdnsc-prereq-bbar](https://img.shields.io/badge/prerequisite-BitBar%202.0%20beta10-brightgreen.svg)](https://github.com/matryer/bitbar)
[![bbdnsc-license](http://img.shields.io/badge/license-MIT+-blue.svg)](https://github.com/JayBrown/DNSCrypt-Menu/blob/master/LICENSE)

# DNSCrypt Menu <img src="https://github.com/JayBrown/DNSCrypt-Menu/blob/master/img/jb-img.png" height="20px"/>

**DNSCrypt Menu is a [BitBar](https://github.com/matryer/bitbar) plugin to manage the [DNSCrypt](https://github.com/jedisct1/dnscrypt-proxy) proxy from the macOS menu bar.**

**DNSCrypt Menu** also works as a tool to configure your default DNS setup.

## Functionality
* start & stop the DNSCrypt service
* switch between settings (_see below_; exception: **Other DNS**)
* configure additional resolvers for **DNSCrypt + Fallback** setting
* configure resolvers for the **Default DNS** setting
  * _Note_: at initial run the user's original DNS resolvers, as specified in the **Network** preference pane, are saved to `$HOME/.config/dnscrypt/backup-*`, followed by the service name, e.g. `backup-Wi-Fi`
* display DNS information: services, devices, resolvers, IP, hostname, ping
* display configured resolvers and DNS on the LAN
* display DNSCrypt servers as specified in the .toml configuration file
* display CryptDNS executable and service information: owner, PID, version, executable path, config path

![screengrab](https://github.com/JayBrown/DNSCrypt-Menu/blob/master/img/screengrab.png)

## Installation
* install `dnscrypt-proxy` version 2, e.g. with **[Homebrew](https://brew.sh)**: `brew install dnscrypt-proxy`
  * configure `dnscrypt-proxy` by editing the `.toml` configuration file
* download the latest version of **BitBar**, currently at **[v2.0.0 beta 10](https://github.com/matryer/bitbar/releases/tag/v2.0.0-beta10)**
  * install and configure BitBar
  * quit BitBar
* clone the **DNSCrypt Menu** GitHub repository and symlink `DNSCryptMenu.30s.sh` to your BitBar plugins folder
* launch BitBar
* install **[terminal-notifier](https://github.com/julienXX/terminal-notifier)** (optional, recommended)

## Settings
* **DNSCrypt**
* **DNSCrypt + Fallback** — DNSCrypt using fallback DNS, with Quad9 (9.9.9.9) as initial preset
* **Default DNS** — DNS without DNSCrypt (no initial resolvers)
* **Other DNS** — auto-setting for other DNS setups, e.g. when using a VPN

## Notes
The file `local.lcars.DNSCryptLoopback.plist` is a LaunchDaemon for demonstration purposes. If you use a different proxy address than the default `127.0.0.1`, you need to map your alternate address for DNSCrypt to work. This particular daemon runs the command `/sbin/ifconfig lo0 alias 127.0.0.54`. Edit to your needs and install with:

* `cp local.lcars.DNSCryptLoopback.plist /Library/LaunchDaemons/local.lcars.DNSCryptLoopback.plist`
* `chmod 0644 /Library/LaunchDaemons/local.lcars.DNSCryptLoopback.plist`
* `launchctl load /Library/LaunchDaemons/local.lcars DNSCryptLoopback.plist`
* Verify with: `netstat -nr | netstat -nr | grep "^127\.0\.0\..*lo0$"`

## Todo
* Testing, lots of testing
* TOML parsing (blocklists, IPv6, log files etc.)
* DNSCrypt icon for notifications using terminal-notifier
* tweaking, e.g. `brew service restart` as fallback at service start fail
* start/stop functionality

## Thank you
Thank you to **[Frank Denis](https://github.com/jedisct1/bitbar-dnscrypt-proxy-switcher)** for kicking this off with his original plugin.
