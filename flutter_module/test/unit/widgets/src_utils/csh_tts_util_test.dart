import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/utils/csh_tts_util.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('flutter_tts'),
      (MethodCall methodCall) async {
        switch (methodCall.method) {
          case 'setVolume':
          case 'setSpeechRate':
          case 'speak':
            return 1;
          default:
            return null;
        }
      },
    );
  });

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
