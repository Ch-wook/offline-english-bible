// test/helpers/test_database_helper.dart
// [NEW] 테스트용 인메모리 데이터베이스 헬퍼

import 'package:offline_english_bible/core/database/app_database.dart';

/// 테스트용 인메모리 AppDatabase 생성.
/// 각 테스트에서 독립적인 DB 인스턴스를 사용한다.
AppDatabase createTestDatabase() {
  return AppDatabase(createInMemoryConnection());
}

/// 테스트 종료 시 DB 닫기.
Future<void> closeTestDatabase(AppDatabase db) => db.close();
