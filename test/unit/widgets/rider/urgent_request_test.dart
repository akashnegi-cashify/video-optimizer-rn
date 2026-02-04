import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_trc/src/modules/rider/urgent_request.dart';

// Test class that uses the UrgentRequest mixin
class TestUrgentRequestClass with UrgentRequest {}

void main() {
  group('UrgentRequest mixin', () {
    late TestUrgentRequestClass testClass;

    setUp(() {
      testClass = TestUrgentRequestClass();
    });

    test('initial isUrgent value is false', () {
      expect(testClass.isUrgent, false);
    });

    test('setting isUrgent to true works correctly', () {
      testClass.isUrgent = true;
      expect(testClass.isUrgent, true);
    });

    test('setting isUrgent to false works correctly', () {
      testClass.isUrgent = true;
      expect(testClass.isUrgent, true);

      testClass.isUrgent = false;
      expect(testClass.isUrgent, false);
    });

    test('isUrgent can be toggled multiple times', () {
      expect(testClass.isUrgent, false);

      testClass.isUrgent = true;
      expect(testClass.isUrgent, true);

      testClass.isUrgent = false;
      expect(testClass.isUrgent, false);

      testClass.isUrgent = true;
      expect(testClass.isUrgent, true);
    });

    test('multiple instances have independent state', () {
      final instance1 = TestUrgentRequestClass();
      final instance2 = TestUrgentRequestClass();

      instance1.isUrgent = true;
      instance2.isUrgent = false;

      expect(instance1.isUrgent, true);
      expect(instance2.isUrgent, false);
    });

    test('getter returns correct value after setter', () {
      testClass.isUrgent = true;
      final value = testClass.isUrgent;
      expect(value, true);
    });

    test('setter accepts boolean true', () {
      testClass.isUrgent = true;
      expect(testClass.isUrgent, isA<bool>());
      expect(testClass.isUrgent, equals(true));
    });

    test('setter accepts boolean false', () {
      testClass.isUrgent = false;
      expect(testClass.isUrgent, isA<bool>());
      expect(testClass.isUrgent, equals(false));
    });
  });
}
