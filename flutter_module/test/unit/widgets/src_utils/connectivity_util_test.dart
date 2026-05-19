import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/utils/connectivity_util.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('dev.fluttercommunity.plus/connectivity'),
      (MethodCall methodCall) async {
        if (methodCall.method == 'check') {
          return ['wifi'];
        }
        return null;
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('dev.fluttercommunity.plus/connectivity'),
      null,
    );
  });

  group('ConnectivityUtil', () {
    test('checkConnectivity method exists', () {
      // Verify the static method exists
      expect(ConnectivityUtil.checkConnectivity, isA<Function>());
    });

    test('checkConnectivity returns a Future<bool>', () async {
      // Verify the return type
      final result = ConnectivityUtil.checkConnectivity();
      expect(result, isA<Future<bool>>());
    });
  });

  group('ConnectivityUtil - Class Structure', () {
    test('ConnectivityUtil class exists', () {
      expect(ConnectivityUtil, isNotNull);
    });

    test('checkConnectivity is a static method', () {
      // This verifies we can call it without instantiation
      ConnectivityUtil.checkConnectivity;
      expect(true, isTrue); // If we get here, the static method exists
    });
  });
}
