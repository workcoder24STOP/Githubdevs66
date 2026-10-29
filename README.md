# ShonenZ+

An independent Android source rebuild of the GPL ShonenX foundation, focused on
manga extensions and a title-based offline library. New Android ID:
`io.github.workcoder24stop.shonenzplus`.

The original ShonenZ0.1.5 APK was inspected with aapt/JADX. Its source links were
unavailable. This project therefore uses pinned, licensed ShonenX source; it is
not an exact recovery of the original APK and is not a binary reskin.

- [Release results and device blocker](docs/shonenz/RELEASE.md)
- [Original APK inspection](docs/shonenz/APK_ANALYSIS.md)
- [Build, sign and back up the key](docs/shonenz/BUILD.md)
- [Changes](docs/shonenz/CHANGELOG.md)
- [Verification and limitations](docs/shonenz/VERIFICATION.md)
- [Architecture and source provenance](docs/shonenz/IMPLEMENTATION.md)

The app includes no media. Sources are user-managed extensions. The supplied
Keiyoushi protobuf catalog is configured on first startup. Import only files you
are authorized to use; Android's file picker grants access to selected files.

## Credits and source licensing

Based on [ShonenX by Roshan Kumar and contributors](https://github.com/roshancodespace/shonenx),
revision `a0dd5fb5afe07dc2c4109c96be31a53eee5da228`, GPL-3.0 (see LICENSE).
AnymeXExtensionRuntimeBridge is by RyanYuuki and contributors, with the retained
UPL/GPL terms in `packages/anymex_extension_bridge/LICENSE`. Other package notices
remain in their respective source directories. Changes for ShonenZ+ are documented
above. Publish the corresponding source alongside any distributed binaries.
