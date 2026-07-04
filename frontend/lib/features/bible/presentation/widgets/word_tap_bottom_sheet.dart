// lib/features/bible/presentation/widgets/word_tap_bottom_sheet.dart
// [MODIFY] DictionaryBottomSheet 로 위임

import 'package:flutter/material.dart';

import '../../../dictionary/presentation/widgets/dictionary_bottom_sheet.dart';

/// 단어 탭 → 사전 바텀시트 위임 래퍼.
/// TASK 4 의 DictionaryBottomSheet 를 직접 사용한다.
class WordTapBottomSheet {
  const WordTapBottomSheet._();

  static Future<void> show(BuildContext context, String word) =>
      DictionaryBottomSheet.show(context, word);
}
