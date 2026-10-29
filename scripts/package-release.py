#!/usr/bin/env python3
"""Split a signed APK into transport parts and emit a self-contained joiner."""
import argparse,hashlib,json,pathlib
parser=argparse.ArgumentParser()
parser.add_argument('apk',type=pathlib.Path)
parser.add_argument('destination',type=pathlib.Path)
parser.add_argument('--kind', choices=['apk', 'source'], default='apk')
args=parser.parse_args()
out=args.destination;out.mkdir(parents=True,exist_ok=True)
b=args.apk.read_bytes();size=20*1024*1024
parts=[]
for i,start in enumerate(range(0,len(b),size),1):
    chunk=b[start:start+size];name=f'{args.apk.stem}.part{i:03d}'
    (out/name).write_bytes(chunk)
    parts.append({'name':name,'size':len(chunk),'sha256':hashlib.sha256(chunk).hexdigest()})
manifest={'filename':args.apk.name,'size':len(b),'sha256':hashlib.sha256(b).hexdigest(),'parts':parts}
manifest['mime'] = 'application/zip' if args.kind == 'source' else 'application/vnd.android.package-archive'
(out/'manifest.json').write_text(json.dumps(manifest,indent=2)+'\n')
template=pathlib.Path(__file__).with_name('joiner-template.html').read_text()
if args.kind == 'source':
    template = template.replace('APK', 'source archive').replace('signed release', 'source package').replace('signed source archive', 'source archive').replace('then open it on your Android device', 'then extract it on your computer').replace('These are pieces of one source archive, not Android split-install packages.', 'These are pieces of the complete project source archive.')
(out/('join-source.html' if args.kind == 'source' else 'join-apk.html')).write_text(template.replace('__MANIFEST__',json.dumps(manifest).replace('<','\\u003c')))
print(f'{len(parts)} parts; {len(b)} bytes; SHA-256 {manifest["sha256"]}')
