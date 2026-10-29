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
