#!/usr/bin/env bash

mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/fluxerupdate"
cd "${XDG_DATA_HOME:-$HOME/.local/share}/fluxerupdate" || exit

if cat version.txt
then
	appimage-run ./fluxer.AppImage "$@"
fi

zenity --info --title="Fetching" --text="Fetching release information..." --no-wrap &
PID="$!"

PAGE=1
while true; do
	API_RESPONSE=$(curl -s "https://api.github.com/repos/fluxerapp/fluxer/releases?per_page=50&page=$PAGE")
	
	if [[ "$(printf "%s" "$API_RESPONSE" | jq '. | length')" -eq 0 ]]; then
		break
	fi

	RELEASE="$(printf "%s" "$API_RESPONSE" | jq -r '[.[] | select(.name | contains("fluxer-desktop-stable"))][0]')"

	if [[ "$RELEASE" != "null" && -n "$RELEASE" ]]; then
		break
	fi

	((PAGE++))
done

VERSION="$(printf "%s" "$RELEASE" | jq -r '.tag_name' | grep -o "[^@]*$")"

kill "$PID" 2>/dev/null

printf "%s" "$VERSION" > version.txt
ASSET="$(printf "%s" "$RELEASE" | jq -r '[.assets[] | select(.name | test("-linux-x86_64\\.AppImage$"))][0]')"

zenity --info --title="Downloading" --text="The latest version is being downloaded..." --no-wrap &
PID="$!"
curl -L "$(printf "%s" "$ASSET" | jq -r '.browser_download_url')" -o fluxer.AppImage
kill "$PID" 2>/dev/null

chmod +x fluxer.AppImage
appimage-run ./fluxer.AppImage "$@"

