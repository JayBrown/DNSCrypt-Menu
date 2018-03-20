![bbdnsc-platform-macos](https://img.shields.io/badge/platform-macOS-lightgrey.svg)
![bbdnsc-code-shell](https://img.shields.io/badge/code-shell-yellow.svg)
[![bbdnsc-prereq-dnsc](https://img.shields.io/badge/prerequisite-dnscrypt-proxy%20v2-brightgreen.svg)](https://github.com/jedisct1/dnscrypt-proxy)
[![bbdnsc-prereq-bitbar](https://img.shields.io/badge/prerequisite-BitBar%202.0%20beta10-brightgreen.svg)](https://github.com/matryer/bitbar)
[![bbdnsc-license](http://img.shields.io/badge/license-MIT+-blue.svg)](https://github.com/JayBrown/DNSCrypt-Menu/blob/master/LICENSE)

# DNSCrypt Menu <img src="https://github.com/JayBrown/DNSCrypt-Menu/blob/master/img/jb-img.png" height="20px"/>

**DNSCrypt Menu is a [BitBar](https://github.com/matryer/bitbar) plugin to manage the [DNSCrypt](https://github.com/jedisct1/dnscrypt-proxy) proxy from the macOS menu bar.**

**DNSCrypt Menu** also works as a tool to configure your default DNS setup.

## Functionality
* start & stop the DNSCrypt service
* switch between settings (_see below_; exception: **Other DNS**)
* configure fallback DNS resolvers for dnscrypt
* configure default DNS resolvers for non-DNSCrypt usage
  * _Note_: at initial run the user's original DNS resolvers are saved to `$HOME/.config/dnscrypt/backup-*` followed by the service name, e.g. `backup-Wi-Fi`
* display DNS information: services, devices, resolvers, IP, hostname, ping
* display configured resolvers and local DNS
* display DNSCrypt servers as specified in the .toml configuration file
* display CryptDNS information: owner, PID, version, executable path, config path

![screengrab](https://github.com/JayBrown/DNSCrypt-Menu/blob/master/img/screengrab.png)

## Installation
* install `dnscrypt-proxy` version 2, e.g. with **[Homebrew](https://brew.sh)**: `brew install dnscrypt-proxy`
  * configure `dnscrypt-proxy` by editing the `.toml` configuration file
* download the latest version of **BitBar**, currently at **[v2.0.0 beta 10](https://github.com/matryer/bitbar/releases/tag/v2.0.0-beta10)**
  * install and configure BitBar
  * quit BitBar
* clone the **DNSCrypt Menu** GitHub repository and symlink `DNSCryptMenu.30s.sh` to your BitBar plugins folder
* launch BitBar

## Settings
* **DNSCrypt**
* **DNSCrypt + Fallback** — DNSCrypt using fallback DNS, with Quad9 (9.9.9.9) as initial preset
* **Default DNS** — DNS without DNSCrypt (no initial resolvers)
* **Other DNS** — auto-setting for other DNS setups, e.g. when using a VPN

## Todo
* Testing, lots of testing

## Thank you
Thank you to **[Frank Denis](https://github.com/jedisct1/bitbar-dnscrypt-proxy-switcher)** for kicking this off with his original plugin.
