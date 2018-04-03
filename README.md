![bbdnsc-platform-macos](https://img.shields.io/badge/platform-macOS-lightgrey.svg)
![bbdnsc-code-shell](https://img.shields.io/badge/code-shell-yellow.svg)
[![bbdnsc-prereq-dnsc](https://img.shields.io/badge/prerequisite-dnscrypt--proxy%202.x-green.svg)](https://github.com/jedisct1/dnscrypt-proxy)
[![bbdnsc-prereq-bbar](https://img.shields.io/badge/prerequisite-BitBar%202.0%20beta10-brightgreen.svg)](https://github.com/matryer/bitbar)
[![bbdnsc-license](http://img.shields.io/badge/license-MIT+-blue.svg)](https://github.com/JayBrown/DNSCrypt-Menu/blob/master/LICENSE)

# DNSCrypt Menu <img src="https://github.com/JayBrown/DNSCrypt-Menu/blob/master/img/jb-img.png" height="20px"/>

**DNSCrypt Menu is a [BitBar](https://github.com/matryer/bitbar) plugin to manage the [DNSCrypt](https://github.com/jedisct1/dnscrypt-proxy) proxy from the macOS menu bar.**

**DNSCrypt Menu** also works as a tool to configure your default DNS setup.

## Functionality
* start, stop or force-restart the DNSCrypt service with support for Homebrew installations
* switch between settings (_see below_; exception: **Other DNS** via VPN)
* configure additional resolvers for **DNSCrypt + Fallback** setting
* configure resolvers for the **Default DNS** setting
  * _Note_: at initial run the user's original DNS resolvers, as specified in the **Network** preference pane, are saved to `$HOME/.config/dnscrypt/backup-*`, followed by the service name and `-initial`, e.g. `backup-Wi-Fi-initial`; backed-up resolvers can be reloaded at any time.
* display DNS information: service, devices (incl. TUN/TAP), current resolvers (`/etc/resolv.conf`), configured resolvers (Network preferences), internal fallback resolver (DNSCrypt), configured fallback resolvers (DNSCrypt Menu), public DNS IP with hostname, Whois & ping, local area DNS
* display DNSCrypt executable and service information: owner, PID, version, network status, used resolvers, ignored resolvers, executable path, config path, latest log & output, full log, log settings
* backup and reload resolvers from **Other DNS** setups (excluding VPN tunnels)
* options to clear DNS cache or renew DHCP lease
* links to robtex (IP & hostname), current resolver source, this repository, the dnscrypt-proxy repository, and a list of available public DNSCrypt server

![screengrab](https://github.com/JayBrown/DNSCrypt-Menu/blob/master/img/screengrab.png)

## Installation
* install `dnscrypt-proxy` version 2, e.g. with **[Homebrew](https://brew.sh)** (recommended): `brew install dnscrypt-proxy`
  * configure `dnscrypt-proxy` by editing the `.toml` configuration file
* download the latest version of **BitBar**, currently at **[v2.0.0 beta 10](https://github.com/matryer/bitbar/releases/tag/v2.0.0-beta10)**
  * install and configure BitBar
  * quit BitBar
* clone the **DNSCrypt Menu** GitHub repository and symlink `DNSCryptMenu.30s.sh` to your BitBar plugins folder
  * refresh clone for updates
* install **[terminal-notifier](https://github.com/julienXX/terminal-notifier)** (optional, recommended)
* launch BitBar

## Settings
* **DNSCrypt** — basic DNSCrypt setting without fallback DNS except the one specified in the TOML configuration file
* **DNSCrypt + Fallback** — DNSCrypt using additional fallback DNS, with Quad9 (9.9.9.9) as initial preset
* **Default DNS** — DNS without DNSCrypt and without initial resolvers, i.e. macOS will use the LAN DNS
* **Other DNS**
  * fixed auto-setting when using a VPN
  * user-defined settings based on manual configuration in the Network preference pane (excluding VPN scenarios)

## Notes
* The file `local.lcars.DNSCryptLoopback.plist` is a LaunchDaemon for demonstration purposes. If you use a different proxy address than the default `127.0.0.1`, you need to map your alternate address at every system boot for DNSCrypt to work. This particular daemon runs the command `ifconfig lo0 alias 127.0.0.54`. Edit to your needs and install/enable using the following commands:

  * `cp local.lcars.DNSCryptLoopback.plist /Library/LaunchDaemons/local.lcars.DNSCryptLoopback.plist`
  * `chmod 0644 /Library/LaunchDaemons/local.lcars.DNSCryptLoopback.plist`
  * `launchctl load /Library/LaunchDaemons/local.lcars DNSCryptLoopback.plist`
  * Verify with: `netstat -nr | grep "^127\.0\.0\..*lo0$"`

* Stop and restart the plugin from external scripts with:
  * stop: `mv $HOME/.config/dnscrypt/run $HOME/.config/dnscrypt/stop`
  * restart: `mv $HOME/.config/dnscrypt/stop $HOME/.config/dnscrypt/run`

* This BitBar plugin has only been tested on El Capitan (OS X 10.11.6); IPv6 network setups have _not_ been tested; please report any issues or create a **pull request**.

## Todo
* Tweaking & testing, lots of testing
* script comments
* TOML parsing (blocklists, IPv6 etc.)?

## Thank you
Thank you to **[Frank Denis](https://github.com/jedisct1/bitbar-dnscrypt-proxy-switcher)** for kicking this off with his original plugin.
