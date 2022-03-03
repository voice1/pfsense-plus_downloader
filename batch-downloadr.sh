#!/usr/bin/env bash
_verison = 0.0.2

# Download pfsense+ firmware from site.
# Requires cookies to be valid first so a browswer login and  fetch of the cookie is required.
# Setting version allows for downloading only current version.

# CHANGES
# * 3/3/22 - Netgate updated filenames to include 'Netgate' and dropped the 'SG' prefix.
# * 3/3/22 - firmware neme for '-recover-' changed to '-recovery-'
# * 3/3/22 - Added prompt to first login to partner portal and copy cookie.

USER_COOKIE=""
CURRENT_VERISON="22.01"
DL_CHECKSUM=1		# Set to 1 to download .sha256 checksum
VERIFY_CHECKSUM=0	# Set to 0 to verify checksum.
CURL_OPTS="--compressed --progress-bar -O"

function sort_firmware_versions() {
	# Sort firmware to directories by model type.
	echo "Not implemented"
}

function verify_sha256() {
	# Verify SHA256 signature Filename should not have the .sha256 suffix
	filename=$1
	checksum=$(sha256sum --check "${filename}.sha256")

	# TODO colorize response. Check if failed/success
	echo $checksum
}

function download() {
	# Starting on 22.01 Netgate started adding "Netgate-" to the filenames and dropped the SG- but kept the sg in the path.
	# Additionally they renamed -recover- to -recovery-
	BRANDING="pfSense-plus-Netgate"
	# SG-1100
	URL[0]="https://partnervault.netgate.com/files/firmware/sg-1100/${BRANDING}-1100-recovery-${DOWNLOAD_VERISON}-RELEASE-aarch64.img.gz"
	# SG-2100
	URL[1]="https://partnervault.netgate.com/files/firmware/sg-2100/${BRANDING}-2100-recovery-${DOWNLOAD_VERISON}-RELEASE-aarch64.img.gz"
	# SG-3100
	URL[2]="https://partnervault.netgate.com/files/firmware/sg-3100/${BRANDING}-3100-recovery-${DOWNLOAD_VERISON}-RELEASE-armv7.img.gz"
	# SG-5100-6100
	URL[3]="https://partnervault.netgate.com/files/firmware/sg-5100-6100/pfSense-plus-memstick-serial-${DOWNLOAD_VERISON}-RELEASE-amd64.img.gz"
	# SG-7100
	URL[4]="https://partnervault.netgate.com/files/firmware/sg-7100/pfSense-plus-memstick-Netgate-7100-${DOWNLOAD_VERSION}-RELEASE-amd64.img.gz"
	# SG-1537/1541 aka. memstick
	URL[5]="https://partnervault.netgate.com/files/firmware/memstick/pfSense-plus-memstick-${DOWNLOAD_VERISON}-RELEASE-amd64.img.gz"
	# SG-1000
	URL[6]="https://partnervault.netgate.com/files/firmware/sg-1000/pfSense-plus-SG-1000-recovery-${DOWNLOAD_VERISON}-RELEASE-armv7.img.gz"
	# SG-2220-2440-4869-8860-XG-275 (EOS)
	URL[7]="https://partnervault.netgate.com/files/firmware/sg-2220-2440-4860-8860-xg-2758/pfSense-plus-memstick-ADI-SG-2220-2440-4860-8860-XG-2758-${DOWNLOAD_VERSION}-RELEASE-amd64.img.gz"

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

read -p "Login to https://partnervault.netgate.com and copy the cookie to the clipboard. Press enter to continue."

read -p "Enter the pfsense+ version to download [${CURRENT_VERISON}]: " DOWNLOAD_VERISON
DOWNLOAD_VERISON=${DOWNLOAD_VERISON:-${CURRENT_VERISON}}

read -p "Paste your user cookie, or enter to use default: (uf4=) " COOKIE
COOKIE=${COOKIE:-${USER_COOKIE}}

download

echo "Done. Have a nice day!"

# https://everything.curl.dev/usingcurl/copyas
