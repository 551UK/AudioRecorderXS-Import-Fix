AudioRecorder Import Fix 1.0.0 — 551UK
For the supplied AudioRecorder XS rootless 5.0-62 on Dopamine.

Install this DEB in Sileo/Filza, allow installation of ldid if requested,
then respring and retry Share > Import to AudioRecorder.
Remove this package to restore the original extension, then respring.

Diagnosis: action's ActionRequestHandler init calls dlopen with a hardcoded
/Applications/.../action.dylib path. The package installs that library under
/var/jb/Applications instead. Its init then instantiates ActionRequestHandler_lib;
if the library was not loaded, this produces nil. The supplied crash records
ExtensionFoundation inserting that nil principal object into a dictionary.
The handler library is absent from the crash's loaded-image list.

Repair: replace only the 223-byte path string at file offset 0x7cf4 (31988),
zero-padding the shorter rootless path. File layout and executable instructions
are unchanged. Re-sign on-device using ldid and the original entitlements.
The original hash is checked before any patch; uninstall restores the backed-up
original only if the installed executable still matches our signed result.
No recordings, preferences, licensing code, or other extensions are modified.
No diagnostic logging is installed. Installer scripts are the complete source
of the repair and are available via dpkg-deb -e on this DEB.

Validation: original initializer and path inspected; byte-range and shell syntax
checks performed. Actual signing and audio import require testing on the phone.
This fixes the identified loader defect; later import errors are not ruled out.
Remove the repair before upgrading AudioRecorder to another release.
