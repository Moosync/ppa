version=$1
EMAIL=sahilsachingupte@gmail.com

FILE="Moosync_${version}_amd64.deb"
if [ -f "$FILE" ]; then
    echo "$FILE already exists."
else
    wget "https://github.com/Moosync/Moosync/releases/download/Moosync-v${version}/Moosync_${version}_amd64.deb"
fi

# Packages & Packages.gz
.venv/bin/python dpkg-scanpackages.py --multiversion . > Packages
gzip -k -f Packages

# Release, Release.gpg & InRelease
# apt-ftparchive release . > Release
./generate_release.sh > Release
gpg --default-key "${EMAIL}" -abs -o - Release > Release.gpg
gpg --default-key "${EMAIL}" --clearsign -o - Release > InRelease
