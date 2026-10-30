# ShonenZ+ 0.2.0 — install and keep your signing key

## Install the ARM64 phone build

Requires Android7.0/API24 or newer on an ARM64 device.

1. Download `apk/join-apk.html` and all three `ShonenZPlus-0.2.0-arm64.part...` files.
2. Open the downloaded HTML file in Chrome, Firefox, or another full browser.
   Use **Add APK parts** to select the three parts together or one at a time.
   Press **Verify & join APK**, then **Save signed APK**. This works offline;
   files stay local. Renamed parts are recognized by their contents.
3. Save `ShonenZPlus-0.2.0-arm64.apk` and open it on the Android device. If Android
   asks, permit installation from the browser/file manager you selected.
4. The separate app is **ShonenZ+**, ID `io.github.workcoder24stop.shonenzplus`.
   It installs alongside the original ShonenZ. These parts are byte chunks of one
   APK, not Android split-install APKs; never try to install an individual part.

APK SHA-256:
`15fe822e8a335df32ff60eda729ae1d33a4be654854a60804ec19a696a59c81c`

Signing certificate SHA-256:
`d6e4254f660c2830fd36f1349bc000650c22b1ca17b907f3872b6e23de338db6`

If a part fails verification, clear the list and download that same part again.
If your phone cannot open the HTML in a browser or save the result, use the
offline joiner on a computer and copy the finished APK to the phone.

## Offline library and 1DM files

Open **Downloads** to reach **Offline library**. Use **Import files**, confirm the
media title, chapter/episode number and season, then choose files with Android's
file picker. Import one CBZ/ZIP per chapter, or that chapter's ordered images.
For an episode, select one video and its subtitle files. Existing episode entries
also have **Add subtitle files**. Files are copied into app-owned storage.

A 1DM handoff creates an entry that can later be associated with its completed
file. 1DM's private folders are not read automatically. Incomplete/unsupported
files must finish downloading or be converted to a supported format first.

The requested Keiyoushi protobuf repository is configured on first startup.
Install desired source extensions in Extensions settings. Consult VERIFICATION.md
for the exact Kagane/Atsumaru checks and the remaining Atsumaru download failure.

## Source and rebuild

Use the complete source archive pieces plus `source/join-source.html`, or clone:
`https://github.com/workcoder24STOP/Githubdevs66.git`

Branch: `coderabbit/shonenz-app-rebuild/e8888d33`.
Follow BUILD.md for pinned toolchain, dependencies, signing and build commands.
The new source uses the public licensed ShonenX foundation; the exact original
ShonenZ source links returned404 and could not be recovered.

## Back up the signing key privately

The release key is **not** in Git, the source archive, or these downloads. In this
coding workspace it is stored in `$HOME/.local/share/shonenz-signing/`, with a
private directory and private key/password files.

From the repository terminal run:

```sh
scripts/backup-signing-key.sh /your/private/location/shonenz-signing.enc
```

Choose a separate strong encryption passphrase and store it in a password manager.
Keep two private backup copies. Do not upload the keystore, password file, or
`android/key.properties` to a public repository or release. BUILD.md explains
restoration. Losing this key prevents signed updates to the same app installation.
