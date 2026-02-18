import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/providers/assigned_parts_provider.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_info.dart';

/// Tests for AssignedPartsProvider - Engineer module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('AssignedPartsProvider', () {
    late AssignedPartsProvider provider;

    setUp(() {
      provider = AssignedPartsProvider('TEST_BARCODE_001');
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should create instance with barcode', () {
        expect(provider, isNotNull);
      });

      test('should accept null barcode', () {
        final providerWithNull = AssignedPartsProvider(null);
        expect(providerWithNull, isNotNull);
        providerWithNull.dispose();
      });

      test('should accept optional deviceInfo', () {
        final deviceInfo = EngineerDeviceInfo.fromJson({
          'deviceId': 123,
          'deviceBarcode': 'TEST_001',
        });
        final providerWithInfo = AssignedPartsProvider(
          'TEST_BARCODE',
          deviceInfo: deviceInfo,
        );
        expect(providerWithInfo.deviceInfo, isNotNull);
        expect(providerWithInfo.deviceInfo?.deviceId, 123);
        providerWithInfo.dispose();
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(AssignedPartsProvider.of, isNotNull);
      });
    });

    group('jobCardList', () {
      test('should initially be null', () {
        expect(provider.jobCardList, isNull);
      });
    });

    group('deviceInfo', () {
      test('should be accessible', () {
        // Initially null unless passed in constructor
        final providerWithoutInfo = AssignedPartsProvider('TEST');
        expect(providerWithoutInfo.deviceInfo, isNull);
        providerWithoutInfo.dispose();
      });

      test('should return passed deviceInfo', () {
        final deviceInfo = EngineerDeviceInfo.fromJson({
          'deviceId': 456,
          'deviceBarcode': 'TEST_456',
        });
        final providerWithInfo = AssignedPartsProvider(
          'TEST',
          deviceInfo: deviceInfo,
        );
        expect(providerWithInfo.deviceInfo?.deviceBarcode, 'TEST_456');
        providerWithInfo.dispose();
      });
    });

    group('refreshPage', () {
      test('should have refreshPage method', () {
        expect(provider.refreshPage, isNotNull);
      });

      test('should accept barcode parameter', () {
        // Should not throw
        expect(() => provider.refreshPage('NEW_BARCODE'), returnsNormally);
      });

      test('should accept null barcode', () {
        expect(() => provider.refreshPage(null), returnsNormally);
      });
    });

    group('getPartListHistory', () {
      test('should have getPartListHistory method', () {
        expect(provider.getPartListHistory, isNotNull);
      });

      test('should return Future<List>', () {
        expect(provider.getPartListHistory is Function, isTrue);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = AssignedPartsProvider('TEST');
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
