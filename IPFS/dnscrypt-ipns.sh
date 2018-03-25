#!/bin/bash

# dnscrypt-ipns.sh
# v1.0.0
#
# script to add updated resolver source & minisign signature files to the IPFS & publish to IPNS
# Copyright (c) Joss Brown (pseud.)
# License: MIT+
# published as part of DNSCrypt Menu: https://github.com/JayBrown/DNSCrypt-Menu

export LANG=en_US.UTF-8
export PATH=$PATH:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/sw/bin:/sw/sbin:$HOME/bin:$HOME/sbin
export IPFS_REUSEPORT=false

etcdir="/usr/local/etc"
fnames="public-resolvers.md public-resolvers.md.minisig"

cachedir="$HOME/.cache/ipfs"
! [[ -d "$cachedir" ]] && mkdir -p "$cachedir"

iconurl="https://github.com/ipfs/logo/raw/master/raster-generated/ipfs-logo-1024-ice-text.png"
icon_loc="$cachedir/ipfs.png"
if ! [[ -f "$icon_loc" ]] ; then
	curl -L -o "$icon_loc" "$iconurl"
fi

csource="$cachedir/dnscrypt"
cobjects=$(cat "$csource" 2>/dev/null)

storedir="dnscrypt"
ipnskey="Qmcy2uSAkLDLaGsPagjbwHJJMwkXJQu5XvxGiUpN1jzsSP"
ipnskeyname="dnscrypt-source"
testhash="Qmaisz6NMhDB51cCvNWa1GMS7LU1pAxdF4Ld6Ft9kZEP2a"

process="DNSCrypt Source Watcher"
account=$(id -un)

read -d '' gateways <<"EOF"
https://ipfs.io
https://gateway.ipfs.io
https://ipfs.infura.io
https://rx14.co.uk
https://xmine128.tk
https://upload.global
https://ipfs.jes.xxx
https://catalunya.network
https://siderus.io
https://www.eternum.io
https://hardbin.com
https://ipfs.macholibre.org
https://ipfs.works
https://ipfs.work
https://ipfs.wa.hle.rs
https://api.wisdom.sh
EOF

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

_cache () {
	iphash="$1"
	_notify "Caching on gateways…" "$iphash"
	while read -r gateway
	do
		testurl="$gateway/ipfs/$testhash"
		if [[ $(curl --silent --connect-timeout 30 "$testurl") == "Hello from IPFS Gateway Checker" ]] ; then
			curl -o /dev/null --connect-timeout 60 "$gateway/ipfs/$iphash"
		fi
	done < <(echo "$gateways")
	_notify "Caching complete" "$iphash"
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

_beep

if [[ $(pgrep ipfs) ]] ; then
	running=true
	_notify "Sources updated" "IPFS daemon already running"
else
	running=false
	_notify "Sources updated" "Starting IPFS daemon…"
	ipfs daemon --writable --enable-namesys-pubsub &
fi

sleep 5

if [[ $cobjects ]] ; then
	while read -r object
	do
		oname=$(echo "$object" | awk '{print $1}')
		ohash=$(echo "$object" | awk '{print $2}')
		ipfs files rm /"$storedir"/"$oname" && _notify "Removed Files object" "$oname"
		sleep 1
		ipfs pin rm "$ohash" && _notify "Unpinned node object" "$ohash"
		sleep 1
	done < <(ipfs files ls -l /"$storedir")
else
	ipfs files mkdir "/$storedir" && _notify "Created new directory" "IPFS Files API"
fi

for fname in ${fnames}
do
	newhash=$(ipfs add "$etcdir/$fname" | awk '{print $2}')
	_notify "Added node object" "$newhash"
	sleep 1
	ipfs files cp /ipfs/"$newhash" /"$storedir"/"$fname" && _notify "Added Files object" "$fname"
	_cache "$newhash"
done

dirhash=$(ipfs files ls -l | awk '/'"$storedir"'/{print $2}')
open "https://ipfs.io/ipfs/$dirhash"
nobjects=$(ipfs files ls -l /"$storedir")
echo "$nobjects" > "$csource"

_notify "Publishing…" "$dirhash"
ipfs name publish --key="$ipnskeyname" "$dirhash"
open "https://ipfs.io/ipns/$ipnskey"

_notify "Starting garbage collection" "Please wait…"
ipfs repo gc &&

if ! $running ; then
	ipfs shutdown && _notify "Done" "Shutting down IPFS daemon"
else
	_notify "Done" "Keeping IPFS daemon alive"
fi
