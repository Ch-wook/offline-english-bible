import 'package:flutter_test/flutter_test.dart';
import 'package:offline_english_bible/core/database/app_database.dart';
import 'package:offline_english_bible/core/services/dictionary_import_service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late AppDatabase db;

  setUp(() {
    db = AppDatabase(createInMemoryConnection());
  });

  tearDown(() async {
    await db.close();
  });

  test(
    'imports the full dictionary and resolves KJV inflections',
    () async {
      final service = DictionaryImportService(db);
      (double, String)? lastProgress;

      await for (final progress in service.importDictionary()) {
        lastProgress = progress;
      }

      expect(lastProgress?.$1, 1.0);
      final count =
          await db
              .customSelect('SELECT COUNT(*) AS count FROM dictionary_entries')
              .getSingle();
      expect(count.read<int>('count'), greaterThan(9000));

      final grace = await db.lookupWord('grace');
      expect(grace, isNotNull);
      expect(grace!.koreanMeaning, isNotEmpty);

      final created = await db.lookupWord('created');
      expect(created, isNotNull);
      expect(created!.wordNormalized, 'create');

      final loveth = await db.lookupWord('loveth');
      expect(loveth, isNotNull);
      expect(loveth!.wordNormalized, 'love');
    },
    timeout: const Timeout(Duration(minutes: 2)),
  );
}
