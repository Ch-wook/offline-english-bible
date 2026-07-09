// lib/features/dictionary/domain/services/dictionary_query_normalizer.dart

/// Normalizes tapped Bible tokens before dictionary lookup.
final class DictionaryQueryNormalizer {
  const DictionaryQueryNormalizer();

  String normalize(String value) {
    final cleaned =
        value
            .trim()
            .replaceAll('\u2018', "'")
            .replaceAll('\u2019', "'")
            .replaceAll(RegExp(r"^[^A-Za-z']+|[^A-Za-z']+$"), '')
            .toLowerCase();

    if (cleaned.endsWith("'s") && cleaned.length > 2) {
      return cleaned.substring(0, cleaned.length - 2);
    }

    return cleaned.replaceAll(RegExp(r"[^a-z']"), '');
  }
}
