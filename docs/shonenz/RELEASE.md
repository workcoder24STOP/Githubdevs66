# ShonenZ+ 0.2.0 development release

This is a compiled and newly signed source rebuild. It is **not a declaration
that the entire master-prompt acceptance checklist passed**. See VERIFICATION.md
for implemented paths, observed checks, and remaining issues.

## Artifacts

- Phone APK: ARM64,43,503,123bytes, delivered in three byte chunks with an offline
  HTML joiner. Android7.0/API24+, targetSDK36, versionCode2001.
- ID: `io.github.workcoder24stop.shonenzplus`; label **ShonenZ+**.
- APK SHA-256: `15fe822e8a335df32ff60eda729ae1d33a4be654854a60804ec19a696a59c81c`.
- Certificate SHA-256: `d6e4254f660c2830fd36f1349bc000650c22b1ca17b907f3872b6e23de338db6`.
- Signature verified with apksigner36: APK Signature Scheme v2, RSA4096. The
  original APK has a different certificate. The new key stays private.
- Corresponding application code:
  `8a1e051f5043e6e76e4b05b56e9a76f6c56f123f` on branch
  `coderabbit/shonenz-app-rebuild/e8888d33` in workcoder24STOP/Githubdevs66.
  Later source commits update documentation and release tools; the application
  code remains unchanged.

## Observed checks

- ARM64 and x64 release builds passed,423.2seconds for the final combined build.
- Full application analyzer: no issues. Five focused manga contract tests passed.
- Shared cloud Chromium opened the offline joiner from a local file, accepted
  the APK parts one at a time (including a renamed part), and rebuilt the actual
  APK with networking disabled. The downloaded APK matched the signed binary's
  SHA-256. Missing and corrupted parts were rejected. Physical Android browser
  testing has not been performed.
- Kagane1.6.37: real search, stable chapter IDs and complete9-page download through
  the published AnymeX2.7.3 desktop runtime passed.
- Atsumaru1.6.25: real search,1,196-chapter index and first image passed initially;
  subsequent full-chapter attempts failed with proxy500/timeouts/CDN403.
- Clean installation of the signed x64 build passed on AndroidAPI30. Device UI
  acceptance is recorded below; emulator installation does not establish ARM64
  physical-device compatibility.

## Device result

**Installation passed; startup and offline-reader acceptance remain blocked.**
The first software emulator crashed before boot. A1GiB/one-core retry booted and
installed the signed x64 APK, but launch reached the splash screen behind Android's
“Process system isn't responding” dialog. A2GiB/two-core retry also booted; its
launch screenshot showed “System UI isn't responding.” Interactive snapshots
repeatedly timed out even after restarting adb. This sandbox has no `/dev/kvm`.

The app launch command was accepted, which is not proof of usable startup. The
synthetic CBZ was copied to the emulator but could not be imported/read through a
responsive UI. Paginated/Webtoon/offline reader, progress and import acceptance
are therefore **unverified**, not passed. See device-startup-blocker.png. Test the
ARM64 APK on a real device before treating this development build as stable.

## Remaining scope

Heavy playback, codec, battery and regression/soak tests were omitted following
the request to focus on manga. Anime transfers,1DM workflows/subtitles and
background recovery still require device acceptance. Extensions other than the
named two have not been individually verified. The source implements these flows;
compilation alone is not proof they are fully functional.

Exact original ShonenZ source links returned404. This rebuild uses the licensed,
pinned public ShonenX foundation, with its notices and available dependencies.
Original private app data cannot be directly accessed through the new app ID.
See APK_ANALYSIS.md, CHANGELOG.md, BUILD.md and INSTALL.md for details.
