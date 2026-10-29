# Original APK inspection

Input: the user-supplied MediaFire ShonenZ-0.1.5-arm64-PERSONAL-SIGNED.apk.
SHA-256: `edf494e7de80202a37b834d5cc9247b4f7b71e02779ecf9dd7f37f23b53e0c90`.
Tools: Android build-tools36 aapt, ZIP inspection, JADX1.5.3 resource/manifest
extraction. This was static inspection; the original APK was not run on a device.

## Observed package and architecture

- ID `io.github.heneverstopslord.shonenz`, version0.1.5/code6, minSDK24,
  target/compileSDK36, ARM64. Launcher activity is its `MainActivity`.
- Flutter AOT: `libapp.so` and `libflutter.so`. JADX does not recover the original
  Dart source or reliably reconstruct its reader/download implementation.
- Native dependencies include Isar, media_kit helper/libmpv, QuickJS/libqjs,
  rhttp and Dart JNI. An AnymeX runtime host APK is embedded in Flutter assets.
- Manifest contains Flutter web-auth callbacks, WebViews/custom tabs, local
  notification receivers, WorkManager services/receivers and Room's invalidation
  service. Presence of a transitive manifest service alone does not prove the
  app actively uses it for downloads.
- Permissions include internet, notifications, wake locks, biometrics, package
  install/delete requests and visibility, media/storage/all-files access, boot
  receivers, exact alarms and foreground services.

## Source and implementation decision

The embedded ShonenZ source references under `heneverstopsLord/ShonenZ` and
`roshancodespace/ShonenZ` returned404 during retrieval. The exact original source
and its private database contract were unavailable. The recoverable licensed
foundation is public GPL ShonenX at the revision documented in IMPLEMENTATION.md.
The original APK is retained only as an analysis input, not patched or repackaged.

Before edits, the available source was inspected for reader image handling,
page/Webtoon controllers, source adapters and matching, download lifecycle,
metadata persistence, HLS remuxing, and media_kit playback modes. Concrete source
issues included rejected manga downloads, deletion of completed anime records,
matching a first result at zero confidence, swallowed chapter errors, and local
image paths not being handled as files. Those findings justify the scoped repairs
listed in CHANGELOG.md; they do not establish that every original binary defect
has been reproduced or eliminated.

The new app preserves viable Flutter/Riverpod/Isar/mpv components. A native
foreground service supports active transfers, while app-owned storage and SAF
imports respect Android file access. Original all-files access remains an explicit
option for custom public download folders; default private folders need no such
grant. The separate ID and new key prevent accidental installation over ShonenZ.
