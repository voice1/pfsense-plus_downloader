#!/usr/bin/env bash

# Download pfsense+ firmware from site.
# Requires cookies to be valid first so a browswer login and  fetch of the cookie is required.
# Setting version allows for downloading only current version.


USER_COOKIE=""
CURRENT_VERISON="21.05.1"
DL_CHECKSUM=1		# Set to 1 to download .sha256 checksum
VERIFY_CHECKSUM=0	# Set to 0 to verify checksum.
CURL_OPTS="--compressed --progress-bar -O"

function verify_sha256() {
	# Verify SHA256 signature Filename should not have the .sha256 suffix
	filename=$1
	checksum=$(sha256sum --check "${filename}.sha256")

	# TODO colorize response. Check if failed/success
	echo $checksum
}

function download() {

	# SG-1000
	URL[6]="https://partnervault.netgate.com/files/firmware/sg-1000/pfSense-plus-SG-1000-recover-${DOWNLOAD_VERISON}-RELEASE-armv7.img.gz"
	# SG-1100
	URL[6]="https://partnervault.netgate.com/files/firmware/sg-1100/pfSense-plus-SG-1100-recover-${DOWNLOAD_VERISON}-RELEASE-armv7.img.gz"
	# SG-2100
	URL[5]="https://partnervault.netgate.com/files/firmware/sg-2100/pfSense-plus-SG-2100-recovery-${DOWNLOAD_VERISON}-RELEASE-aarch64.img.gz"
	# SG-3100
	URL[4]="https://partnervault.netgate.com/files/firmware/sg-3100/pfSense-plus-SG-3100-recover-${DOWNLOAD_VERISON}-RELEASE-armv7.img.gz"

	# memstick
	URL[0]="https://partnervault.netgate.com/files/firmware/memstick/pfSense-plus-memstick-${DOWNLOAD_VERISON}-RELEASE-amd64.img.gz"
	URL[1]="https://partnervault.netgate.com/files/firmware/memstick/pfSense-plus-memstick-ADI-${DOWNLOAD_VERISON}-RELEASE-amd64.img.gz"
	URL[2]="https://partnervault.netgate.com/files/firmware/memstick/pfSense-plus-memstick-XG-7100-${DOWNLOAD_VERISON}-RELEASE-amd64.img.gz"
	URL[3]="https://partnervault.netgate.com/files/firmware/memstick/pfSense-plus-memstick-serial-${DOWNLOAD_VERISON}-RELEASE-amd64.img.gz"

	# Download files.
	for url in "${URL[@]}"
	do
		filename=$(basename "${url}")
		echo "Downloading ${url} => ${filename}"
		curl "${url}" \
		-H 'Connection: keep-alive' \
		-H 'Upgrade-Insecure-Requests: 1' \
		-H "Cookie: ${COOKIE}" \
		${CURL_OPTS}

		if [ "$DL_CHECKSUM" -eq "1" ]; then
			sha_url="${url}.sha256"
			filename=$(basename "${sha_url}")
			echo "Downloading checksum ${filename} "
			curl "${sha_url}" \
			-H 'Connection: keep-alive' \
			-H 'Upgrade-Insecure-Requests: 1' \
			-H "Cookie: ${COOKIE}" \
			${CURL_OPTS}
		fi
	done
}

read -p "Enter the pfsense+ version to download [${CURRENT_VERISON}]: " DOWNLOAD_VERISON
DOWNLOAD_VERISON=${DOWNLOAD_VERISON:-${CURRENT_VERISON}}

read -p "Paste your user cookie, or enter to use default: " COOKIE
COOKIE=${COOKIE:-${USER_COOKIE}}
download

echo "Done. Have a nice day!"
