# Update verification — 2026-10-30, version 0.2.1

The update uses the same application ID and private signing key as 0.2.0.
Heavy player/codec/soak testing was outside the requested manga-focused checks.

## Checks performed for this update

- Full application static analysis: no issues.
- Isar schema generation completed for added scanlator/external-ID metadata.
- Seventeen focused checks passed: local Webtoon layout and final-page resume,
  offline RTL paging, visible damaged-image errors, manga checkpoints/corrupt-page
  recovery, paused queues, empty-page rejection, anime HTTP range validation,
  encrypted HLS retry, exact title/source/release matching, scanlator preference
  persistence, and five extension catalog/matching/index contracts.
- Two additional title-navigation widget checks passed: manga opens on the
  root navigator above the shell; an anime title passes the correct saved file,
  task ID, subtitle language and resume position to the player route. The anime
  fixture tests routing only, not video decoding.
- An initial encrypted HLS check exposed an isolate closure capturing an
  unsendable HttpClient. The worker was repaired and the test passed.
- Fresh live Kagane 1.6.37 search on this turn returned an empty list with
  `HTTP error 404`. A new real chapter transfer could not be verified. The earlier
  passing Kagane result below is historical, not a current availability claim.
- Signed ARM64 release compilation passed (248.3 seconds); aapt reports version
  0.2.1/code 2002, and apksigner verified the same RSA4096/v2 certificate as 0.2.0.
- The following historical source/device results are retained as dated evidence;
  they do not establish acceptance of the new Android binary.

## Device acceptance still required

The sandbox has no hardware virtualization and its prior software emulator
became unresponsive with Android SystemUI ANRs. Version 0.2.1 has not been
installed or exercised on a responsive Android device. Verify an in-place update,
existing downloads, Webtoon scrolling, offline chapter navigation, manga/anime
batch controls, subtitle playback and background resume on your phone.
Widget and transfer checks establish specific behavior, not complete device
acceptance. Damaged or missing old downloaded images must be downloaded again.

---

## Historical 0.2.0 evidence

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
  fallback vectors passed. The final43503123byte ARM64 APK was also reconstructed offline in shared
  Chromium and its downloaded SHA-256 matched the signed build exactly.
- Original APK inspected with aapt36 and JADX1.5.3. Exact original source was
  unavailable (its embedded ShonenZ repository URLs returned404).

## Known limitations and remaining acceptance work

- Clean x64 installation passed on AndroidAPI30. Startup/reader acceptance is
  **blocked**: the first software emulator crashed with exit139; subsequent1GiB
  and2GiB configurations booted but showed Android system/SystemUI ANR dialogs.
  ADB UI snapshots timed out, including after server restart. The app launch
  command was accepted; usable startup was not established. No `/dev/kvm` is
  available. Physical ARM64 compatibility remains unverified. See RELEASE.md.
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

- Matching fallback currently runs during automatic matching across up to six
  prioritized sources. Explicit/saved mappings require manual correction if their
  source later fails; missing individual chapters do not trigger silent remapping.
  Query limits/timeouts are bounded defaults in code, not a new settings panel.
- Original history models document millisecond playback units, while an inherited
  migration writes seconds. Exact legacy playback-history migration remains an
  open compatibility issue; new offline playback uses its explicit millisecond field.
