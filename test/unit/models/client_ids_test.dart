import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/types/client_ids.dart';

/// Tests for ClientIds enum.
/// Focus: Testing enum values and value property.
void main() {
  group('ClientIds', () {
    group('enum values', () {
      test('should have 3 values', () {
        expect(ClientIds.values.length, 3);
      });

      test('should contain ANDROID', () {
        expect(ClientIds.values, contains(ClientIds.ANDROID));
      });

      test('should contain IOS', () {
        expect(ClientIds.values, contains(ClientIds.IOS));
      });

      test('should contain WEB', () {
        expect(ClientIds.values, contains(ClientIds.WEB));
      });
    });

    group('value property', () {
      test('ANDROID should have value trc-app', () {
        expect(ClientIds.ANDROID.value, 'trc-app');
      });

      test('IOS should have value trc-app', () {
        expect(ClientIds.IOS.value, 'trc-app');
      });

      test('WEB should have value trc-app', () {
        expect(ClientIds.WEB.value, 'trc-app');
      });

      test('all platforms should have same client id', () {
        expect(ClientIds.ANDROID.value, ClientIds.IOS.value);
        expect(ClientIds.IOS.value, ClientIds.WEB.value);
      });
    });

    group('enum index', () {
      test('ANDROID should have index 0', () {
        expect(ClientIds.ANDROID.index, 0);
      });

      test('IOS should have index 1', () {
        expect(ClientIds.IOS.index, 1);
      });

      test('WEB should have index 2', () {
        expect(ClientIds.WEB.index, 2);
      });
    });

    group('enum name', () {
      test('ANDROID should have name ANDROID', () {
        expect(ClientIds.ANDROID.name, 'ANDROID');
      });

      test('IOS should have name IOS', () {
        expect(ClientIds.IOS.name, 'IOS');
      });

      test('WEB should have name WEB', () {
        expect(ClientIds.WEB.name, 'WEB');
      });
    });

    group('value validation', () {
      test('all values should be non-empty', () {
        for (final clientId in ClientIds.values) {
          expect(clientId.value, isNotEmpty);
        }
      });

      test('all values should be non-null', () {
        for (final clientId in ClientIds.values) {
          expect(clientId.value, isNotNull);
        }
      });
    });
  });
}
