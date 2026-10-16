#!/bin/sh
set -eu
cd "$(dirname "$0")"
python3 - <<'PY'
from pathlib import Path
path = b'/var/jb/Applications/AudioRecorder.app/PlugIns/action.appex/action.dylib'
assert len(path) < 223
Path('package/var/jb/usr/share/audiorecorder-import-fix/loader-path.bin').write_bytes(path.ljust(223, b'\0'))
PY
for script in postinst prerm postrm; do
    sh -n "package/DEBIAN/$script"
    chmod 755 "package/DEBIAN/$script"
done
mkdir -p dist
version=$(sed -n 's/^Version: //p' package/DEBIAN/control)
dpkg-deb --root-owner-group -Zgzip --build package "dist/AudioRecorder-Import-Fix_${version}_iphoneos-arm64.deb"
