# AudioRecorderXS Import Fix

Fixes the **Import to AudioRecorder** share-action crash in AudioRecorder XS **5.0-62** on rootless jailbreaks.

The import extension loads its handler from `/Applications/...`, but the rootless package installs it under `/var/jb/Applications/...`. This repair corrects that path and re-signs the extension with its existing entitlements. Removing the fix restores the original executable.

## Install

Download the DEB from [Releases](https://github.com/551UK/AudioRecorderXS-Import-Fix/releases/latest), install with Sileo or Filza, then **respring** and retry the import. Keep AudioRecorder installed. Dependencies: `ldid` and `coreutils`.

Designed for the supplied rootless 5.0-62 executable; the installer checks its SHA-256 before changing anything. Remove this fix before updating AudioRecorder. No recordings or preferences are changed.

## Source and build

This is an install-time repair package, not an injected dylib. The complete repair source is in `package/DEBIAN/postinst`, with restoration in `prerm` and cleanup in `postrm`. `build.sh` generates the replacement path and packages the DEB.

On Linux with Python 3 and `dpkg-deb`:

```sh
./build.sh
```

The DEB is written to `dist/`. The release workflow publishes each new package version from main.

Static checks passed; successful importing on a device has not yet been confirmed.

By **551UK**.
