import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/utils/csh_tts_util.dart';

void main() {
  group('CshTtsUtil', () {
    test('singleton instance returns same instance', () {
      final instance1 = CshTtsUtil();
      final instance2 = CshTtsUtil();

      expect(identical(instance1, instance2), true);
    });

    test('CshTtsUtil class exists', () {
      expect(CshTtsUtil, isNotNull);
    });

    test('factory constructor returns singleton', () {
      final instance = CshTtsUtil();
      expect(instance, isA<CshTtsUtil>());
    });

    test('speak method exists', () {
      final instance = CshTtsUtil();
      expect(instance.speak, isA<Function>());
    });

    // Note: The actual TTS functionality requires platform channels
    // which cannot be tested in unit tests without mocking.
    // The FlutterTts plugin requires a real device or emulator.
  });

  group('CshTtsUtil - Singleton Pattern', () {
    test('multiple factory calls return identical instance', () {
      final instances = List.generate(5, (_) => CshTtsUtil());

      for (int i = 1; i < instances.length; i++) {
        expect(identical(instances[0], instances[i]), true);
      }
    });
  });
}
