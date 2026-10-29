# Reproducible Android builds

## Toolchain

- Flutter **3.41.0** (Dart 3.11), pinned in `.fvmrc`.
- JDK **21**, Android SDK platform **36**, build-tools **36.0.0**.
- Android NDK **28.2.13676358** and **27.0.12077973** (plugins select these).
- Rust bootstrap **1.94.0**, `cargo`/`rustup` on PATH. rhttp0.18.0 CargoKit
  selects `stable`; this build used **rustc/cargo1.99.1**. Keep that toolchain
  available when reproducing this build; future stable releases can change output.
- Gradle **8.12** through the checked-in Android wrapper.
- Keep `pubspec.lock`; path dependencies are vendored with their licenses.

Install Flutter from its tag if the published SDK archive is unavailable:

```sh
git clone --depth 1 --branch 3.41.0 https://github.com/flutter/flutter.git /path/to/flutter
export PATH="/path/to/flutter/bin:$HOME/.cargo/bin:$PATH"
export JAVA_HOME=/path/to/jdk-21
export ANDROID_HOME=/path/to/android-sdk
flutter config --jdk-dir "$JAVA_HOME" --android-sdk "$ANDROID_HOME"
flutter pub get --enforce-lockfile
```

The Android SDK CLI can install the above packages. Accept its SDK licenses.
For an enterprise proxy, import your organization's trusted CA into the JDK
truststore; never disable TLS verification. The task sandbox required this repair.

## Signing and building

```sh
scripts/create-signing-key.sh  # once, not for subsequent releases
scripts/build-release.sh
```

`android/key.properties` and the private key are excluded from Git and source
archives. The key is generated as RSA4096 with a random password stored in a
private directory. For this task that directory is
`$HOME/.local/share/shonenz-signing/` (0700; key/password 0600).

The release package is `io.github.workcoder24stop.shonenzplus`, version0.2.0 (base version code1; ARM64 split2001, x64 split4001).
The launcher is ShonenZ+. It installs alongside ShonenZ and cannot update the
original app because both application ID and signature differ.

Build one ABI at a time on small machines. Gradle is constrained to one worker
and 1.5GiB heap. The initial simultaneous ARM64/x64 build with the original
Gradle settings exhausted this sandbox. With the current one-worker settings,
the final combined build also succeeded using `CARGO_BUILD_JOBS=2`.

```sh
flutter build apk --release --split-per-abi --target-platform android-arm64
# Optional emulator/test variant:
flutter build apk --release --split-per-abi --target-platform android-x64
```

Outputs: `build/app/outputs/flutter-apk/`. Verify signatures with
`$ANDROID_HOME/build-tools/36.0.0/apksigner verify --verbose --print-certs APK`.
Create transport pieces with:

```sh
python3 scripts/package-release.py /path/ShonenZPlus-0.2.0-arm64.apk /path/release
```

A new key makes a different signature. Reproducing the install identity requires
the original key; normal builds can differ byte-for-byte due to build metadata.

## Signing backup

Run `scripts/backup-signing-key.sh /secure/location/shonenz-signing.enc` in an
interactive terminal. Choose a separate strong encryption passphrase. Keep that
passphrase in a password manager and keep two private backup copies. Never commit
the key, passwords, or `android/key.properties`, or attach them to a public release.
To restore, decrypt with `openssl enc -d -aes-256-cbc -pbkdf2 -iter 600000`, then
extract into a private directory and recreate `android/key.properties` using those
same credentials. Losing the key prevents signed updates to this application ID.

## Runtime and tracking

The APK bundles AnymeX runtime host **v2.7.3**. It is loaded inside the app and
does not require a separate first-run download. Its source is available at
https://github.com/RyanYuuki/AnymeXExtensionRuntimeBridge/tree/v2.7.3 .
The matching desktop runtime was used for source verification. Upstream source
and all notices are retained in vendored packages.

Tracker OAuth credentials are not embedded. Configure your own supported client
credentials using the existing tracker settings/build configuration when needed.
Local reading/downloads and extension browsing do not require tracker sign-in.
The independent app uses its own release repository; upstream remote config is
opt-in through `SHONENZ_CONFIG_URL`.
