# Verification status — 2026-10-29

This is a development build, not a claim that every item in the master prompt has
been proven on an Android device. Heavy playback/soak/regression testing was not
performed, following the user's instruction to focus on manga extensions.

## Manga sources tested with real extensions

The live Keiyoushi `index.pb` contained **1,438** extension packages. The obsolete
JSON index returned only update notices; it is not a source catalog anymore.
Tests used the published **AnymeX v2.7.3 desktop runtime**, actual extension JARs
from that protobuf catalog, real searches, chapter lists and page responses.
This establishes runtime behavior on Linux; Android integration requires its own
installation/device checks.

| Source | Artifact | Verified | Remaining issue |
|---|---|---|---|
| Kagane English | 1.6.37; ID4024736764982024684 | Loaded; real search32 results; sample14 unique chapters; stable IDs across refresh; chapter9 pages; all9 downloaded through the extension proxy (2,739,490bytes). JPEG XL URL was converted by the runtime to a decodable JPEG. | One earlier detail request timed out while the sandbox was under memory pressure. Other titles/languages are not comprehensively tested. |
| Atsumaru English | 1.6.25; ID2327480808438768017 | Loaded; initial real search16 results;1,196 unique chapters with stable IDs on later refresh;57 page URLs; first WebP successfully retrieved through proxy (291,556bytes). | Later search timed out; full-chapter proxy attempt returned HTTP500/timeouts. Direct CDN download returned403. **Full chapter download is not verified.** |

Only these two extensions were individually exercised. Other available Mihon,
Aniyomi and bridge engines are inherited capabilities, not verified support claims.
Catalog enumeration is not evidence that every extension works.

## Focused checks

- Five manga checks passed: supplied repository URL normalization; parsing the
  real catalog with exact64-bit IDs; rejecting truncated protobuf; Unicode/season
  matching; natural imported page ordering.
- Isar schema generation completed.
- Full application analysis (`flutter analyze --no-pub lib`) completed with
  **no issues** after repairing the inherited string/enum metrics comparisons
  and updating deprecated tracker color calls.
- Browser joiner verified in the shared cloud Chromium Preview with networking
  disabled. It reconstructed a verification fixture byte-for-byte, rejected
  missing/corrupted pieces, and succeeded with Web Crypto disabled. Six SHA-256
  fallback vectors passed. Final APK reconstruction is checked separately at packaging.
- Original APK inspected with aapt36 and JADX1.5.3. Exact original source was
  unavailable (its embedded ShonenZ repository URLs returned404).

## Known limitations and remaining acceptance work

- Android installation/startup and physical ARM64 compatibility require a working
  device. The first software emulator attempt crashed with exit139 before boot;
  this sandbox has no `/dev/kvm`. Final build/device results are recorded in the
  delivered release report, rather than inferred from these source checks.
- No extended mpv playback, codec matrix, seek/audio-sync, battery, or memory-soak
  verification was performed. Existing hardware decoding and codec handling are
  preserved; local position and subtitle association were repaired. This is not
  evidence that all historic player glitches have been eliminated.
- SAF imports, archive handling, offline paging/Webtoon, notification/background
  behavior, matching fallback, source-specific headers and lifecycle behavior
  need Android device acceptance. Implemented paths must not be confused with
  tested device behavior.
- 1DM integration uses external handoff plus explicit user-authorized import.
  There is no documented completion API or automatic access to 1DM's private
  files. Import is per chapter/episode, with title/number confirmation. Videos
  are not re-encoded; sidecars remain selectable, and existing HLS remuxing remains.
- The foreground service assists transfers while the activity/Flutter engine
  remains alive. Force-stop, process death, Android data-sync service time limits
  and reboot require reopening the app to resume checkpoints; there is no promise
  of downloading after force-stop. Expired anime stream URLs may require selecting
  a fresh stream from the source again.
- Completed sidecars recover download metadata after missing DB rows; they are
  not a full backup of reading history, tracker credentials or settings. Imported
  files reside in app-owned storage and are removed by uninstalling the app.
- A new app ID/signature cannot directly read the original app's private data.
  Use user-exported backups where compatible. Exact original-schema migration
  cannot be guaranteed without its source/database specification.
- Local history/bookmarks persist. Tracker synchronization of imported media is
  not automatic; imports have no proven tracker identity. Tracker OAuth requires
  user-configured client credentials. No credentials/signing secrets are shipped
  in source archives or reports.
- Extension failures are caught at the adapter/runtime boundary. Dynamically
  loaded Android extension native code is not a separate security sandbox; a
  fatal native failure may still terminate the process.
