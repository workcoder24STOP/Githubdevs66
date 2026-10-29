#!/usr/bin/env bash
set -euo pipefail
signing_dir="${SHONENZ_SIGNING_DIR:-$HOME/.local/share/shonenz-signing}"
backup_file="${1:?Usage: scripts/backup-signing-key.sh /secure/path/shonenz-signing.enc}"
if test -e "$backup_file"; then echo 'Refusing to overwrite an existing backup.' >&2; exit 1; fi
test -f "$signing_dir/release.jks"
test -f "$signing_dir/password"
umask 077
# OpenSSL prompts privately for a separate backup passphrase.
tar -C "$signing_dir" -czf - release.jks password |
  openssl enc -aes-256-cbc -salt -pbkdf2 -iter 600000 -out "$backup_file"
echo 'Encrypted signing backup created. Store the passphrase separately.'
