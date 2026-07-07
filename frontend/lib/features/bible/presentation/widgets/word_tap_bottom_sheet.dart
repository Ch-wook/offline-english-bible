// lib/features/bible/presentation/widgets/word_tap_bottom_sheet.dart
// [MODIFY] 네이버 영어 사전 웹 연결

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

/// 단어 탭 → 네이버 영어사전 웹 연결
class WordTapBottomSheet {
  const WordTapBottomSheet._();

  static Future<void> show(BuildContext context, String word) async {
    final url = Uri.parse('https://en.dict.naver.com/#/search?query=$word');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('사전을 열 수 없습니다.')),
        );
      }
    }
  }
}
