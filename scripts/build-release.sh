#!/usr/bin/env bash
set -euo pipefail
# Flutter 3.41.0, JDK 21; set ANDROID_HOME to your prepared SDK.
flutter pub get --enforce-lockfile
dart run build_runner build
flutter build apk --release --split-per-abi --target-platform android-arm64
