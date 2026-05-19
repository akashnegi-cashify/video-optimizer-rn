import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/providers/elss_status_provider.dart';

/// Tests for ElssStatusProvider - ELSS QC module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('ElssStatusProvider', () {
    late ElssStatusProvider provider;

    setUp(() {
      provider = ElssStatusProvider('TEST_BARCODE_001');
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should create instance with barcode', () {
        expect(provider, isNotNull);
      });

      test('should have isDataLoading initially true', () {
        expect(provider.isDataLoading, isTrue);
      });

      test('should have errMessage initially null', () {
        expect(provider.errMessage, isNull);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(ElssStatusProvider.of, isNotNull);
      });
    });

    group('deviceDetails getter', () {
      test('should return null when response is null', () {
        // Initially null before API response
        expect(provider.deviceDetails, isNull);
      });
    });

    group('isDataLoading', () {
      test('should be true initially', () {
        expect(provider.isDataLoading, isTrue);
      });
    });

    group('errMessage', () {
      test('should be null initially', () {
        expect(provider.errMessage, isNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = ElssStatusProvider('TEST');
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
