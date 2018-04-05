#!/bin/bash

# <bitbar.title>DNSCrypt Menu</bitbar.title>
# <bitbar.version>1.0.28</bitbar.version>
# <bitbar.author>Joss Brown</bitbar.author>
# <bitbar.author.github>JayBrown</bitbar.author.github>
# <bitbar.desc>Manage DNSCrypt from the macOS menu bar</bitbar.desc>
# <bitbar.image>https://raw.githubusercontent.com/JayBrown/DNSCrypt-Menu/master/img/screengrab.png</bitbar.image>
# <bitbar.url>https://github.com/JayBrown/DNSCrypt-Menu</bitbar.url>

# DNSCrypt Menu
# version 1.0.28
# Copyright (c) 2018 Joss Brown (pseud.)
# License: MIT+
# derived from: dnscrypt-proxy-switcher by Frank Denis (jedisct1) https://github.com/jedisct1/bitbar-dnscrypt-proxy-switcher

dcmver="1.0.28"
dcmvadd=""

export LANG=en_US.UTF-8
export HISTIGNORE='*sudo -S*'
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/sw/bin:/sw/sbin:$HOME/bin:$HOME/sbin

osversion=$(sw_vers -productVersion)
osmajor=$(echo "$osversion" | awk -F. '{print $2}')
[ $osmajor -lt 7 ] && exit 1

theme="classic"
if test -t 0 ; then
	theme="emoji"
fi

if [[ $theme == "classic" ]] ; then
	ERROR_ICON="| dropdown=false templateImage=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c2VkIDE1IDAgUiBdCmVuZG9iagozIDAgb2JqCjw8IC9UeXBlIC9QYWdlcyAvTWVkaWFCb3ggWzAgMCAxNiAxNl0gL0NvdW50IDEgL0tpZHMgWyAyIDAgUiBdID4+CmVuZG9iagoxNyAwIG9iago8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMyAwIFIgL1ZlcnNpb24gLzEuNCA+PgplbmRvYmoKMTggMCBvYmoKKE1hYyBPUyBYIDEwLjkuNSBRdWFydHogUERGQ29udGV4dCkKZW5kb2JqCjE5IDAgb2JqCihEOjIwMTYwMzAzMTkwNDI3WjAwJzAwJykKZW5kb2JqCjEgMCBvYmoKPDwgL1Byb2R1Y2VyIDE4IDAgUiAvQ3JlYXRpb25EYXRlIDE5IDAgUiAvTW9kRGF0ZSAxOSAwIFIgPj4KZW5kb2JqCnhyZWYKMCAyMAowMDAwMDAwMDAwIDY1NTM1IGYgCjAwMDAwMDU2NTkgMDAwMDAgbiAKMDAwMDAwMDUwNSAwMDAwMCBuIAowMDAwMDA1NDIwIDAwMDAwIG4gCjAwMDAwMDAwMjIgMDAwMDAgbiAKMDAwMDAwMDQ4NiAwMDAwMCBuIAowMDAwMDAwNjA3IDAwMDAwIG4gCjAwMDAwMDA3MzEgMDAwMDAgbiAKMDAwMDAwMTMwMyAwMDAwMCBuIAowMDAwMDAxMzIyIDAwMDAwIG4gCjAwMDAwMDUzODMgMDAwMDAgbiAKMDAwMDAwMTM5MSAwMDAwMCBuIAowMDAwMDAyNjEwIDAwMDAwIG4gCjAwMDAwMDE0MzkgMDAwMDAgbiAKMDAwMDAwMjU4OSAwMDAwMCBuIAowMDAwMDAyNjQ3IDAwMDAwIG4gCjAwMDAwMDUzNjIgMDAwMDAgbiAKMDAwMDAwNTUwMSAwMDAwMCBuIAowMDAwMDA1NTY1IDAwMDAwIG4gCjAwMDAwMDU2MTcgMDAwMDAgbiAKdHJhaWxlcgo8PCAvU2l6ZSAyMCAvUm9vdCAxNyAwIFIgL0luZm8gMSAwIFIgL0lEIFsgPDY3NGRkZmQ4MGY5ZTc3Yzg4ZDhjNjZhMTJhYTk4NTk0Pgo8Njc0ZGRmZDgwZjllNzdjODhkOGM2NmExMmFhOTg1OTQ+IF0gPj4Kc3RhcnR4cmVmCjU3MzQKJSVFT0YK"
elif [[ $theme == "emoji" ]] ; then
	ERROR_ICON="✖"︎
fi

cfgdir="$HOME/.config/dnscrypt"
if ! [[ -d "$cfgdir" ]] ; then
	mkdir -p "$cfgdir"
	touch "$cfgdir/run"
fi

if [[ $1 == "toggle" ]] ; then
	if [[ $2 == "stop" ]] ; then
		mv "$cfgdir/run" "$cfgdir/stop"
	elif [[ $2 == "start" ]] ; then
		mv "$cfgdir/stop" "$cfgdir/run"
	fi
	exit 0
fi

if [[ -e "$cfgdir/stop" ]] ; then
	echo "$ERROR_ICON"
	echo "---"
	echo "Plugin Stopped"
	echo "---"
	echo "Restart… | refresh=true terminal=false bash=$0 param1=toggle param2=start"
	exit 0
else
	stopped=false
fi

interface=$(route get 0.0.0.0 2>/dev/null | awk '/interface: / {print $2}')
if ! [[ $interface ]] ; then
	echo "$ERROR_ICON"
	echo "---"
	echo "No Connection Available | color=red"
	echo "---"
	echo "Refresh… | refresh=true"
	exit 0
fi

dcpver=$(dnscrypt-proxy --version 2>/dev/null)
if ! [[ $dcpver ]] ; then
	echo "$ERROR_ICON"
	echo "---"
	echo "dnscrypt-proxy is not in your \$PATH | color=red"
	echo "Please make sure to install DNSCrypt correctly"
	echo "---"
	echo "Refresh… | refresh=true"
	exit 0
fi
dcploc=$(which dnscrypt-proxy 2>/dev/null)

read -d '' ltoml <<"EOF"
/usr/local/etc/dnscrypt-proxy.toml
/opt/local/etc/dnscrypt-proxy.toml
/sw/etc/dnscrypt-proxy.toml
$HOME/etc/dnscrypt-proxy.toml
/private/etc/dnscrypt-proxy.toml
EOF

while read -r TOML
do
	[[ -f $TOML ]] && break
done < <(echo "$ltoml")
if ! [[ $TOML ]] ; then
	echo "$ERROR_ICON"
	echo "---"
	echo "dnscrypt-proxy.toml not available | color=red"
	echo "Please make sure to install DNSCrypt correctly"
	echo "---"
	echo "Refresh… | refresh=true"
	exit 0
fi
etcdir=$(dirname "$TOML")

process="DNSCrypt Menu"
account=$(id -un)

_beep () {
	osascript -e "beep"
}

_notify () {
	if [[ $tn_status == "osa" ]] ; then
			osascript &>/dev/null << EOT
tell application "System Events"
	display notification "$2" with title "$process [" & "$account" & "]" subtitle "$1"
end tell
EOT
	elif [[ $tn_status == "tn-app-new" ]] || [[ $tn_status == "tn-app-old" ]] ; then
		"$tn_loc/Contents/MacOS/terminal-notifier" \
			-title "$process [$account]" \
			-subtitle "$1" \
			-message "$2" \
			-appIcon "$icon_loc" \
			>/dev/null
	elif [[ $tn_status == "tn-cli" ]] ; then
		"$tn" \
			-title "$process [$account]" \
			-subtitle "$1" \
			-message "$2" \
			-appIcon "$icon_loc" \
			>/dev/null
	fi
}

tn=$(which terminal-notifier 2>/dev/null)
if [[ $tn == "" ]] || [[ $tn == *"not found" ]] ; then
	tn_loc=$(mdfind "kMDItemCFBundleIdentifier == 'fr.julienxx.oss.terminal-notifier'" 2>/dev/null | awk 'NR==1')
	if [[ $tn_loc == "" ]] ; then
		tn_loc=$(mdfind "kMDItemCFBundleIdentifier == 'nl.superalloy.oss.terminal-notifier'" 2>/dev/null | awk 'NR==1')
		if ! [[ $tn_loc ]] ; then
			tn_status="osa"
		else
			tn_status="tn-app-old"
		fi
	else
		tn_status="tn-app-new"
	fi
else
	tn_vers=$("$tn" -help | head -1 | awk -F'[()]' '{print $2}' | awk -F. '{print $1"."$2}')
	if (( $(echo "$tn_vers >= 1.8" | bc -l) )) && (( $(echo "$tn_vers < 2.0" | bc -l) )) ; then
		tn_status="tn-cli"
	else
		tn_loc=$(mdfind "kMDItemCFBundleIdentifier == 'fr.julienxx.oss.terminal-notifier'" 2>/dev/null | awk 'NR==1')
		if ! [[ $tn_loc ]] ; then
			tn_loc=$(mdfind "kMDItemCFBundleIdentifier == 'nl.superalloy.oss.terminal-notifier'" 2>/dev/null | awk 'NR==1')
			if ! [[ $tn_loc ]] ; then
				tn_status="osa"
			else
				tn_status="tn-app-old"
			fi
		else
			tn_status="tn-app-new"
		fi
	fi
fi

service=$(networksetup -listnetworkserviceorder | grep -B1 "Device: $interface)$" | head -1 | awk -F")" '{print substr($0, index($0,$2))}' | xargs)

_flush () {
	if [[ $osmajor -le 8 ]] ; then
		killall -HUP mDNSResponder 2>/dev/null
	elif [[ $osmajor == 9 ]] ; then
		dscacheutil -flushcache 2>/dev/null
		killall -HUP mDNSResponder 2>/dev/null
	elif [[ $osmajor == 10 ]] ; then
		osminor=$(echo "$osversion" | awk -F. '{print $3}')
		if [[ $osminor -le 3 ]] ; then
			discoveryutil mdnsflushcache 2>/dev/null
			discoveryutil udnsflushcaches 2>/dev/null
		else
			dscacheutil -flushcache 2>/dev/null
			killall -HUP mDNSResponder 2>/dev/null
		fi
	elif [[ $osmajor == 11 ]] ; then
		dscacheutil -flushcache 2>/dev/null
		killall -HUP mDNSResponder 2>/dev/null
	elif [[ $osmajor == 12 ]] ; then
		osminor=$(echo "$osversion" | awk -F. '{print $3}')
		if [[ $osminor -le 2 ]] ; then
			killall -HUP mDNSResponder 2>/dev/null
		else
			killall -HUP mDNSResponder 2>/dev/null
			killall mDNSResponderHelper 2>/dev/null
			dscacheutil -flushcache 2>/dev/null
		fi
	else
		killall -HUP mDNSResponder 2>/dev/null
	fi
}

_rootpw () {
	if [[ $1 == "dhcp" ]] ; then
		osascript 2>/dev/null << EOT
tell application "System Events"
	activate
	set theLogoPath to ((path to home folder from user domain) as text) & ".cache:dnscrypt:icon.png"
	set thePW to text returned of (display dialog "Please enter your administrator password to renew the DHCP lease for the $service service on interface $interface." & ¬
		return & return & ¬
		"Please note that this operation can reset your system's resolvers configuration file, and you might need to reboot your Mac to restore your network settings to the desired state." ¬
		default answer "" ¬
		with hidden answer ¬
		buttons {"Cancel", "Renew"} ¬
		default button 2 ¬
		with title "DNSCrypt: DHCP Lease" ¬
		with icon file theLogoPath ¬
		giving up after 180)
	end tell
thePW
EOT
	elif [[ $1 == "service" ]] ; then
		osascript 2>/dev/null << EOT
tell application "System Events"
	activate
	set theLogoPath to ((path to home folder from user domain) as text) & ".cache:dnscrypt:icon.png"
	set thePW to text returned of (display dialog "Please enter your administrator password to $2 the DNSCrypt Service." & ¬
		return & return & ¬
		"Please wait for the process to finish. You will need to enter your password again to change the macOS Network configuration." ¬
		default answer "" ¬
		with hidden answer ¬
		buttons {"Cancel", "$3"} ¬
		default button 2 ¬
		with title "DNSCrypt: Service" ¬
		with icon file theLogoPath ¬
		giving up after 180)
	end tell
thePW
EOT
	fi
}

CONFIG=$(cat "$TOML" | sed -e 's/^[ \t]*//' | grep -v -e "^$" -e "##" -e "^# *#$")

DNSCRYPT_PROXY_ALL=$(echo "$CONFIG" | awk -F"'" '/^listen_addresses =/{print $2}')
DNSCRYPT_PROXY_IPS=$(echo "$DNSCRYPT_PROXY_ALL" | awk -F: '{print $1}')
! [[ $DNSCRYPT_PROXY_IPS ]] && DNSCRYPT_PROXY_IPS="127.0.0.1"
dnsport=$(echo "$DNSCRYPT_PROXY_ALL" | awk -F: '{print $2}')
! [[ $dnsport ]] && dnsport="53"

nstat_all=$(netstat -nr 2>/dev/null)

if [[ $DNSCRYPT_PROXY_IPS != "127.0.0.1" ]] ; then
	int1=$(echo "$DNSCRYPT_PROXY_IPS" | awk -F. '{print $1}')
	int2=$(echo "$DNSCRYPT_PROXY_IPS" | awk -F. '{print $2}')
	int3=$(echo "$DNSCRYPT_PROXY_IPS" | awk -F. '{print $3}')
	int4=$(echo "$DNSCRYPT_PROXY_IPS" | awk -F. '{print $4}')
	chnstat=$(echo "$nstat_all" | grep "^$int1\.$int2\.$int3\.$int4.*lo0")
	if ! [[ $chnstat ]] ; then
		echo "$ERROR_ICON"
		echo "---"
		echo "$DNSCRYPT_PROXY_IPS is not in your routing table | color=red"
		echo "Please make sure to install DNSCrypt correctly"
		echo "---"
		echo "You should either"
		echo "● edit and load the provided LaunchDaemon, or"
		echo "● manually run the following command:"
		echo "sudo ifconfig lo0 alias $DNSCRYPT_PROXY_IPS | font=Menlo size=12"
		echo "---"
		echo "Refresh… | refresh=true"
		exit 0
	fi
	nstat_listen=$(netstat -an 2>/dev/null | grep "$int1\.$int2\.$int3\.$int4\.$dnsport")
else
	chnstat=$(echo "$nstat_all" | grep "^127\.0\.0\.1.*lo0")
	nstat_listen=$(netstat -an 2>/dev/null | grep "127\.0\.0\.1\.$dnsport")
fi

localdns=$(ipconfig getoption $interface domain_name_server 2>/dev/null)

fbloc="$cfgdir/cdefault"
dfloc="$cfgdir/pdefault"
udfloc="$cfgdir/udefault"
dfb="# FALLBACK SERVER LIST FOR DNSCRYPT\n# Please enter the DNS IP address in column 1.\n# You may add a description in column 2.\n# Columns must be separated by a whitespace character.\n\n9.9.9.9 Quad9"
udf="# DNS LIST FOR DEFAULT DNS WITHOUT DNSCRYPT\n# Please enter the DNS IP address in column 1.\n# You may add a description in column 2.\n# Columns must be separated by a whitespace character.\n\nempty empty"

! [[ -f "$fbloc" ]] && echo -e "$dfb" > "$fbloc"
! [[ -f "$udfloc" ]] && echo -e "$udf" > "$udfloc"
! [[ -f "$dfloc" ]] && echo "${DNSCRYPT_PROXY_IPS}" > "$dfloc"

cachedir="$HOME/.cache/dnscrypt"
currloc="$cachedir/current"
if ! [[ -d "$cachedir" ]] ; then
	mkdir -p "$cachedir"
	echo "0.0.0.0 placeholder" > "$currloc"
else
	! [[ -f "$currloc" ]] && echo "0.0.0.0 placeholder" > "$currloc"
fi

dcpicon="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
ScpZuUVBKSgOSQkgVJTi3DIcDQQzAGBehV8WV/plJTqzMkcunpIt183PkLtPGSGP
XjhUnrtqsLx28wB5457+8u4TfeTD53rJJ690ly+vK5FDZ06WQ6vRGUCyWsECKGdY
WE6z0sDwtVVT5eDS0fL1ZMCYBBiTAWOSElkDfYE+n4AmAscESqrxgMG4b7wScKA9
SgT0bsZdWmQLxp123MG4Q438zHaC3gggGLdNVErT2joJMNAmINgIEOsA4ZMpZI0p
qbJmapq8h96eliZvotvPHyynXjVIlmGL+aeNkFmL0mXCtCypqgpIGfYrYfIoYuLI
Z8wtDUm4NCjBEuDA3jnA4kPZhYBREJbM/LCk45v0SEQywhFJ16AwKlBy8iwoavLL
lzRK5nQmwzQPKGnRHqXQTKLRbGIXcrqbikRXJi4kHW0MEovtu3R7kKxxEfniJGeQ
M97JdAJOudOfXNLJuZ8+WlVDscm/fkiOUVrF4BC6fgEQtS7wOyq7S50ezixn2MC+
GRdGd8A7mY0fvQHUza5zqzXvXqac0lmjn/3gA71Zw4KRqsCwM0yWMWRajjUuRk5n
VspQRsf4mWq2whk5hcpBpHqcFcFpRRNzZNTiDJlydqrMw+HLb+8nZz3aWy7+c3e5
5p+d5NaP28v929vI47vayjO72shLu9vKP/e0kbf2tpV397aTDz5rKx/ubydrD7SV
dV+0lc/vD8mhsyZZAclZUwDGSsFyhoFFZRmt06bId0sq5L8E11dTlQBjCmBMJWNM
NjqA9msBB9pHAO9l3MOotJtA3k1g7+LxLh7v5PEOHu+IjoDBYy2+v43gN0rT2goA
m9FGYFgPBOumpspaIPgIfTA9Vd6bkSrvzEiTt9Dr6N8z0+TeZ7rJ1Tvayk/RFTva
yaXb28ol6KJtbeTcT1Pk1Lc7yUl/7SYL/tBLZv+6r0z6+WAZddFwKV2ZLrkzfJJT
EZRsYMnCF5kWlAwNSkT7LC2M/8j66fgyzWaUtGx8zSSYpiZDNSmqGBjuzSYFNpt4
IOltIelhIMm2kKjY8wHJ8E6BjU5v50qnr3MWcMylLS8jf6Q51SBzNeWVahM26lhu
Xgcg8ZDU23ckwqG0CwL/RR9yD0nsDGcAaSsno3PBmmi/0aU41m944MhUH9CWVBne
kspmDdXIpdN8p2VaOJQBMaQ2KGCkq5lIpW9msMjcbCkFgDHXDpap9/WTuX/sIUv+
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
PVoyLOHl+kRjLg+uNMjSuwT9ZZ5IiFieJWhApiW/Wj59yUkx2p+vBFHLMPXOYk8Y
Wo7Riz5Ng7QkowaLWSaPP36byFfOxx0Wyk5aiTtWaYkTkFNtO3ewTB6weVLCpPum
zp3+dGx1/CtJranvpm/KPJ69M/f8zEcK/zz/6Vn/WPhc6a9LXi7771nfLzO/CEpe
mRtUvTzm678/N6h6+cuqTziKXpjz24Jvlvxb7mNFf5N9X95HGVuzTyd3pHXHuhPe
jlwY9dKUrOufHDdp3P3o/3vkTLAd0HvCJpkEXXJ51CpfomuDiSCWScvkALmAP2mi
pblYLuXwcp1ermk1omYIWjaphLBmCVo6jTf+wJJitD9f0RgnoYpTVk/khKGGqSUZ
NVjNMiJpEvnlijqHOkksz4q1xLlFTrXL+C986MMAkTw+OQo1ype3djn7rOFAiYBt
Hjdh3LZJsZPuv7542uMzFkc/H+NIeD2hMeWd5NUZR9O35Axm3J17PvuBgp/mfr3o
L2c+MevvC745+1/zv13668IXyn5b9PLc/wFmkJc0fcm2DxS/PC+oXH5pblDHdL62
LxzFmhbLexVr9Qk+88V5/1X4nbLf5D9T+qu8J0v+aeajxb/Ifqjwk6x7899P2zpz
JGVtZl9iS+qhOE/iT6KWx746dc6M71ybOuWxcZMn3CeNv0OO/vROsEXOABt4cBKz
QIdMgCY5gPnl8rlGfqK0XL4vLOS/hxCJUMLLJFpNiHeHNFsyiNnBgEcM+ndROGpw
MkQYIiHCzRJ/sElxpT9XThjRYGo4dcBkcJ0hOmUqmAGiQCxIAMkgDWSCmQb9RItB
P/llzAZlBv2MpIEEon/IbxhLwQqDfjWFgSQyDCfwGPRvmA2jHjSCZtAKOsAqg37P
i4E1sIHgG5iVDBjBgCEMjIiGcce4ceO2R0yL2Dk55bqvXV8w7cmpZTO+Ne2W6Ocj
l8S9FFWe8Gp0deIbsd7kt+LqUt5JaErbn9iWcSRpVeax5K6s3uQ12SdS1mb1pazP
6U9dnz2YsjFnKGVTznDq5pmn0rbkjqRtzR1B+TRtY/9Qyoack8nrswdS1uX0J63J
6ktenXmc7pPUkdmd2JJ+KD6Qug/P2h3jTPpxdHnC6zOWxb4yfWH0izfOi3ruhqLp
35qScf0TEdGTHhoXMe5e1H0HuAvcCbaDbbJNm2Ubqa3rZdvXgNWyT9pAC2gCAVAL
fMANHKAKrATLwGJwK1gA5oE5YBYoBLkgG6SDFJAI4kAMiASUCDeC6w0rGSYZ4ZPh
jz4hrvbnK8aVk0ZPHOok6izqND1xphuiY6MNK3mSQKohgpBliATKM0SAKFClhkii
+YYI4kJwG1hiiABToCmZKOg1hkgoMoLXEElVZ4jEajCs5CLzUIK1gXZDmKrTEMlG
JuuSkOnWStZprB8j+jXqPmskXfJZqySdsh7tsl6tsq5Nsu4B2RZqE5mdBg2XIQxP
A0klKAfLDTHILDKE8W82xAA01xDmLwFFoMCwEiDDEAMYDWR6EkTJmFHs9ESYLGMc
bmb4k0mIsfy5UtKESxzqUHvyUKdT59sTiAJEgVJJRCMYBZGCSYmUY4gA02xEyUQz
EgWfEoqMQIagEZHMQYlFM5RKrkWGSDAyEiUZmYpmLUo2MhklXKWEEq9aUmPDcQX0
89T1VZJK+Yxy+cwVsg7LZJ2obotlXW+VdVdGny/bVibbSm2mgUSZngYXGmTI+DRj
08CTaljmjzfE4BQt+5pmezUT3CBjopLAvjwaSyL8ySbD5/kzWuJcKXnsCUQB0pOI
gqcnEgXWnkwUfEooMoJKqlRDJBYZhZKLTEMJRgaiJCMzUaKRsSjZyGSUcEWSYsks
jRIbsyX2/SW269S9iuQzCuQz8+Xzc2V9cmT9smSd02UbUmWbkmX7lOGp7cr0UbJf
qI+mGdbof4MROgOo5dA1xtiSIFwi/EEmw/8CAAD//wMAaoKUNkxPr+QAAAAASUVO
RK5CYII="
if ! [[ -f "$cachedir/icon.png" ]] ; then
	echo "$dcpicon" > "$cachedir/icon.base64"
	base64 -D -i "$cachedir/icon.base64" -o "$cachedir/icon.png" && rm -f "$cachedir/icon.base64" 2>/dev/null
fi
[[ -f "$cachedir/icon.base64" ]] && rm -f "$cachedir/icon.base64" 2>/dev/null
icon_loc="$cachedir/icon.png"

if [[ $1 == "dnscopy" ]] ; then
	if [[ $2 == "ip" ]] ; then
		copynote="IP address"
	elif [[ $2 == "hostname" ]] ; then
		copynote="hostname"
	fi
	echo -n "$3" | pbcopy
	_notify "Copied DNS $copynote to clipboard" "$3"
    exit 0
fi

if [[ $1 == "network" ]] ; then
	if [[ $2 == "flush" ]] ; then
		_flush
	elif [[ $2 == "dhcp" ]] ; then
		rootpw=$(_rootpw dhcp)
		if [[ $rootpw ]] ; then
			echo "$rootpw" | sudo -S 2>/dev/null ipconfig set $interface DHCP || { _beep ; _notify "⚠️ Error!" "Renew DHCP Lease" ; }
			sudo -k && rootpw="" && sleep 1
		fi
	fi
	exit 0
fi

fallbacks=$(cat "$fbloc" | grep -v -e "^#" -e "^$" | awk '!seen[$0]++' | grep -v "$localdns")
fbips=$(echo "$fallbacks" | awk '{print $1}')
fbipss=$(echo "$fbips" | sort)
ADDITIONAL_IP=$(echo "$fbips" | xargs)
ADDITIONAL_IPS=$(echo "$fbipss" | xargs)

_service_resolvers () {
	fservice="$1"
	getdnsservers=$(networksetup -getdnsservers "$fservice" | awk '!seen[$0]++')
	if [[ $(echo "$getdnsservers" | grep "^There") != "" ]] ; then
		echo "None"
	else
		ips=""
		while read -r ip
		do
			[[ $ips ]] && ips="$ips "
			ips="$ips$ip"
		done < <(echo "$getdnsservers")
		echo "$ips" | sed 's/^ //'
	fi
}

baklocname=$(echo "backup-$service" | sed -e 's/:/-/g' -e 's,/,-,g' -e 's/ /_/g')
bakloc="$cfgdir/$baklocname"
ibakloc="$bakloc-initial"
if ! [[ -f "$ibakloc" ]] ; then
	if [[ -f "$bakloc" ]] ; then
		obak=$(cat "$bakloc" | grep -v "^#")
		pdate=$(date +%s)
		echo -e "# $pdate\n$obak" > "$ibakloc" && rm -f "$bakloc" 2>/dev/null
	else
		iresolvers=$(_service_resolvers "$service")
		pdate=$(date +%s)
		echo "# $pdate" > "$ibakloc"
		if [[ $iresolvers != "None" ]] ; then
			echo ${iresolvers} >> "$ibakloc" && _notify "✅ Initial backup successful!" "${iresolvers}"
		fi
	fi
fi

if [[ $1 == "cbackup" ]] ; then
	bresolvers=$(_service_resolvers "$service")
	if [[ $bresolvers == "None" ]] ; then
		_beep
		_notify "⚠️ Backup error!" "No resolvers detected"
	else
		pdate=$(date +%s)
		echo ${bresolvers} > "$bakloc-d$pdate" && _notify "✅ Backup successful!" "${bresolvers}"
	fi
	exit 0
fi

if [[ $1 == "rload" ]] ; then
	if [[ $2 == "initial" ]] ; then
		lresolvers=$(cat "$ibakloc" | grep -v "^#")
	else
		lresolvers=$(cat "$bakloc-d$2")
	fi
	if [[ $lresolvers ]] ; then
		networksetup -setdnsservers "$service" ${lresolvers} 2>/dev/null && _flush 2>/dev/null
	else
		_beep
		_notify "⚠️ Error!" "No resolvers detected"
	fi
	exit 0
fi

defaultdns=$(cat "$udfloc" | grep -v -e "^#" -e "^$" -e "^empty empty$" | awk '!seen[$0]++' | grep -v "$localdns")
if ! [[ $defaultdns ]] ; then
	UDEFAULT="empty"
	UDEFAULTS=""
else
	udfips=$(echo "$defaultdns" | awk '{print $1}')
	udfipss=$(echo "$udfips" | sort)
	UDEFAULT=$(echo "$udfips" | xargs)
	UDEFAULTS=$(echo "$udfipss" | xargs)
fi

[[ $localdns ]] && UDEFAULT="${UDEFAULT} $localdns"

proxystatus=$(pgrep -U 0 "dnscrypt-proxy")
! [[ $proxystatus ]] && proxy=false || proxy=true

service_resolvers=$(_service_resolvers "$service")

SCRNAME=$(basename $0)

_setdefault () {
	networksetup -setdnsservers "$service" ${UDEFAULT} 2>/dev/null && _flush 2>/dev/null
}

nstat=$(echo "$nstat_all" | awk '/^0\/1/ {print $6}')
if [[ $(echo "$nstat" | grep 'tun\|tap') == "" ]] ; then
	vpn=false
else
	vpn=true
fi

if [[ $service_resolvers == "None" ]] && [[ $UDEFAULTS ]] && ! $vpn ; then
	_beep
	_notify "Detected Network DNS Reset!" "Resetting to Default DNS…"
	_setdefault && /usr/bin/open "bitbar://refreshPlugin?name=$SCRNAME"
	exit 0
fi

dnsip=$(dig whoami.akamai.net +short 2>/dev/null)
if [[ $(echo "$dnsip" | wc -l | xargs) -gt 1 ]] ; then
	echo "$ERROR_ICON"
	echo "---"
	echo "No Connection Available | color=red"
	echo "---"
	echo "Refresh… | refresh=true"
	exit 0
fi

if [[ $1 == "default" ]] ; then
	if [[ $2 == "dcp" ]] ; then
		echo "${DNSCRYPT_PROXY_IPS}" > "$dfloc"
	elif [[ $2 == "dcpfb" ]] ; then
		echo "${DNSCRYPT_PROXY_IPS} ${ADDITIONAL_IP}" > "$dfloc"
	fi
	exit 0
fi

currentdns=$(cat "$currloc")
currentdnsip=$(echo "$currentdns" | awk '{print $1}')
currentdnsname=$(echo "$currentdns" | awk '{print substr($0, index($0,$2))}')

DEFAULT=$(cat "$dfloc")

_abspath () {
	python - "$1" << 'EOF'
import os.path
import sys
for arg in sys.argv[1:]:
    print os.path.realpath(os.path.abspath(arg))
EOF
}

if [[ $1 == "proxyservice" ]] ; then
	if [[ $2 == "start" ]] ; then
		mprompt="Start"
		servopt="start"
	elif [[ $2 == "stop" ]] ; then
		mprompt="Stop"
		servopt="stop"
	elif [[ $2 == "force-restart" ]] ; then
		mprompt="Restart"
		servopt="restart"
	fi
	rootpw=$(_rootpw service $2 $mprompt)
	if [[ $rootpw != "" ]] ; then
		dcptloc=$(_abspath "$dcploc")
		brewed=false
		[[ $(echo "$dcptloc" | grep "/Cellar/") != "" ]] && brewed=true
		brewstatus=$(brew help 2>/dev/null)
		if [[ $brewstatus ]] && $brewed ; then
			echo "$rootpw" | sudo -S 2>/dev/null brew services $servopt dnscrypt-proxy > "$cachedir/service" 2>&1 \
					&& sleep 1
			if [[ $2 == "stop" ]] ; then
				sudo -k && rootpw=""
				networksetup -setdnsservers "$service" ${UDEFAULT} 2>/dev/null \
					&& _flush 2>/dev/null \
					&& /usr/bin/open "bitbar://refreshPlugin?name=$SCRNAME"
			else
				proxystatus=$(pgrep -U 0 "dnscrypt-proxy")
				if [[ $proxystatus ]] ; then
					sudo -k && rootpw=""
					networksetup -setdnsservers "$service" ${DEFAULT} 2>/dev/null \
						&& _flush 2>/dev/null \
						&& /usr/bin/open "bitbar://refreshPlugin?name=$SCRNAME"
				else
					if [[ $servopt == "start" ]] ; then
						echo "$rootpw" | sudo -S 2>/dev/null brew services restart dnscrypt-proxy >> "$cachedir/service" 2>&1 \
							&& sudo -k && rootpw="" && sleep 1
						proxystatus=$(pgrep -U 0 "dnscrypt-proxy")
						if [[ $proxystatus ]] ; then
							networksetup -setdnsservers "$service" ${DEFAULT} 2>/dev/null \
								&& _flush 2>/dev/null \
								&& /usr/bin/open "bitbar://refreshPlugin?name=$SCRNAME"
						else
							_beep
							_notify "DNSCrypt Service Error!" "Resetting to Default DNS…"
							_setdefault && /usr/bin/open "bitbar://refreshPlugin?name=$SCRNAME"
						fi
					else
						_beep
						_notify "DNSCrypt Service Error!" "Resetting to Default DNS…"
						_setdefault && /usr/bin/open "bitbar://refreshPlugin?name=$SCRNAME"
					fi
				fi
			fi
		else
			if [[ $dcpver ]] ; then
				echo "$rootpw" | sudo -S 2>/dev/null dnscrypt-proxy -service stop > "$cachedir/service" 2>&1 \
					&& sleep 1
				if [[ $2 == "stop" ]] ; then
					sudo -k && rootpw=""
					networksetup -setdnsservers "$service" ${UDEFAULT} 2>/dev/null \
						&& _flush 2>/dev/null \
						&& /usr/bin/open "bitbar://refreshPlugin?name=$SCRNAME"
				else
					proxystatus=$(pgrep -U 0 "dnscrypt-proxy")
					if [[ $proxystatus ]] ; then
						sudo -k && rootpw=""
						networksetup -setdnsservers "$service" ${DEFAULT} 2>/dev/null \
							&& _flush 2>/dev/null \
							&& /usr/bin/open "bitbar://refreshPlugin?name=$SCRNAME"
					else
						if [[ $servopt == "start" ]] ; then
							echo "$rootpw" | sudo -S 2>/dev/null dnscrypt-proxy -service restart >> "$cachedir/service" 2>&1 \
								&& sudo -k && rootpw="" && sleep 1
							proxystatus=$(pgrep -U 0 "dnscrypt-proxy")
							if [[ $proxystatus ]] ; then
								networksetup -setdnsservers "$service" ${DEFAULT} 2>/dev/null \
									&& _flush 2>/dev/null \
									&& /usr/bin/open "bitbar://refreshPlugin?name=$SCRNAME"
							else
								_beep
								_notify "DNSCrypt Service Error!" "Resetting to Default DNS…"
								_setdefault && /usr/bin/open "bitbar://refreshPlugin?name=$SCRNAME"
							fi
						else
							_beep
							_notify "DNSCrypt Service Error!" "Resetting to Default DNS…"
							_setdefault && /usr/bin/open "bitbar://refreshPlugin?name=$SCRNAME"
						fi
					fi
				fi
			fi
		fi
	fi
	exit 0
fi

if ! $proxy && [[ $(echo "$service_resolvers" | grep "$DNSCRYPT_PROXY_IPS") != "" ]] ; then
	_beep
	_notify "DNSCrypt Service Error!" "Resetting to Default DNS…"
	_setdefault && /usr/bin/open "bitbar://refreshPlugin?name=$SCRNAME"
	exit 0
fi

tomldir=$(dirname "$TOML")

if [[ $1 == "opensource" ]] ; then
	shift
	for resolversource in ${@}
	do
		resloc=$(basename "$resolversource")
		open "$tomldir/$resloc"
	done
	exit 0
fi

if [[ $# -gt 0 ]] ; then
	resopt="$*"
	# shellcheck disable=2086
	networksetup -setdnsservers "$service" $resopt
	_flush 2>/dev/null
	exit 0
fi

if [[ $theme == "classic" ]] ; then
	CONNECTED_ICON="| dropdown=false templateImage=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agoyNjEyCmVuZG9iago3IDAgb2JqClsgL0lDQ0Jhc2VkIDggMCBSIF0KZW5kb2JqCjMgMCBvYmoKPDwgL1R5cGUgL1BhZ2VzIC9NZWRpYUJveCBbMCAwIDE2IDE2XSAvQ291bnQgMSAvS2lkcyBbIDIgMCBSIF0gPj4KZW5kb2JqCjEwIDAgb2JqCjw8IC9UeXBlIC9DYXRhbG9nIC9QYWdlcyAzIDAgUiA+PgplbmRvYmoKMTEgMCBvYmoKKE1hYyBPUyBYIDEwLjkuNSBRdWFydHogUERGQ29udGV4dCkKZW5kb2JqCjEyIDAgb2JqCihEOjIwMTYwMzA0MjExMjA0WjAwJzAwJykKZW5kb2JqCjEgMCBvYmoKPDwgL1Byb2R1Y2VyIDExIDAgUiAvQ3JlYXRpb25EYXRlIDEyIDAgUiAvTW9kRGF0ZSAxMiAwIFIgPj4KZW5kb2JqCnhyZWYKMCAxMwowMDAwMDAwMDAwIDY1NTM1IGYgCjAwMDAwMDM4NzQgMDAwMDAgbiAKMDAwMDAwMDcxMSAwMDAwMCBuIAowMDAwMDAzNjQ5IDAwMDAwIG4gCjAwMDAwMDAwMjIgMDAwMDAgbiAKMDAwMDAwMDY5MiAwMDAwMCBuIAowMDAwMDAwODEzIDAwMDAwIG4gCjAwMDAwMDM2MTQgMDAwMDAgbiAKMDAwMDAwMDg4MSAwMDAwMCBuIAowMDAwMDAzNTk0IDAwMDAwIG4gCjAwMDAwMDM3MzAgMDAwMDAgbiAKMDAwMDAwMzc4MCAwMDAwMCBuIAowMDAwMDAzODMyIDAwMDAwIG4gCnRyYWlsZXIKPDwgL1NpemUgMTMgL1Jvb3QgMTAgMCBSIC9JbmZvIDEgMCBSIC9JRCBbIDw1NGY5OWIwZmViMWMxNzViOGE0NmQ3NTM2MTdlNmFhMD4KPDU0Zjk5YjBmZWIxYzE3NWI4YTQ2ZDc1MzYxN2U2YWEwPiBdID4+CnN0YXJ0eHJlZgozOTQ5CiUlRU9GCg=="
	DISCONNECTED_ICON="| dropdown=false templateImage=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IC9QYWdlcyAvTWVkaWFCb3ggWzAgMCAxNiAxNl0gL0NvdW50IDEgL0tpZHMgWyAyIDAgUiBdID4+CmVuZG9iagoxNyAwIG9iago8PCAvVHlwZSAvQ2F0YWxvZyAvUGFnZXMgMyAwIFIgL1ZlcnNpb24gLzEuNCA+PgplbmRvYmoKMTggMCBvYmoKKE1hYyBPUyBYIDEwLjkuNSBRdWFydHogUERGQ29udGV4dCkKZW5kb2JqCjE5IDAgb2JqCihEOjIwMTYwMzA0MjA1OTAzWjAwJzAwJykKZW5kb2JqCjEgMCBvYmoKPDwgL1Byb2R1Y2VyIDE4IDAgUiAvQ3JlYXRpb25EYXRlIDE5IDAgUiAvTW9kRGF0ZSAxOSAwIFIgPj4KZW5kb2JqCnhyZWYKMCAyMAowMDAwMDAwMDAwIDY1NTM1IGYgCjAwMDAwMDU2MjMgMDAwMDAgbiAKMDAwMDAwMDU1MyAwMDAwMCBuIAowMDAwMDA1Mzg0IDAwMDAwIG4gCjAwMDAwMDAwMjIgMDAwMDAgbiAKMDAwMDAwMDUzNCAwMDAwMCBuIAowMDAwMDAwNjU1IDAwMDAwIG4gCjAwMDAwMDA3NzkgMDAwMDAgbiAKMDAwMDAwMTI2NyAwMDAwMCBuIAowMDAwMDAxMjg2IDAwMDAwIG4gCjAwMDAwMDUzNDcgMDAwMDAgbiAKMDAwMDAwMTM1NSAwMDAwMCBuIAowMDAwMDAyNTc0IDAwMDAwIG4gCjAwMDAwMDE0MDMgMDAwMDAgbiAKMDAwMDAwMjU1MyAwMDAwMCBuIAowMDAwMDAyNjExIDAwMDAwIG4gCjAwMDAwMDUzMjYgMDAwMDAgbiAKMDAwMDAwNTQ2NSAwMDAwMCBuIAowMDAwMDA1NTI5IDAwMDAwIG4gCjAwMDAwMDU1ODEgMDAwMDAgbiAKdHJhaWxlcgo8PCAvU2l6ZSAyMCAvUm9vdCAxNyAwIFIgL0luZm8gMSAwIFIgL0lEIFsgPDZlYTc3ZjkwNzY2OGY2YTkzY2UyNDliYWM1NzMyYWEwPgo8NmVhNzdmOTA3NjY4ZjZhOTNjZTI0OWJhYzU3MzJhYTA+IF0gPj4Kc3RhcnR4cmVmCjU2OTgKJSVFT0YK"
elif [[ $theme == "emoji" ]] ; then
	CONNECTED_ICON='✔️'
	DISCONNECTED_ICON='❕'
fi

_current_resolvers () {
	confrs=$(cat /etc/resolv.conf | awk '/^nameserver /{print $2}' | awk '!seen[$0]++' | sort)
	[[ $confrs == "" ]] && exit 0
	confrs=$(echo "$confrs" | grep -v "$localdns")
	ips=""
	while read -r confr
	do
		[[ $ips ]] && ips="$ips "
		ips="$ips$confr"
	done < <(echo "$confrs")
	echo "$ips"
}

_displayname () {
	resolvers="$1"
	if [[ $resolvers == $DNSCRYPT_PROXY_IPS ]] ; then
		echo "DNSCrypt"
	elif [[ $resolvers == "$DNSCRYPT_PROXY_IPS $ADDITIONAL_IPS" ]] ; then
		echo "DNSCrypt + Fallback"
	elif [[ $resolvers == $UDEFAULTS ]] ; then
		echo "Default DNS"
	else
		echo "Other DNS"
	fi
}

current_resolvers=$(_current_resolvers)
setting=$(_displayname "$current_resolvers")

if $proxy ; then
	if [[ $setting == "DNSCrypt" ]] ; then
		echo "$CONNECTED_ICON"
		dnsc=true
		dnscf=false
		dnsd=false
		dnso=false
	elif [[ $setting == "DNSCrypt + Fallback" ]] ; then
		echo "$CONNECTED_ICON"
		dnsc=false
		dnscf=true
		dnsd=false
		dnso=false
	elif [[ $setting == "Default DNS" ]] ; then
		echo "$DISCONNECTED_ICON"
		dnsc=false
		dnscf=false
		dnsd=true
		dnso=false
	elif [[ $setting == "Other DNS" ]] ; then
		echo "$DISCONNECTED_ICON"
		dnsc=false
		dnscf=false
		dnsd=false
		dnso=true
	fi
else
	echo "$ERROR_ICON"
	dnsc=false
	dnscf=false
	if [[ $setting == "Default DNS" ]] ; then
		dnsd=true
		dnso=false
	else
		dnsd=false
		dnso=true
	fi
fi

echo "---"

if ! [[ $localdns ]] ; then
	localdns="None"
	ldnsname=""
else
	ldnsname=$(ipconfig getpacket $interface 2>/dev/null | awk -F": " '/^domain_name \(string\): /{print $2}')
	[[ "$ldnsname" == "" ]] && ldnsname="Unknown Hostname"
fi

oneshotline=$(echo "$CONFIG" | grep "^fallback_resolver = ")
if [[ $oneshotline ]] ; then
	oneshotres=$(echo "$oneshotline" | awk -F\' '{print $2}')
fi

_dnsinfo () {
	echo "--Service | size=11 color=gray"
	echo "--${service}"
	echo "-----"
	devifcfg=$(ifconfig $interface 2>/dev/null | sed 's/^'"$interface"': //')
	if [[ $nstat ]] ; then
		echo "--Devices | size=11 color=gray"
		echo "--$interface (Default)"
		while read -r devifcfgline
		do
			echo "----$devifcfgline | font=Menlo size=11"
		done < <(echo "$devifcfg")
		nstatifcfg=$(ifconfig $nstat 2>/dev/null | sed 's/^'"$nstat"': //')
		if $vpn ; then
			echo "--$nstat (TUN/TAP)"
		else
			echo "--$nstat (Other)"
		fi
		while read -r nstatifcfgline
		do
			echo "----$nstatifcfgline | font=Menlo size=11"
		done < <(echo "$nstatifcfg")
	else
		echo "--Device | size=11 color=gray"
		echo "--$interface"
		while read -r devifcfgline
		do
			echo "----$devifcfgline | font=Menlo size=11"
		done < <(echo "$devifcfg")
	fi
	echo "-----"
	echo "--Current DNS Resolvers | size=11 color=gray"
	if ! [[ ${current_resolvers} ]] ; then
		echo "--None"
	else
		for cres in ${current_resolvers}
		do
			if $dnso ; then
				echo "--$cres"
			elif $dnsd ; then
				cresname=$(echo "$defaultdns" | grep -F "$cres" | awk '{print substr($0, index($0,$2))}')
				! [[ $cresname ]] && cresname="n/a"
				echo "--$cres ($cresname)"
			else
				if [[ $cres == $DNSCRYPT_PROXY_IPS ]] ; then
					cresname="DNSCrypt"
				else
					if $dnscf ; then
						cresname=$(echo "$fallbacks" | grep -F "$cres" | awk '{print substr($0, index($0,$2))}')
						! [[ $cresname ]] && cresname="n/a"
					else
						cresname="n/a"
					fi
				fi
				echo "--$cres ($cresname)"
			fi
		done
	fi
	echo "-----"
	if ! [[ $dnsip ]] ; then
		echo "--Public DNS Information | size=11 color=gray"
		echo "--Unknown IP"
		echo "--Unknown Hostname"
		echo "--No Ping Result"
	else
		if [[ $dnsip != $currentdnsip ]] ; then
			whois $dnsip > "$cachedir/whois.log" 2>/dev/null
			dnsname=""
			method=""
			dnsname=$(nslookup "$dnsip" 2>/dev/null | awk -F" = " '/name = /{print substr($0, index($0,$2))}' | sed 's/\.$//')
			if ! [[ $dnsname ]] ; then
				hostall=$(host "$dnsip" 2>/dev/null)
				if [[ $hostall ]] && ! [[ $(echo "$hostall" | grep "not found") ]] && ! [[ $(echo "$hostall" | grep "timed out") ]] ; then
					dnsname=$(echo "$hostall" | awk -F"domain name pointer " '{print substr($0, index($0,$2))}' | sed 's/\.$//')
				fi
				if ! [[ $dnsname ]] || ! [[ $hostall ]] || [[ $(echo "$hostall" | grep "not found") ]] || [[ $(echo "$hostall" | grep "timed out") ]] ; then
					dnsname=$(dig +short -x "$dnsip" 2>/dev/null | sed 's/\.$//')
					if ! [[ $dnsname ]] ; then
						dnsname=$(curl -sL "https://ipinfo.io/$dnsip/hostname" 2>/dev/null | xargs)
						if ! [[ $dnsname ]] || [[ $(echo "$dnsname" | grep "requests") ]] ; then
							dnsname=$(curl -sL "https://www.robtex.com/ip/$dnsip.html" 2>/dev/null | grep -m1 "The PTR is" | awk -F"The PTR is " '{print $2}' | awk -F". " '{print $1}' | xargs)
							[[ $dnsname ]] && method="robtex"
						else
							method="ipinfo"
						fi
					else
						method="dig"
					fi
				else
					method="host"
				fi
			else
				method="nslookup"
			fi
			! [[ $dnsname ]] && dnsname="Unknown Hostname"
			echo "$dnsip $dnsname" > "$currloc"
		else
			dnsname="$currentdnsname"
			! [[ $dnsname ]] && dnsname="Unknown Hostname"
		fi
		! [[ $method ]] && method="cache"
		echo "--Public DNS Information ($method)| size=11 color=gray"
		echo "--$dnsip | href=\"https://www.robtex.com/ip-lookup/$dnsip\""
		echo "--Copy Address… | alternate=true terminal=false bash=$0 param1=dnscopy param2=ip param3=\"$dnsip\""
		if [[ $dnsname != "Unknown Hostname" ]] ; then
			echo "--$dnsname | href=\"https://www.robtex.com/dns-lookup/$dnsname\""
			echo "--Copy Hostname… | alternate=true terminal=false bash=$0 param1=dnscopy param2=hostname param3=\"$dnsname\""
		else
			echo "--$dnsname"
		fi
		whoisout=$(cat "$cachedir/whois.log" 2>/dev/null)
		if [[ $whoisout ]] ; then
			echo "--Whois Information"
			echo "----Open Current Whois Log File… | terminal=false bash=/usr/bin/open param1=\"$cachedir/whois.log\""
			echo "-------"
			while read -r line
			do
				! [[ $line ]] && { echo "-------" ; continue ; }
				! [[ $(echo "$line" | grep ":") ]] && continue
				echo -e "----$line | font=Menlo size=11"
			done < <(echo "$whoisout" | grep -v -e "^#" -e "^%" -e "^remarks:" -e "^Comment:" -e ":$")
		else
			echo "--Whois"
		fi
		millisecs=$(ping -c 2 -n -q "$dnsip" 2>/dev/null | tail -n 1 | awk -F/ '{print $5}')
		if [[ $millisecs ]] ; then
			echo "--$millisecs ms"
		else
			echo "--No Ping Result"
		fi
	fi
	if $dnsc || $dnscf ; then
		if [[ $oneshotres ]] ; then
			echo "-----"
			echo "--Internal Fallback Resolver | size=11 color=gray"
			echo "--$oneshotres"
		fi
	fi
	if $dnsd ; then
		echo "-----"
		echo "--Local Area DNS | size=11 color=gray"
		if [[ $ldnsname != "" ]] ; then
			echo "--$localdns ($ldnsname)"
		else
			echo "--$localdns"
		fi
	fi
	echo "-----"
	echo "--Configured $service Resolvers | size=11 color=gray"
	for sresolv in ${service_resolvers}
	do
		echo "--$sresolv"
	done
	if $dnso && ! $vpn ; then
		echo "-----"
		echo "--Backup Current $service Resolvers… | terminal=false refresh=true bash=$0 param1=cbackup"
		echo "-----"
		_omenu
	fi
}

_dnscmenu () {
	echo "--Configured Resolver | size=11 color=gray"
	for proxyip in ${DNSCRYPT_PROXY_IPS}
	do
		echo "--$proxyip"
	done
	if [[ $oneshotres ]] ; then
		echo "-----"
		echo "--Internal Fallback Resolver | size=11 color=gray"
		echo "--$oneshotres"
	fi
}

_fbmenu () {
	echo "--Configured DNSCrypt Resolver | size=11 color=gray"
	for proxyip in ${DNSCRYPT_PROXY_IPS}
	do
		echo "--$proxyip"
	done
	if [[ $oneshotres ]] ; then
		echo "-----"
		echo "--Internal Fallback Resolver | size=11 color=gray"
		echo "--$oneshotres"
	fi
	echo "-----"
	echo "--Configured Fallback Resolvers | size=11 color=gray"
	if ! [[ $fbipss ]] ; then
		echo "--None"
	else
		while read -r fbip
		do
			fbname=$(echo "$fallbacks" | grep -F "$fbip" | awk '{print substr($0, index($0,$2))}')
			[[ $fbname == "" ]] && fbname="n/a"
			echo "--$fbip ($fbname)"
		done < <(echo "$fbipss")
	fi
	echo "-----"
	echo "--Edit Fallback Resolvers… | terminal=false bash=/usr/bin/open param1=-a param2=TextEdit param3=$fbloc"
}

_dfmenu () {
	echo "--Configured Resolvers | size=11 color=gray"
	if ! [[ $udfipss ]] ; then
		echo "--None"
	else
		while read -r cddnsr
		do
			cddnsrname=$(echo "$defaultdns" | grep -F "$cddnsr" | awk '{print substr($0, index($0,$2))}')
			[[ $cddnsrname == "" ]] && fbname="n/a"
			echo "--$cddnsr ($cddnsrname)"
		done < <(echo "$udfipss")
	fi
	echo "-----"
	echo "--Available Local Area DNS | size=11 color=gray"
	if [[ $ldnsname != "" ]] ; then
		echo "--$localdns ($ldnsname)"
	else
		echo "--$localdns"
	fi
	echo "-----"
	echo "--Edit Default DNS Resolvers… | terminal=false bash=/usr/bin/open param1=-a param2=TextEdit param3=$udfloc"
}

_omenu () {
	echo "--$service Resolver Backups | size=11 color=gray"
	rbackuplist=$(find "$cfgdir" -maxdepth 1 -type f -name "$baklocname-d*")
	if [[ $rbackuplist ]] ; then
		while read -r rbackup
		do
			bpdate=$(basename "$rbackup" | awk -F"-d" '{print $2}')
			bdate=$(date -j -f "%s" "$bpdate" "%a %d %b %Y %T %Z" 2>/dev/null)
			! [[ $bdate ]] && bdate="Undated Backup"
			echo "--$bdate"
			bresolvers=$(cat "$rbackup")
			if [[ $bresolvers ]] ; then
				for bresolver in ${bresolvers}
				do
					echo "----$bresolver"
				done
				echo "-------"
				if [[ ${bresolvers} != ${service_resolvers} ]] ; then
					echo "----Load Resolvers From Backup… | terminal=false refresh=true bash=$0 param1=rload param2=\"$bpdate\""
				else
					echo "----Currently Loaded"
				fi
			else
				echo "----Empty"
			fi
		done < <(echo "$rbackuplist" | sort -r)
	fi
	iball=$(cat "$ibakloc" 2>/dev/null)
	if [[ $iball ]] ; then
		bpdate=$(echo "$iball" | grep "^#" | awk '{print $2}')
		bdate=$(date -j -f "%s" "$bpdate" "%a %d %b %Y %T %Z" 2>/dev/null)
		! [[ $bdate ]] && bdate="Undated Backup"
		echo "--$bdate"
		echo "----Initial Resolver Backup | size=11 color=gray"
		ibresolvers=$(echo "$iball" | grep -v "^#")
		if [[ $ibresolvers ]] ; then
			for ibresolver in ${ibresolvers}
			do
				echo "----$ibresolver"
			done
			echo "-------"
			if [[ ${ibresolvers} != ${service_resolvers} ]] ; then
				echo "----Load Resolvers From Backup… | terminal=false refresh=true bash=$0 param1=rload param2=initial"
			else
				echo "----Currently Loaded"
			fi
			echo "-----"
		else
			echo "----Empty"
		fi
	else
		echo "--No Initial Backup Detected"
	fi
}

echo "---"

if $proxy ; then
	if $dnsc ; then
		echo "DNSCrypt | checked=true"
		_dnsinfo
		echo "Set As Default… | alternate=true refresh=true terminal=false checked=true bash=$0 param1=default param2=dcp"
		_dnsinfo
	else
		if ! $dnso ; then
			echo "DNSCrypt | terminal=false refresh=true bash=$0 param1='${DNSCRYPT_PROXY_IPS}'"
			_dnscmenu
			echo "Set As Default… | alternate=true refresh=true terminal=false bash=$0 param1=default param2=dcp"
			_dnscmenu
		else
			if $vpn ; then
				echo "DNSCrypt | color=gray"
			else
				echo "DNSCrypt | terminal=false refresh=true bash=$0 param1='${DNSCRYPT_PROXY_IPS}'"
			fi
			_dnscmenu
			echo "Set As Default… | alternate=true refresh=true terminal=false bash=$0 param1=default param2=dcp"
			_dnscmenu
		fi
	fi
	if $dnscf ; then
		echo "DNSCrypt + Fallback | checked=true"
		_dnsinfo
		echo "Set As Default… | alternate=true refresh=true terminal=false checked=true bash=$0 param1=default param2=dcpfb"
		_dnsinfo
	else
		if ! $dnso ; then
			echo "DNSCrypt + Fallback | terminal=false refresh=true bash=$0 param1='${DNSCRYPT_PROXY_IPS} ${ADDITIONAL_IP}'"
			_fbmenu
			echo "Set As Default… | alternate=true refresh=true terminal=false bash=$0 param1=default param2=dcpfb"
			_fbmenu
		else
			if $vpn ; then
				echo "DNSCrypt + Fallback | color=gray"
			else
				echo "DNSCrypt + Fallback | terminal=false refresh=true bash=$0 param1='${DNSCRYPT_PROXY_IPS} ${ADDITIONAL_IP}'"
			fi
			_fbmenu
			echo "Set As Default… | alternate=true refresh=true terminal=false bash=$0 param1=default param2=dcpfb"
			_fbmenu
		fi
	fi
	if $dnsd ; then
		echo "Default DNS | checked=true"
		_dnsinfo
		echo "Other DNS"
	else
		if $dnso ; then
			if $vpn ; then
				echo "Default DNS | color=gray"
			else
				echo "Default DNS | terminal=false refresh=true bash=$0 param1='${UDEFAULT}'"
			fi
			_dfmenu
			echo "Other DNS | checked=true"
			_dnsinfo
		else
			echo "Default DNS | terminal=false refresh=true bash=$0 param1='${UDEFAULT}'"
			_dfmenu
			echo "Other DNS"
			_omenu
		fi
	fi
else
	echo "DNSCrypt"
	echo "Set As Default… | alternate=true refresh=true terminal=false bash=$0 param1=default param2=dcp"
	echo "DNSCrypt + Fallback"
	echo "Set As Default… | alternate=true refresh=true terminal=false bash=$0 param1=default param2=dcpfb"
	if $dnsd ; then
		echo "Default DNS | checked=true"
		_dnsinfo
		echo "Other DNS"
		_omenu
	elif $dnso ; then
		if $vpn ; then
			echo "Default DNS | color=gray"
		else
			echo "Default DNS | terminal=false refresh=true bash=$0 param1='${UDEFAULT}'"
		fi
		_dfmenu
		echo "Other DNS | checked=true"
		_dnsinfo
	fi
fi

scrparent="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
scrpath="$scrparent/$SCRNAME"
scrshort="${scrpath/#$HOME/~}"

_serviceinfo () {
	echo "--Configure… | terminal=false bash=/usr/bin/open param1=\"$TOML\""
	echo "-----"
	! [[ $dcpver ]] && dcpverp="n/a" || dcpverp="v$dcpver"
	if $proxy ; then
		echo "--PID $proxystatus ($dcpverp)"
		echo "--$DNSCRYPT_PROXY_IPS:$dnsport"
	else
		echo "--Disabled ($dcpverp)"
	fi
	servout=$(cat "$cachedir/service" 2>/dev/null)
	if [[ $servout ]] ; then
		mdate=$(stat -f "%Sc" "$cachedir/service")
		servout=$(echo "$servout" | sed -e 's/^Password://g' -e 's/^==> //g')
		if $proxy ; then
			servlabel=$(echo "$servout" | grep "label: " | awk -F": " '{print $2}' | sed 's/)$//g' | awk '!seen[$0]++')
			! [[ $servlabel ]] && servlabel="Unknown Service Name"
			echo "--$servlabel"
		fi
		if [[ $servout ]] ; then
			echo "-----"
			echo "--Latest Output"
			echo "----$mdate | font=Menlo size=11"
			while read -r line
			do
				echo "----$line | font=Menlo size=11"
			done < <(echo -e "$servout" | sed 's/ (label: .*)$//g')
		fi
	fi
	echo "-----"
	echo "--Network Status"
	if [[ $chnstat ]] || [[ $nstat_listen ]] ; then
		if [[ $chnstat ]] ; then
			while read -r nstati
			do
				echo "----$nstati | font=Menlo size=11"
			done < <(echo "$chnstat")
			echo "-------"
			liface=$(echo "$chnstat" | rev | awk '{print $1}' | rev)
			ifcfg=$(ifconfig "$liface" 2>/dev/null | sed 's/^'"$liface"': //')
		fi
		if [[ $nstat_listen ]] ; then
			while read -r nstatl
			do
				echo "----$nstatl | font=Menlo size=11"
			done < <(echo "$nstat_listen")
		else
			echo "----$DNSCRYPT_PROXY_IPS.$dnsport NOT LISTENING | font=Menlo size=11"
		fi
		if [[ $ifcfg ]] ; then
			echo "-------"
			while read -r ifcfgline
			do
				echo "----$ifcfgline | font=Menlo size=11"
			done < <(echo "$ifcfg")
		fi
	else
		echo "----No Information"
	fi
	logline=$(echo "$CONFIG" | grep "log_file = " | head -n 1)
	echo "-----"
	if [[ $logline != "#"* ]] ; then
		logloc=$(echo "$logline" | awk -F\' '{print $2}')
		if [[ $logloc != "/"* ]] ; then
			logloc="$etcdir/$logloc"
		fi
		if [[ -f $logloc ]] ; then
			if $proxy ; then
				logcont=$(tail -r "$logloc" | awk '{print} / Source \[/ {exit}' | tail -r)
				if [[ $logcont ]] ; then
					logcont=$(echo "$logcont" | grep -v "^$")
					echo "--Latest Log Data"
					loglevelline=$(echo "$CONFIG" | grep "log_level = ")
					if [[ $loglevelline == "#"* ]] ; then
						loglevel="2"
					else
						loglevel=$(echo "$loglevelline" | awk -F" = " '{print $2}')
						! [[ $loglevel ]] && loglevel="2"
					fi
					echo "----Log Level: $loglevel"
					syslogline=$(echo "$CONFIG" | grep "use_syslog = ")
					if [[ $syslogline == "#"* ]] ; then
						syslog="false"
					else
						syslog=$(echo "$syslogline" | awk -F" = " '{print $2}')
					fi
					echo "----System Logging: $syslog"
					echo "-------"
					today=$(date +"%Y-%m-%d")
					logtimeouts=$(echo -e "$logcont" | grep "TIMEOUT$" | sed -e 's/TIMEOUT$//g' -e 's/\[NOTICE\] //g' | grep "^\[$today")
					logerrors=$(echo -e "$logcont" | grep -F "[ERROR]" | sed -e 's/\[ERROR\] //g' | grep "^\[$today")
					logfatal=$(echo -e "$logcont" | grep -F "[FATAL]" | sed -e 's/\[FATAL\] //g' | grep "^\[$today")
					logwarnings=$(echo -e "$logcont" | grep -F "[WARNING]" | sed -e 's/\[WARNING\] //g' | grep "^\[$today" | sed -e "s/ -- if you don't manage this server, tell the server operator about it/ -- notify operator/g")
					lowlat=$(echo -e "$logcont" | grep "\] \[NOTICE\] Server with the lowest initial latency: " | sed -e '$!d' -e 's/\[NOTICE\] //g' -e 's/Server with the lowest/Lowest/')
					logcont=$(echo -e "$logcont" | grep -v -e "\[ERROR\]" -e "\[FATAL\]" -e "\[WARNING\]" -e "TIMEOUT$" -e "\] \[NOTICE\] Server with the lowest initial latency: " | sed 's/\[NOTICE\] //g')
					if [[ $logfatal ]] ; then
						echo "----Fatal Errors"
						while read -r line
						do
							echo "------$line | font=Menlo size=11"
						done < <(echo "$logfatal")
					fi
					if [[ $logerrors ]] ; then
						echo "----Errors"
						while read -r line
						do
							echo "------$line | font=Menlo size=11"
						done < <(echo "$logerrors")
					fi
					if [[ $logwarnings ]] ; then
						echo "----Warnings"
						while read -r line
						do
							echo "------$line | font=Menlo size=11"
						done < <(echo "$logwarnings")
					fi
					if [[ $logtimeouts ]] ; then
						echo "----Timeouts"
						while read -r line
						do
							echo "------$line | font=Menlo size=11"
						done < <(echo "$logtimeouts")
					fi
					if [[ $logcont ]] ; then
						echo "-------"
						while read -r line
						do
							echo "----$line | font=Menlo size=11"
						done < <(echo "$logcont" | sed 's/dnscrypt-proxy is //g')
					fi
					if [[ $lowlat ]] ; then
						echo "-------"
						echo "----$lowlat | font=Menlo size=11"
					fi
				fi
				echo "--View Full Log… | terminal=false bash=/usr/bin/open param1=\"$logloc\""
			else
				echo "--View Log… | terminal=false bash=/usr/bin/open param1=\"$logloc\""
			fi
		else
			echo "--Logging Disabled"
		fi
	fi
	echo "-----"
	serverscfg=$(echo "$CONFIG" | grep "^server_names =" | awk -F'[][]' '{print $2}' | sed -e 's/, /\\n/g' -e "s/\\'//g")
	serverscfg=$(echo -e "$serverscfg" | sort)
	cd "$tomldir"
	serversall=$(dnscrypt-proxy -list-all 2>/dev/null)
	resolversources=$(echo "$CONFIG" | grep "url = " | grep -v -e "# url = " -e "#  url = " | awk -F\' '{print $2}' | xargs)
	if [[ $serverscfg ]] ; then
		serversreal=$(dnscrypt-proxy -list 2>/dev/null | sort)
		serversrej=$(comm -23 <(echo "$serverscfg") <(echo "$serversreal"))
		echo "--Current DNSCrypt Servers"
		[[ $serversrej ]] && echo "----Configured | color=gray size=11"
		while read -r server
		do
			echo "----$server | font=Menlo size=11"
		done < <(echo "$serverscfg")
		if [[ $serversrej ]] ; then
			echo "-------"
			echo "----Ignored | size=11 color=gray"
			while read -r server
			do
				echo "----$server | font=Menlo size=11"
			done < <(echo "$serversrej")
		fi
		echo "--Available DNSCrypt Servers"
		echo "----Open Resolver Lists… | terminal=false bash=$0 param1=opensource param2=\"${resolversources}\""
		echo "-------"
		while read -r server
		do
			echo "----$server | font=Menlo size=11"
		done < <(echo "$serversall")
	else
		echo "--Current DNSCrypt Servers"
		while read -r server
		do
			echo "----$server | font=Menlo size=11"
		done < <(echo "$serversall")
	fi
	if [[ $resolversources ]] ; then
		echo "--Configured Resolver Sources"
		for resolversource in ${resolversources}
		do
			echo "----$resolversource | font=Menlo size=11 href=\"$resolversource\""
		done
	fi
	echo "--DNSCrypt Public Server List | href=https://dnscrypt.info/public-servers"
	echo "-----"
	echo "--Paths"
	echo "----Executable | size=11 color=gray"
	shortpath="${dcploc/#$HOME/~}"
	pathdir=$(dirname "$dcploc")
	echo "----$shortpath | font=Menlo size=11 terminal=false bash=/usr/bin/open param1=\"$pathdir\""
	if [[ -h $dcploc ]] ; then
		dcpaloc=$(_abspath "$dcploc")
		dcpashort="${dcpaloc/#$HOME/~}"
		dcpaparent=$(dirname "$dcpaloc")
		echo "----→ $dcpashort | font=Menlo size=11 terminal=false bash=/usr/bin/open param1=\"$dcpaparent\""
	fi
	echo "-------"
	echo "----Configuration File | size=11 color=gray"
	shorttoml="${TOML/#$HOME/~}"
	echo "----$shorttoml | font=Menlo size=11 terminal=false bash=/usr/bin/open param1=\"$tomldir\""
	if [[ -h $TOML ]] ; then
		tomla=$(_abspath "$TOML")
		tomlashort="${tomla/#$HOME/~}"
		tomlaparent=$(dirname "$tomla")
		echo "----→ $tomlashort | font=Menlo size=11 terminal=false bash=/usr/bin/open param1=\"$tomlaparent\""
	fi
	echo "-----"
	echo "--Clear DNS Cache… | terminal=false refresh=true bash=$0 param1=network param2=flush"
	echo "--Renew DHCP Lease… | terminal=false refresh=true bash=$0 param1=network param2=dhcp"
	echo "-----"
	echo "--Open Network Preferences… | terminal=false bash=/usr/bin/open param1=\"/System/Library/PreferencePanes/Network.prefPane\""
}

echo "---"

if $proxy ; then
	echo "DNSCrypt Service | checked=true terminal=false bash=$0 param1=proxyservice param2=stop"
	_serviceinfo
	echo "Force-Restart… | checked=true alternate=true terminal=false bash=$0 param1=proxyservice param2=force-restart"
	_serviceinfo
else
	echo "DNSCrypt Service | terminal=false bash=$0 param1=proxyservice param2=start"
	_serviceinfo
fi

echo "---"

echo "DNSCrypt Menu"
if ! $stopped ; then
	echo "--Stop Plugin… | terminal=false refresh=true bash=$0 param1=toggle param2=stop"
	echo "-----"
fi
echo "--Version $dcmver$dcmvadd"
echo "-----"
if [[ -h $scrpath ]] ; then
	echo "--Plugin Script Paths"
	echo "----$scrshort | font=Menlo size=11 terminal=false bash=/usr/bin/open param1=\"$scrparent\""
	scrapath=$(_abspath "$scrpath")
	scrashort="${scrapath/#$HOME/~}"
	scraparent=$(dirname "$scrapath")
	echo "----→ $scrashort | font=Menlo size=11 terminal=false bash=/usr/bin/open param1=\"$scraparent\""
else
	echo "--Plugin Script Path"
	echo "----$scrshort | font=Menlo size=11 terminal=false bash=/usr/bin/open param1=\"$scrparent\""
fi
echo "-----"
echo "--Edit Plugin… | terminal=false bash=/usr/bin/open param1=\"$scrpath\""
echo "--Open Configuration Directory… | terminal=false bash=/usr/bin/open param1=\"$cfgdir\""
echo "--Open Cache Directory… | terminal=false bash=/usr/bin/open param1=\"$cachedir\""
echo "-----"
echo "--External Links"
echo "----DNSCrypt Menu | size=11 color=gray"
echo "----GitHub Repository | href=https://github.com/JayBrown/DNSCrypt-Menu"
echo "----Issues | href=https://github.com/JayBrown/DNSCrypt-Menu/issues"
echo "-------"
echo "----dnscrypt-proxy | size=11 color=gray"
echo "----GitHub Repository | href=https://github.com/jedisct1/dnscrypt-proxy"
echo "----Documentation | href=https://github.com/jedisct1/dnscrypt-proxy/wiki"
echo "----Issues | href=https://github.com/jedisct1/dnscrypt-proxy/issues"
echo "-------"
echo "----DNSCrypt | size=11 color=gray"
echo "----Homepage | href= https://dnscrypt.info"
echo "-----"
echo "Refresh… | refresh=true"
