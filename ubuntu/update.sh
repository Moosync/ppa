version=$1
EMAIL=sahilsachingupte@gmail.com
wget "https://github.com/Moosync/Moosync/releases/download/v${version}/Moosync-${version}-linux-amd64.deb"

# Packages & Packages.gz
dpkg-scanpackages --multiversion . > Packages
gzip -k -f Packages

# Release, Release.gpg & InRelease
apt-ftparchive release . > Release
gpg --default-key "${EMAIL}" -abs -o - Release > Release.gpg
gpg --default-key "${EMAIL}" --clearsign -o - Release > InRelease
