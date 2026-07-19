/// Cleans imported dictionary text for compact, Korean-first display.
abstract final class DictionaryMeaningFormatter {
  static const defaultMaxLength = 180;

  static final RegExp _hangul = RegExp(r'[가-힣]');
  static final RegExp _whitespace = RegExp(r'\s+');
  static final RegExp _leadingPunctuation = RegExp(r'^[\s,;:.]+');
  static final RegExp _trailingPunctuation = RegExp(r'[\s,;:]+$');

  static bool containsKorean(String value) => _hangul.hasMatch(value);

  static String format(String value, {int maxLength = defaultMaxLength}) {
    if (maxLength < 2) {
      throw ArgumentError.value(maxLength, 'maxLength', 'must be at least 2');
    }

    final normalized = value.replaceAll(_whitespace, ' ').trim();
    if (normalized.isEmpty) return '';

    final withoutEnglishNotes = _removeEnglishOnlyParentheticals(normalized);
    final pieces = _splitMeaningPieces(withoutEnglishNotes);
    final selected = <String>[];
    final seen = <String>{};
    var wasTruncated = false;

    for (final rawPiece in pieces) {
      final piece =
          rawPiece
              .replaceFirst(_leadingPunctuation, '')
              .replaceFirst(_trailingPunctuation, '')
              .trim();
      if (piece.isEmpty ||
          !containsKorean(piece) ||
          _isImportedSourceNoise(piece)) {
        continue;
      }

      final identity = piece.toLowerCase().replaceAll(
        RegExp(r'[\s,;:.()\[\]{}]+'),
        '',
      );
      if (identity.isEmpty || !seen.add(identity)) continue;

      final candidate = [...selected, piece].join(', ');
      if (candidate.length <= maxLength) {
        selected.add(piece);
        continue;
      }

      if (selected.isEmpty) {
        selected.add(_truncate(piece, maxLength));
      }
      wasTruncated = true;
      break;
    }

    if (selected.isEmpty) return '';

    var result = selected.join(', ');
    if (wasTruncated && !result.endsWith('…')) {
      if (result.length >= maxLength) {
        result = result.substring(0, maxLength - 1).trimRight();
      }
      result = '$result…';
    }
    return result;
  }

  static String _removeEnglishOnlyParentheticals(String value) {
    final output = StringBuffer();
    var index = 0;

    while (index < value.length) {
      if (value[index] != '(') {
        output.write(value[index]);
        index++;
        continue;
      }

      var depth = 0;
      var closingIndex = -1;
      for (var cursor = index; cursor < value.length; cursor++) {
        if (value[cursor] == '(') depth++;
        if (value[cursor] == ')') {
          depth--;
          if (depth == 0) {
            closingIndex = cursor;
            break;
          }
        }
      }

      if (closingIndex == -1) {
        output.write(value.substring(index));
        break;
      }

      final group = value.substring(index, closingIndex + 1);
      final content = group.substring(1, group.length - 1);
      final isEnglishNote =
          !containsKorean(content) && RegExp(r'[A-Za-z]').hasMatch(content);
      if (!isEnglishNote) output.write(group);
      index = closingIndex + 1;
    }

    return output.toString().replaceAll(_whitespace, ' ').trim();
  }

  static List<String> _splitMeaningPieces(String value) {
    final pieces = <String>[];
    final current = StringBuffer();
    var parenthesisDepth = 0;

    for (var index = 0; index < value.length; index++) {
      final character = value[index];
      if (character == '(') parenthesisDepth++;
      if (character == ')' && parenthesisDepth > 0) parenthesisDepth--;

      final isSeparator =
          parenthesisDepth == 0 && (character == ',' || character == ';');
      if (isSeparator) {
        pieces.add(current.toString());
        current.clear();
      } else {
        current.write(character);
      }
    }

    pieces.add(current.toString());
    return pieces;
  }

  static bool _isImportedSourceNoise(String value) {
    final normalized = value.toLowerCase();
    return normalized.contains('learning english') ||
        normalized.contains('public domain') ||
        normalized.contains('wiktionary') ||
        normalized.contains('음성 듣기') ||
        normalized.contains('발음 듣기');
  }

  static String _truncate(String value, int maxLength) {
    if (value.length <= maxLength) return value;

    final limit = maxLength - 1;
    final prefix = value.substring(0, limit);
    final lastBoundary = prefix.lastIndexOf(RegExp(r'[.!?。]'));
    final shortened =
        lastBoundary >= limit ~/ 2
            ? prefix.substring(0, lastBoundary + 1)
            : prefix;
    return '${shortened.trimRight()}…';
  }
}
