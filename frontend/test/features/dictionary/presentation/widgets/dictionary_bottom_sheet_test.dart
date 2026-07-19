import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/core/services/pronunciation_service.dart';
import 'package:offline_english_bible/features/dictionary/domain/entities/dictionary_entry.dart';
import 'package:offline_english_bible/features/dictionary/presentation/providers/dictionary_providers.dart';
import 'package:offline_english_bible/features/dictionary/presentation/widgets/dictionary_bottom_sheet.dart';
import 'package:offline_english_bible/features/vocabulary/presentation/providers/vocabulary_providers.dart';

void main() {
  testWidgets('shows dictionary content in app and plays pronunciation', (
    tester,
  ) async {
    final pronunciation = _FakePronunciationService();
    final savedWords = <String>[];
    const entry = DictionaryEntry(
      id: 1,
      word: 'grace',
      wordNormalized: 'grace',
      ipaUs: '/ɡreɪs/',
      koreanMeaning: '은혜, 은총',
      bibleFrequency: 170,
      synonyms: ['favor'],
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
          isWordSavedProvider.overrideWith((ref, word) async => false),
          addVocabWordProvider.overrideWithValue(({
            required word,
            required bookId,
            required chapter,
            required verse,
            required translationCode,
            required definition,
            required partOfSpeech,
            required ipa,
            required bibleDefinition,
          }) async {
            savedWords.add(word);
          }),
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
    expect(find.text('은혜'), findsOneWidget);
    expect(find.text('성경 문맥 뜻'), findsOneWidget);
    expect(find.text('/ɡreɪs/'), findsOneWidget);
    expect(find.text('unmerited divine favor'), findsNothing);
    final synonymChip = tester.widget<ActionChip>(
      find.widgetWithText(ActionChip, 'favor'),
    );
    expect(
      synonymChip.labelStyle?.color,
      Theme.of(tester.element(find.text('favor'))).colorScheme.onSurfaceVariant,
    );

    await tester.tap(find.byTooltip('발음 듣기'));
    await tester.pumpAndSettle();

    expect(pronunciation.spokenWords, ['grace']);

    await tester.tap(find.byTooltip('단어장에 저장'));
    await tester.pumpAndSettle();
    expect(savedWords, ['grace']);
    expect(find.text('단어장에 저장했습니다'), findsOneWidget);
  });

  testWidgets('renders every inflection without raw source labels', (
    tester,
  ) async {
    const entry = DictionaryEntry(
      id: 2,
      word: 'have',
      wordNormalized: 'have',
      koreanMeaning: '가지다, 소유하다',
      inflectedForms: [
        InflectedForm(formType: 'inflected_form', form: 'had'),
        InflectedForm(formType: 'archaic_form', form: 'hast'),
        InflectedForm(formType: 'archaic_form', form: 'hath'),
        InflectedForm(formType: 'present_participle', form: 'having'),
        InflectedForm(formType: 'plural_or_third_person', form: 'possesses'),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          wordLookupProvider.overrideWith((ref, word) async => entry),
          pronunciationServiceProvider.overrideWithValue(
            _FakePronunciationService(),
          ),
          isWordSavedProvider.overrideWith((ref, word) async => false),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder:
                  (context) => TextButton(
                    onPressed:
                        () => DictionaryBottomSheet.show(context, 'have'),
                    child: const Text('open'),
                  ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();

    expect(find.text('고어 활용형'), findsNWidgets(2));
    expect(find.text('현재분사'), findsOneWidget);
    expect(find.text('복수형·3인칭 단수'), findsOneWidget);
    expect(find.text('had'), findsOneWidget);
    expect(find.text('hast'), findsOneWidget);
    expect(find.text('hath'), findsOneWidget);
    expect(find.text('having'), findsOneWidget);
    expect(find.text('inflected_form'), findsNothing);
    expect(find.text('archaic_form'), findsNothing);
  });

  testWidgets(
    'hides generic KJV labels when a concrete Korean meaning exists',
    (tester) async {
      const genericDefinition =
          'An archaic or specialized word form used in the King James Version.';
      const entry = DictionaryEntry(
        id: 3,
        word: 'whithersoever',
        wordNormalized: 'whithersoever',
        koreanMeaning: '어디로 가든지, 어디든지',
        senses: [
          WordSense(
            id: 3,
            partOfSpeech: 'unknown',
            senseOrder: 1,
            definition: genericDefinition,
            definitionKo: '어디로 가든지, 어디든지',
            isArchaic: true,
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            wordLookupProvider.overrideWith((ref, word) async => entry),
            pronunciationServiceProvider.overrideWithValue(
              _FakePronunciationService(),
            ),
            isWordSavedProvider.overrideWith((ref, word) async => false),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder:
                    (context) => TextButton(
                      onPressed:
                          () => DictionaryBottomSheet.show(
                            context,
                            'whithersoever',
                          ),
                      child: const Text('open'),
                    ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      expect(find.text('어디로 가든지, 어디든지'), findsNWidgets(2));
      expect(find.text(genericDefinition), findsNothing);
    },
  );

  testWidgets('shows localized parts of speech and hides English-only senses', (
    tester,
  ) async {
    const entry = DictionaryEntry(
      id: 4,
      word: 'alas',
      wordNormalized: 'alas',
      koreanMeaning: '슬프도다, 아아',
      senses: [
        WordSense(
          id: 4,
          partOfSpeech: 'intj',
          senseOrder: 1,
          definition: 'an exclamation of grief',
          definitionKo: '슬픔을 나타내는 감탄사',
        ),
        WordSense(
          id: 5,
          partOfSpeech: 'noun',
          senseOrder: 2,
          definition: 'an unrelated English-only sense',
        ),
      ],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          wordLookupProvider.overrideWith((ref, word) async => entry),
          pronunciationServiceProvider.overrideWithValue(
            _FakePronunciationService(),
          ),
          isWordSavedProvider.overrideWith((ref, word) async => false),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder:
                  (context) => TextButton(
                    onPressed:
                        () => DictionaryBottomSheet.show(context, 'alas'),
                    child: const Text('open'),
                  ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(find.text('감탄사'), findsOneWidget);
    expect(find.text('intj'), findsNothing);
    expect(find.text('슬픔을 나타내는 감탄사'), findsOneWidget);
    expect(find.text('an unrelated English-only sense'), findsNothing);
  });

  testWidgets(
    'removes a mismatched imported first sense and saves the Korean POS',
    (tester) async {
      String? savedPartOfSpeech;
      const entry = DictionaryEntry(
        id: 7,
        word: 'a',
        wordNormalized: 'a',
        koreanMeaning: '하나의 (부정관사); (부정관사) 어떤, 한',
        synonyms: ['angstrom'],
        senses: [
          WordSense(
            id: 7,
            partOfSpeech: 'noun',
            senseOrder: 1,
            definition: 'a metric unit of length',
            definitionKo: '하나의 (부정관사)',
          ),
          WordSense(
            id: 8,
            partOfSpeech: 'article',
            senseOrder: 2,
            definition: '',
            definitionKo: '(부정관사) 어떤, 한',
          ),
        ],
      );

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            wordLookupProvider.overrideWith((ref, word) async => entry),
            pronunciationServiceProvider.overrideWithValue(
              _FakePronunciationService(),
            ),
            isWordSavedProvider.overrideWith((ref, word) async => false),
            addVocabWordProvider.overrideWithValue(({
              required word,
              required bookId,
              required chapter,
              required verse,
              required translationCode,
              required definition,
              required partOfSpeech,
              required ipa,
              required bibleDefinition,
            }) async {
              savedPartOfSpeech = partOfSpeech;
            }),
          ],
          child: MaterialApp(
            home: Scaffold(
              body: Builder(
                builder:
                    (context) => TextButton(
                      onPressed: () => DictionaryBottomSheet.show(context, 'a'),
                      child: const Text('open'),
                    ),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();

      expect(find.text('하나의 (부정관사)'), findsOneWidget);
      expect(find.text('성경 문맥 뜻'), findsOneWidget);
      expect(find.text('다른 한국어 뜻'), findsOneWidget);
      expect(find.text('관사'), findsOneWidget);
      expect(find.text('명사'), findsNothing);
      expect(find.text('a metric unit of length'), findsNothing);
      expect(find.text('angstrom'), findsNothing);

      await tester.tap(find.byTooltip('단어장에 저장'));
      await tester.pumpAndSettle();
      expect(savedPartOfSpeech, 'article');
    },
  );

  testWidgets('removes imported source noise and compacts long meanings', (
    tester,
  ) async {
    final longMeaning = List.generate(
      60,
      (index) => '한국어 의미 ${index + 1}',
    ).join(', ');
    final entry = DictionaryEntry(
      id: 5,
      word: 'example',
      wordNormalized: 'example',
      koreanMeaning: '$longMeaning; Learning English (public domain); 음성 듣기 미국',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          wordLookupProvider.overrideWith((ref, word) async => entry),
          pronunciationServiceProvider.overrideWithValue(
            _FakePronunciationService(),
          ),
          isWordSavedProvider.overrideWith((ref, word) async => false),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder:
                  (context) => TextButton(
                    onPressed:
                        () => DictionaryBottomSheet.show(context, 'example'),
                    child: const Text('open'),
                  ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    expect(find.textContaining('한국어 의미 1, 한국어 의미 2'), findsOneWidget);
    expect(find.textContaining('Learning English'), findsNothing);
    expect(find.textContaining('음성 듣기'), findsNothing);
  });

  testWidgets('keeps the longest bundled headwords on one line on a phone', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 720);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    const entry = DictionaryEntry(
      id: 6,
      word: 'covenantbreakers',
      wordNormalized: 'covenantbreakers',
      koreanMeaning: '언약을 깨뜨리는 사람들',
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          wordLookupProvider.overrideWith((ref, word) async => entry),
          pronunciationServiceProvider.overrideWithValue(
            _FakePronunciationService(),
          ),
          isWordSavedProvider.overrideWith((ref, word) async => false),
        ],
        child: MaterialApp(
          home: Scaffold(
            body: Builder(
              builder:
                  (context) => TextButton(
                    onPressed:
                        () => DictionaryBottomSheet.show(
                          context,
                          'covenantbreakers',
                        ),
                    child: const Text('open'),
                  ),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();

    final title = tester.widget<Text>(find.text('covenantbreakers'));
    final fittedTitle = tester.getSize(
      find.byKey(const ValueKey('dictionary-word-title')),
    );
    expect(title.maxLines, 1);
    expect(fittedTitle.width, greaterThan(0));
    expect(tester.takeException(), isNull);
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
