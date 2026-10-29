# ShonenZ+ source rebuild

The connected repository was empty. The original APK is Flutter AOT, package
io.github.heneverstopslord.shonenz, v0.1.5 (6), min24/target36, ARM64.
JADX 1.5.3 extracted manifest/resources; aapt36 inspected package/permissions.
Its ShonenZ source URLs returned 404. This is a source-level GPL ShonenX fork,
not an exact recovery of the original Dart source or a binary reskin.

Foundation: https://github.com/roshancodespace/shonenx at
 a0dd5fb5afe07dc2c4109c96be31a53eee5da228.
Vendored dependencies and original revisions:
- AnymeXExtensionRuntimeBridge: 9becf38dcb649c50d281a2259df9b6eb27cef0f3
- byte_me: a582800251b13669a3a59f9da5cb4ffb6ad689ac
- commentum_client: fc2a7c2e0940e8e494a1a7b1c747ec841e19d46b
- flutter_web_auth: 84b9e7700ae1dffd9856d5d8e2c9dc9657946cae
See each package's LICENSE. Unavailable inbuilt source submodule is unused by
upstream's empty built-in providers. Extensions remain user managed.

## Contract changes

Keep Flutter/Riverpod/Isar/mpv and replace defective behavior at source level.
Upstream returned the first search result even with score zero; the new matcher
requires confidence and distinguishes seasons, leaving ambiguity for manual choice.
Upstream explicitly rejected manga downloads and deleted completed anime records;
the new implementation persists title/source/item identities and local chapter pages.
New app ID/signing key create an independent Android sandbox. Existing app data
must be exported by the user, never accessed by bypassing Android permissions.
Upstream remotely controlled config/updates are disabled by default for this fork.

## Stages

1. Analyze APK and source contracts; establish build/toolchain.
2. Repair repository URLs/protobuf, chapter errors/headers/IDs, matching.
3. Implement persistent title-based downloads, offline reader and SAF imports.
4. Repair local playback resume and sidecar subtitle selection.
5. Compile/sign; focused manga extension verification and bounded device startup.
6. Split APK and offline integrity-checking joiner; source and release report.
