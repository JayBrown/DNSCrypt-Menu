#!/bin/bash

# DNSCrypt Source Watcher
# dnscrypt-ipns.sh
# v1.0.4
# includes LaunchAgent plist running fswatch
#
# script to add updated resolver source & minisign signature files to the IPFS & publish to IPNS
# Copyright (c) 2018 Joss Brown (pseud.)
# License: MIT+
# published as part of the DNSCrypt Menu repository: https://github.com/JayBrown/DNSCrypt-Menu

export LANG=en_US.UTF-8
export PATH=$PATH:/usr/local/bin:/opt/local/bin:/sw/bin:$HOME/bin
export IPFS_REUSEPORT=false

currentdate=$(date)

outputloc="/tmp/local.lcars.DNSCryptSourceWatcher.log"

exec 1>> "$outputloc" 2>&1

echo "**********************************************"
echo "*** Activity detected: public-resolvers.md ***"
echo "**********************************************"
echo "$currentdate"

etcdir="/usr/local/etc"
fnames="public-resolvers.md public-resolvers.md.minisig"

cachedir="$HOME/.cache/ipfs"
if ! [[ -d "$cachedir" ]] ; then
	echo "Cache directory not detected: creating..."
	mkdir -p "$cachedir"
else
	echo "Cache directory detected"
fi

iconurl="https://github.com/ipfs/logo/raw/master/raster-generated/ipfs-logo-1024-ice-text.png"
icon_loc="$cachedir/ipfs.png"
if ! [[ -f "$icon_loc" ]] ; then
	echo "Downloading IPFS icon file..."
	curl -sL -o "$icon_loc" "$iconurl"
else
	echo "IPFS icon file detected"
fi

storedir="dnscrypt"
ipnskey="Qmcy2uSAkLDLaGsPagjbwHJJMwkXJQu5XvxGiUpN1jzsSP"
ipnskeyname="dnscrypt-source"
testhash="Qmaisz6NMhDB51cCvNWa1GMS7LU1pAxdF4Ld6Ft9kZEP2a"

account=$(id -un)
process="DNSCrypt Source Watcher"

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
	echo "Caching on gateways: $iphash"
	_notify "Caching on gateways…" "$iphash"
	while read -r gateway
	do
		testurl="$gateway/ipfs/$testhash"
		if [[ $(curl --silent --connect-timeout 30 "$testurl") == "Hello from IPFS Gateway Checker" ]] ; then
			echo "Online: $gateway"
			curl --silent -o /dev/null --connect-timeout 60 "$gateway/ipfs/$iphash"
		else
			echo "Offline: $gateway"
		fi
	done < <(echo "$gateways")
	echo "Caching complete: $iphash"
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

echo "Notifications: $tn_status"

sleep 8

for fname in ${fnames}
do
	[[ $(echo "$fname" | grep "minisig$") ]] && continue
	if ! [[ -f "$cachedir/$fname" ]] ; then
		echo "No backup detected: creating..."
		cp "$etcdir/$fname" "$cachedir/$fname"
	fi
	mdhash1=$(md5 -q "$cachedir/$fname")
	echo "MD5: $mdhash1 (backup)"
	mdhash2=$(md5 -q "$etcdir/$fname")
	echo "MD5: $mdhash2 (current)"
	if [[ $mdhash1 == $mdhash2 ]] ; then
		echo "No change: $fname"
		echo "*** Exiting... ***"
		exit 0
	else
		echo "File changed: $fname"
		echo "Creating new backup..."
		cp "$etcdir/$fname" "$cachedir/$fname"
	fi
done

csource="$cachedir/dnscrypt"
cobjects=$(cat "$csource" 2>/dev/null)
if [[ $cobjects ]] ; then
	echo "IPFS hash log detected:"
	echo "$cobjects"
else
	echo "IPFS hash log empty or missing"
fi

_beep

if [[ $(pgrep ipfs) ]] ; then
	running=true
	echo "IPFS daemon is already running"
	_notify "Sources updated" "IPFS daemon already running"
else
	running=false
	echo "IPFS daemon is not running: starting now..."
	_notify "Sources updated" "Starting IPFS daemon…"
	ipfs daemon --writable --enable-namesys-pubsub &
	sleep 5
fi

if [[ $(ipfs files ls | grep "^$storedir") ]] ; then
	echo "MFS directory /$storedir detected"
	while read -r object
	do
		oname=$(echo "$object" | awk '{print $1}')
		ohash=$(echo "$object" | awk '{print $2}')
		echo "Removing from MFS: $oname"
		ipfs files rm "/$storedir/$oname" 2>/dev/null
		_notify "Removed MFS object" "$oname"
		sleep 1
		echo "Removing from node: $ohash"
		ipfs pin rm $ohash && _notify "Unpinned node object" "$ohash" || _notify "Couldn't unpin node object" "$ohash"
		sleep 1
	done < <(ipfs files ls -l "/$storedir")
else
	echo "MFS directory /$storedir missing: creating..."
	ipfs files mkdir "/$storedir"
	_notify "Created directory" "MFS: /$storedir"
fi

for fname in ${fnames}
do
	echo "Adding to IPFS: $fname"
	newhash=$(ipfs add -Q "$etcdir/$fname")
	echo "Added: $newhash"
	_notify "Added node object" "$newhash"
	sleep 1
	echo "Copying to MFS: $newhash > /$storedir/$fname"
	ipfs files cp /ipfs/$newhash "/$storedir/$fname" && _notify "Added MFS object" "$fname"
	_cache "$newhash"
done

dirhash=$(ipfs files ls -l | awk '/'"^$storedir"'/{print $2}')
echo "Parent hash: $dirhash"
open "https://ipfs.io/ipfs/$dirhash"
nobjects=$(ipfs files ls -l "/$storedir")
echo "New IPFS hash log:"
echo "$nobjects"
echo "$nobjects" > "$csource"

_notify "Publishing…" "$dirhash"
echo "Publishing $dirhash to IPNS..."
ipfs name publish --key=$ipnskeyname $dirhash
echo "IPNS key: $ipnskey"
echo "IPNS key name: $ipnskeyname"
open "https://ipfs.io/ipns/$ipnskey"

_notify "Starting garbage collection" "Please wait…"
echo "Collecting garbage on IPFS node..."
ipfs repo gc

if ! $running ; then
	echo "Shutting down IPFS daemon..."
	ipfs shutdown && _notify "Done" "Shutting down IPFS daemon"
else
	_notify "Done" "Keeping IPFS daemon alive"
fi

echo "*** Exiting... ***"
exit
