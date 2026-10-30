import 'dart:convert';
import 'dart:io';

bool isSupportedImageHeader(List<int> b) =>
    b.length >= 12 &&
    ((b[0] == 0xff && b[1] == 0xd8) ||
        (b[0] == 137 &&
            b[1] == 80 &&
            b[2] == 78 &&
            b[3] == 71 &&
            b[4] == 13 &&
            b[5] == 10 &&
            b[6] == 26 &&
            b[7] == 10) ||
        ascii.decode(b.take(6).toList(), allowInvalid: true) == 'GIF87a' ||
        ascii.decode(b.take(6).toList(), allowInvalid: true) == 'GIF89a' ||
        (ascii.decode(b.take(4).toList(), allowInvalid: true) == 'RIFF' &&
            ascii.decode(b.sublist(8, 12), allowInvalid: true) == 'WEBP') ||
        ascii.decode(b.sublist(4, 12), allowInvalid: true) == 'ftypavif');

Future<bool> isSupportedImageFile(File file) async {
  final handle = await file.open();
  try {
    return isSupportedImageHeader(await handle.read(16));
  } finally {
    await handle.close();
  }
}
