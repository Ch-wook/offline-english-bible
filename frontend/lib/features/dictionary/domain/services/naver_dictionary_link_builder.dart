// lib/features/dictionary/domain/services/naver_dictionary_link_builder.dart

/// Builds links to Naver English Dictionary search results.
final class NaverDictionaryLinkBuilder {
  const NaverDictionaryLinkBuilder();

  static const String _baseUrl = 'https://en.dict.naver.com/#/search?query=';

  Uri buildSearchUri(String word) {
    final query = normalizeQuery(word);
    if (query.isEmpty) {
      throw ArgumentError.value(word, 'word', 'Word must not be empty.');
    }

    final encodedQuery = Uri.encodeComponent(
      query,
    ).replaceAll(String.fromCharCode(39), '%27');
    return Uri.parse('$_baseUrl$encodedQuery');
  }

  String normalizeQuery(String word) {
    return word
        .trim()
        .replaceAll('\u2018', "'")
        .replaceAll('\u2019', "'")
        .replaceAll(RegExp(r'^[^A-Za-z]+|[^A-Za-z]+$'), '');
  }
}
