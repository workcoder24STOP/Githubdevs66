# ShonenZ+ 0.2.2 — one reader, stronger downloads

- Replace the separate offline reader screen with the application's existing
  immersive ReaderScreen. Offline chapters use the same settings, gestures,
  Webtoon/LTR/RTL modes, page overlay and chapter menu as online reading.
- Implement a real ReaderModeOffline backed by the saved download record. Read
  local files without resolving extensions or invoking tracker/Discord requests;
  retain resume position, bookmarks and title history. Missing/empty files show
  a recoverable error. The chapter menu lists only this title's completed items.
- Correct adjacent chapter selection when an online source index is descending.
- Download manga pages in a bounded pool (three per chapter), reuse connections,
  preserve page order, serialize checkpoints and observe rate-limit delays.
  Pause interrupts stalled page bodies and retains recoverable checkpoints.
- Add explicit internal/1DM choices on the manga download sheet, plus a handoff
  action on queued/paused chapter rows. One chapter's ordered page links and
  request headers are sent using the existing Android 1DM batch integration.
- Reject empty or unsafe import identities before any storage-folder operation.
- Keep 1DM records paused until import. Associate completed images/CBZ/ZIP with
  the original chapter; reject missing pages, HTML disguised as images and
  oversized imports. Different per-page headers require the internal downloader.
- Share and close the anime engine's HTTP client correctly. Abort active HLS
  segment requests on pause or worker failure, bound worker counts, and exclude
  failed-attempt bytes from progress. Persist completion before notifications.
- Continue using the same application ID and signing key; update in place from
  0.2.0/0.2.1. This release does not guarantee faster remote hosts or that every
  possible application/device defect has been eliminated.

# ShonenZ+ 0.2.1 — readers and offline downloads

- Repair blank Webtoon pages: reserve image space while decoding, render local
  files with bounded image decoding, retain scrolling across progress updates,
  and restore the last saved page. Paginated LTR/RTL reading is preserved.
- Open downloaded manga above the navigation shell. Missing or damaged pages
  show an error and retry instead of leaving an empty reader.
- Add a downloaded-items view on both manga and anime title pages. Completed
  chapter/episode rows open local content directly, with source/item identity
  checks that keep unrelated titles and scanlator releases separate.
- Add scanlator filtering, sorting and a preferred group saved per title.
- Add manga batch downloads alongside anime batches: all/unread, chapter ranges,
  next 5/10, bounded queue processing, cancellation and failed-item retry.
- Persist queued manga before resolving pages; pause pending jobs immediately,
  wait for active writers before retry/deletion, validate cached images, and
  reject empty chapters. Preserve query parameters that identify distinct pages.
- Repair anime transfer resume validation, partial/empty-file detection, timeouts
  and pause behavior. Give each stream proxy its persisted download ID.
- Repair encrypted HLS worker messaging and retry after a remux interruption;
  retain raw segment checkpoints and reject stale segments from another playlist.
- Save offline playback into title history and keep reading/playback/bookmark
  progress in recoverable metadata sidecars with serialized writes.
- The HTML joiner lists required filenames, explains accidental source-file
  selection, and lets users remove one wrong part without clearing valid parts.
- Keep the application ID and signing certificate from 0.2.0 for in-place updates.

# ShonenZ+ 0.2.0 development release

- New application ID, RSA4096 signing key and original Z+ launcher artwork.
- Source-level GPL ShonenX foundation with vendored dependency sources; preserved
  Flutter, Riverpod, Isar and hardware-capable mpv/media_kit components.
- Protobuf extension repository URLs, including GitHub `/raw/` links and `.pb.gz`;
  malformed/truncated protobuf fails explicitly; source IDs retain64-bit precision.
- Pinned/bundled AnymeX v2.7.3 runtime and the requested Keiyoushi protobuf catalog.
- Manga source failures propagate to error states, source headers take precedence,
  chapter order is stable, and source base URLs survive preference serialization.
- Confidence-based Unicode title/alias matching, season checks, bounded alias
  queries, ten-minute cache, deduplication, and prioritized source fallback that
  verifies a nonempty chapter/episode index before persisting an automatic match.
- Title-based offline library backed by Isar: source, title, season, item IDs,
  number, status, local paths, reading position, bookmarks and playback position.
- Completed anime download rows are retained. Stable catalog identity prevents
  signed URL changes and filenames from creating duplicate or overwritten items.
- Resumable manga page downloads with temporary files, image-format checks,
  per-page checkpoints, bounded concurrency, retries, pause and recoverable states.
- Native data-sync foreground service while active downloads run. Completed
  metadata sidecars support reconstruction after a missing database row.
- Local reader support, continuous vertical or LTR/RTL paging, page bookmarks,
  history/progress persistence, missing-file errors, zoom navigation repair and
  per-page retry. Local images are decoded as files, not base64 strings.
- SAF file-picker imports: one CBZ/ZIP or naturally sorted images per chapter;
  one video with user-selected subtitle sidecars per episode; explicit title and
  number confirmation; app-owned copies, archive size limits and safe extraction.
- 1DM handoff remains available. Completed files can be explicitly associated
  with their original download entry through the title page. No private 1DM API,
  automatic folder scraping or silent title guessing is used.
- Local video resumes from saved position and exposes associated subtitle tracks;
  existing embedded subtitle selection and mpv hardware decoding are preserved.
- Offline HTML joiner verifies individual pieces and the full signed APK with
  SHA-256, rejects missing/corrupted parts, and supports file:// without Web Crypto.

- Offline next/previous downloaded chapter navigation and bookmark page jumps.
- App-owned download folders avoid broad storage requests; custom public folders
  retain the existing explicit permission flow.
- Removed the upstream checked-in upload keystore; only the new private task key
  is used for release signing.

- Complete Android-facing ShonenZ+ labels, including onboarding and security.
- Repair local metrics comparisons against stored media-type strings.
