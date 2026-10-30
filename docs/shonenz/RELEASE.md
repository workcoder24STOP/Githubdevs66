# ShonenZ+ 0.2.2 — unified reader and download update

## What changed

Downloaded chapters now open in **the same ReaderScreen used for online manga**.
The simplified separate offline screen was removed. You retain the app's reader
settings, immersive layout, gestures, chapter menu, Webtoon/LTR/RTL modes, resume
position and bookmarks. Offline mode discovers local chapters and does not
resolve extensions or send tracker/Discord requests.

Manga pages use a bounded pool with ordered output, checkpoints, pause/retry and
rate-limit handling. Anime uses a shared HTTP pool, aborts stalled HLS requests
on pause/failure, and saves completion independently of notification permission.
Speeds depend on the source and connection; no remote-host speed guarantee is made.

The manga download sheet now offers **Download chapter** and **Send chapter to
1DM**. The existing Android batch-intent path passes ordered pages and uniform
request headers. Import all completed images, or a CBZ/ZIP, back into the same
chapter. Incomplete/damaged imports are rejected and handoffs remain paused until
import. Sources needing different per-page headers use the internal downloader.

## Download and install

Get all three **ShonenZPlus-0.2.2-arm64.part001/002/003** files and
**apk/join-apk.html**. Open the HTML in a full browser, verify the APK parts,
save the joined APK and install it over 0.2.0 or 0.2.1. **Do not uninstall first.**
Source pieces belong to the separate developer ZIP, not the APK joiner.

- Android API24+; ARM64; targetSDK36; version0.2.2/code2003.
- Application ID: `io.github.workcoder24stop.shonenzplus`.
- APK SHA-256: `25ab1d7eae42b02a34a97284e9246ddb663e6768aeca360fdbeae7e8ad9bbb4a`.
- APK size: 43530251 bytes.
- Same RSA4096/v2 certificate as0.2.0/0.2.1:
  `d6e4254f660c2830fd36f1349bc000650c22b1ca17b907f3872b6e23de338db6`.
- Complete corresponding source is supplied in the developer archive and branch
  `coderabbit/shonenz-app-rebuild/e8888d33` in workcoder24STOP/Githubdevs66.
  Private signing material is excluded. INSTALL.md explains private key backup.

## Checks and limits

30 focused reader, routing, download and import checks passed across the selected runs.
Affected Dart/Flutter analysis passed. The final frozen-input ARM64 release build
completed in356.0s; APK v2 signature verification passed with the retained release
certificate. Offline joiner transport results are recorded in the delivery report.

**Android device acceptance and installed 1DM operation remain unverified.**
The sandbox has no responsive device and previous software emulators showed
Android SystemUI ANRs. A fresh Kagane search still returnsHTTP404; Atsumaru's
previous full-chapter CDN/proxy failure remains unresolved. See VERIFICATION.md
for current checks, historical evidence and remaining acceptance.

This release repairs the identified reader/download defects; it is not a claim
that every possible app, extension or device bug has been eliminated. BUILD.md
contains reproducible build commands and CHANGELOG.md gives implementation detail.
The licensed ShonenX foundation and dependency notices remain in the full source.
