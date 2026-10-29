#!/usr/bin/env bash
set -euo pipefail
# Run once. Signing material remains outside the source checkout.
signing_dir="${SHONENZ_SIGNING_DIR:-$HOME/.local/share/shonenz-signing}"
mkdir -p "$signing_dir"
chmod 700 "$signing_dir"
if test -e "$signing_dir/release.jks"; then
  echo 'Signing key already exists; refusing to replace it.' >&2
  exit 1
fi
umask 077
openssl rand -hex 32 > "$signing_dir/password"
keytool -genkeypair -noprompt -keystore "$signing_dir/release.jks" -storetype JKS \
  -alias shonenzplus -keyalg RSA -keysize 4096 -validity 10000 \
  -storepass:file "$signing_dir/password" -keypass:file "$signing_dir/password" \
  -dname 'CN=ShonenZ Plus, OU=Independent Android Release'
python3 - "$signing_dir" <<'PY'
import sys,pathlib
s=pathlib.Path(sys.argv[1]).resolve()
password=(s/'password').read_text().strip()
p=pathlib.Path('android/key.properties')
p.write_text(f'storeFile={s}/release.jks\nstorePassword={password}\nkeyPassword={password}\nkeyAlias=shonenzplus\n')
p.chmod(0o600)
PY
echo 'Signing configuration created. Back up the private directory securely.'
