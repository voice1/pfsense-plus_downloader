# pfSense+ Downloader
Bash script to help download pfSense+ firmware images from Netgate servers.

> Before continuing you must have access to [Netgate Partner Vault](https://partnervault.netgate.com) or this script will not work.

## Target user
This script is only intended for authorized resellers and partners and solves the issue of needing/wanting to maintain a local copy of firmware images when new versions are released. As Netgate does not provide the files via a repository, this script allows you to login to the portal and download them locally.

## Usage
The script will prompt you to enter the version of firmware you wish to download.
```
Enter the pfsense+ version to download: 21.05
```

It will then ask you to supply a valid cookie. To get a valid cookie login to your partnervault and extract your cookie. 
If you need help extracting cookies, plenty of [extensions](https://chrome.google.com/webstore/detail/copy-cookies/jcbpglbplpblnagieibnemmkiamekcdg?hl=en) exist to assist.
```
Paste your user cookie, or enter to use default:
```
_if you wish, you can edit the script and set `USER_COOKIE` to the string. 

> In testing it appears that you can get by with only using the `uf4=` value. 

### Verification
If you wish to verify your download using the `.sha256` file, you will have to enable `VERIFY_CHECKSUM=1`

## Example
```
./batch-download.sh
Enter the pfsense+ version to download: 21.05
Paste your user cookie, or enter to use default: uf4=YouDidntThinkItWouldBeThatEasyDidYou?;
Downloading https://partnervault.netgate.com/files/firmware/memstick/pfSense-plus-memstick-21.05-RELEASE-amd64.img.gz => pfSense-plus-memstick-21.05-RELEASE-amd64.img.gz
################################################################################################################################################################################################### 100.0%
Downloading checksum pfSense-plus-memstick-21.05-RELEASE-amd64.img.gz.sha256
################################################################################################################################################################################################### 100.0%
Downloading https://partnervault.netgate.com/files/firmware/memstick/pfSense-plus-memstick-ADI-21.05-RELEASE-amd64.img.gz => pfSense-plus-memstick-ADI-21.05-RELEASE-amd64.img.gz
################################################################################################################################################################################################### 100.0%
Downloading checksum pfSense-plus-memstick-ADI-21.05-RELEASE-amd64.img.gz.sha256
################################################################################################################################################################################################### 100.0%
Downloading https://partnervault.netgate.com/files/firmware/memstick/pfSense-plus-memstick-XG-7100-21.05-RELEASE-amd64.img.gz => pfSense-plus-memstick-XG-7100-21.05-RELEASE-amd64.img.gz
################################################################################################################################################################################################### 100.0%
Downloading checksum pfSense-plus-memstick-XG-7100-21.05-RELEASE-amd64.img.gz.sha256
################################################################################################################################################################################################### 100.0%
Downloading https://partnervault.netgate.com/files/firmware/memstick/pfSense-plus-memstick-serial-21.05-RELEASE-amd64.img.gz => pfSense-plus-memstick-serial-21.05-RELEASE-amd64.img.gz
################################################################################################################################################################################################### 100.0%
Downloading checksum pfSense-plus-memstick-serial-21.05-RELEASE-amd64.img.gz.sha256
################################################################################################################################################################################################### 100.0%
Downloading https://partnervault.netgate.com/files/firmware/sg-3100/pfSense-plus-SG-3100-recover-21.05-RELEASE-armv7.img.gz => pfSense-plus-SG-3100-recover-21.05-RELEASE-armv7.img.gz
################################################################################################################################################################################################### 100.0%
Downloading checksum pfSense-plus-SG-3100-recover-21.05-RELEASE-armv7.img.gz.sha256
################################################################################################################################################################################################### 100.0%
Downloading https://partnervault.netgate.com/files/firmware/sg-2100/pfSense-plus-SG-2100-recovery-21.05-RELEASE-aarch64.img.gz => pfSense-plus-SG-2100-recovery-21.05-RELEASE-aarch64.img.gz
################################################################################################################################################################################################### 100.0%
Downloading checksum pfSense-plus-SG-2100-recovery-21.05-RELEASE-aarch64.img.gz.sha256
################################################################################################################################################################################################### 100.0%
Downloading https://partnervault.netgate.com/files/firmware/sg-1100/pfSense-plus-SG-1100-recover-21.05-RELEASE-armv7.img.gz => pfSense-plus-SG-1100-recover-21.05-RELEASE-armv7.img.gz
################################################################################################################################################################################################### 100.0%
Downloading checksum pfSense-plus-SG-1100-recover-21.05-RELEASE-armv7.img.gz.sha256
################################################################################################################################################################################################### 100.0%
Done. Have a nice day!
```

## Todo:
In theory it should be possible to allow curl to login and get its own cookies, in practice this was not done, simply because for our purpose this was suffucient. 

## Legal 
Remember that pfSense+ is licensed software and is only available if you have purchased a pfSense appliance from Netgate.
If you have not done so this script will not help you by design. 

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
