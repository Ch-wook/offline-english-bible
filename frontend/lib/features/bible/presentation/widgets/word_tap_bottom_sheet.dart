// lib/features/bible/presentation/widgets/word_tap_bottom_sheet.dart

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../dictionary/domain/services/naver_dictionary_link_builder.dart';

/// Opens the tapped Bible word in Naver English Dictionary.
class WordTapBottomSheet {
  const WordTapBottomSheet._();

  static Future<void> show(BuildContext context, String word) async {
    final url = const NaverDictionaryLinkBuilder().buildSearchUri(word);

    try {
      if (await launchUrl(url, mode: LaunchMode.externalApplication)) {
        return;
      }

      if (await launchUrl(url)) {
        return;
      }
    } catch (_) {
      // The snackbar below gives the user the exact URL when the platform
      // cannot resolve a browser or dictionary app.
    }

    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('네이버 영어사전을 열 수 없습니다.\n$url')));
    }
  }
}
