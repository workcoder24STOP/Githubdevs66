# ShonenZ+ 0.2.1 — reader and download update

## Install this update

Download the three **ShonenZPlus-0.2.1-arm64.part001/002/003** files and
**apk/join-apk.html**. Open the HTML in a full browser, add the APK parts,
verify, save the joined APK and install it over 0.2.0. **Do not uninstall first**.
Source-code parts belong to the separate developer archive and cannot build
an APK in this joiner. See INSTALL.md for controls and signing-key backup.

## Changes

- Local and online reader images reserve layout space until decoding finishes.
  Webtoon progress updates retain scroll position; saved final pages and offline
  paginated RTL images render in focused widget tests.
- Downloaded manga opens above the shell navigation. Manga and anime title pages
  expose saved chapters/episodes independently of source availability, and local
  episode playback retains resume position and subtitle association.
- Persistent scanlator preference, group filtering/sorting, manga batch queues
  and shared manga/anime batch controls.
- Download integrity and lifecycle repairs: corrupt page recovery, empty chapter
  rejection, validated HTTP resume, writer coordination, stable proxy IDs,
  encrypted HLS retry, and serialized metadata/progress snapshots.
- The offline joiner explains source/APK mix-ups and removes individual files.

## Binary identity

- ARM64; Android API24+; targetSDK36; version **0.2.1/code2002**.
- ID `io.github.workcoder24stop.shonenzplus`; label **ShonenZ+**.
- APK size **43,520,583 bytes**, transported in three pieces (at most20MiB each).
- APK SHA-256:
  `0133b9d3f2f7b0d61aaf2cae702a607fc3f5f70acbdc81cf89e6bb95776b119d`.
- Same RSA4096/v2 signing certificate as 0.2.0, verified by apksigner36:
  `d6e4254f660c2830fd36f1349bc000650c22b1ca17b907f3872b6e23de338db6`.
- Corresponding source is in the developer source archive and on branch
  `coderabbit/shonenz-app-rebuild/e8888d33` in workcoder24STOP/Githubdevs66.
  The private signing key is excluded from every artifact.

## Verification and limits

Release compilation passed in248.3seconds. Full application analysis passed.
Seventeen focused reader, transfer, mapping, preference and extension-contract
checks passed. Two additional title-navigation checks passed; see VERIFICATION.md.
The real APK was joined offline in shared Chromium and its downloaded SHA-256
matched exactly; a wrong source piece was rejected and replaced without clearing
valid pieces. The incremental hasher matched Node crypto for12sizes/5chunk sizes.

A fresh Kagane1.6.37 search returned HTTP404, so no new live chapter transfer was
verified. Earlier real Kagane and Atsumaru results remain dated in VERIFICATION.md;
Atsumaru full-chapter download was previously blocked by CDN/proxy failures.

**This update has not been installed or tested on a responsive Android device.**
The sandbox lacks hardware virtualization and its prior software emulator showed
Android SystemUI ANRs. Clean update/startup, real-device import/background behavior
and long video playback still require phone testing. No heavy playback/codec/soak
suite was run, following the manga-focused testing request. Do not treat a
successful compiler result as complete device acceptance.

BUILD.md contains reproducible toolchain/build commands; CHANGELOG.md gives the
full change list. The licensed ShonenX foundation and dependency notices remain.
Exact original ShonenZ source was unavailable, and the separate app cannot read
the original application's private data automatically.
