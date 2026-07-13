import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

Map<String, String> readStarDict(String directoryPath) {
  final directory = Directory(directoryPath);
  if (!directory.existsSync()) {
    throw ArgumentError('StarDict 디렉터리를 찾을 수 없습니다: $directoryPath');
  }
  final files = directory.listSync().whereType<File>().toList();
  final indexFile = files
      .where((file) => file.path.endsWith('.idx'))
      .firstOrNull;
  final dictFile = files
      .where(
        (file) => file.path.endsWith('.dict') || file.path.endsWith('.dict.dz'),
      )
      .firstOrNull;
  if (indexFile == null || dictFile == null) {
    throw StateError('StarDict .idx/.dict 파일이 필요합니다: $directoryPath');
  }

  final indexBytes = indexFile.readAsBytesSync();
  final compressedDictionary = dictFile.readAsBytesSync();
  final dictionaryBytes = dictFile.path.endsWith('.dz')
      ? Uint8List.fromList(gzip.decode(compressedDictionary))
      : compressedDictionary;
  final indexData = ByteData.sublistView(indexBytes);
  final result = <String, String>{};
  var cursor = 0;

  while (cursor < indexBytes.length) {
    final wordEnd = indexBytes.indexOf(0, cursor);
    if (wordEnd < 0 || wordEnd + 9 > indexBytes.length) break;
    final word = utf8
        .decode(indexBytes.sublist(cursor, wordEnd), allowMalformed: true)
        .trim()
        .toLowerCase();
    cursor = wordEnd + 1;
    final offset = indexData.getUint32(cursor, Endian.big);
    final size = indexData.getUint32(cursor + 4, Endian.big);
    cursor += 8;
    if (word.isEmpty || offset + size > dictionaryBytes.length) continue;

    final definition = _cleanDefinition(
      utf8.decode(
        dictionaryBytes.sublist(offset, offset + size),
        allowMalformed: true,
      ),
    );
    if (definition.isNotEmpty && RegExp(r'[가-힣]').hasMatch(definition)) {
      result.putIfAbsent(word, () => definition);
    }
  }
  return result;
}

String _cleanDefinition(String value) {
  final cleaned = value
      .replaceAll(RegExp(r'<[^>]+>'), ' ')
      .replaceAll('&lt;', '<')
      .replaceAll('&gt;', '>')
      .replaceAll('&amp;', '&')
      .replaceAll('&quot;', '"')
      .replaceAll(RegExp(r'[\u0000-\u0008\u000B\u000C\u000E-\u001F]'), ' ')
      .replaceAll(RegExp(r'\s+'), ' ')
      .trim();
  final firstKorean = RegExp(r'[가-힣]').firstMatch(cleaned)?.start;
  if (firstKorean != null && firstKorean > 0 && firstKorean <= 48) {
    return cleaned.substring(firstKorean).trim();
  }
  return cleaned;
}
