import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/core/services/pronunciation_service.dart';
import 'package:offline_english_bible/features/dictionary/domain/entities/dictionary_entry.dart';
import 'package:offline_english_bible/features/dictionary/presentation/providers/dictionary_providers.dart';
import 'package:offline_english_bible/features/dictionary/presentation/widgets/dictionary_bottom_sheet.dart';

void main() {
  testWidgets('shows dictionary content in app and plays pronunciation', (
    tester,
  ) async {
    final pronunciation = _FakePronunciationService();
    const entry = DictionaryEntry(
      id: 1,
      word: 'grace',
      wordNormalized: 'grace',
      ipaUs: '/ɡreɪs/',
      koreanMeaning: '은혜, 은총',
      bibleFrequency: 170,
      senses: [
        WordSense(
          id: 1,
          partOfSpeech: 'noun',
          senseOrder: 1,
          definition: 'unmerited divine favor',
          definitionKo: '값없이 베푸는 하나님의 은혜',
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          wordLookupProvider.overrideWith((ref, word) async => entry),
          pronunciationServiceProvider.overrideWithValue(pronunciation),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder:
                  (context) => TextButton(
                    onPressed:
                        () => DictionaryBottomSheet.show(context, 'grace'),
                    child: const Text('open'),
                  ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(find.text('grace'), findsOneWidget);
    expect(find.text('은혜, 은총'), findsOneWidget);
    expect(find.text('/ɡreɪs/'), findsOneWidget);
    expect(find.text('unmerited divine favor'), findsOneWidget);

    await tester.tap(find.byTooltip('발음 듣기'));
    await tester.pumpAndSettle();

    expect(pronunciation.spokenWords, ['grace']);
  });
}

final class _FakePronunciationService implements PronunciationService {
  final spokenWords = <String>[];

  @override
  Future<bool> speak(String word) async {
    spokenWords.add(word);
    return true;
  }

  @override
  Future<void> stop() async {}
}
