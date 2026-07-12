import 'package:flutter_tts/flutter_tts.dart';

abstract interface class PronunciationService {
  Future<bool> speak(String word);
  Future<void> stop();
}

final class DevicePronunciationService implements PronunciationService {
  DevicePronunciationService({FlutterTts? engine})
    : _engine = engine ?? FlutterTts();

  final FlutterTts _engine;

  @override
  Future<bool> speak(String word) async {
    final query = word.trim();
    if (query.isEmpty) return false;

    try {
      final available = await _engine.isLanguageAvailable('en-US');
      if (available != true && available != 1) return false;
      await _engine.stop();
      await _engine.setLanguage('en-US');
      await _engine.setSpeechRate(0.42);
      await _engine.setPitch(1.0);
      await _engine.setVolume(1.0);
      final result = await _engine.speak(query);
      return result == 1;
    } catch (_) {
      return false;
    }
  }

  @override
  Future<void> stop() async {
    try {
      await _engine.stop();
    } catch (_) {
      // TTS 엔진이 없는 기기에서도 사전 조회 자체는 계속 동작해야 한다.
    }
  }
}
