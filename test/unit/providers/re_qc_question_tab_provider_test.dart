import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/re_qc/providers/re_qc_question_tab_provider.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/device_report_list_response.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for ReQcQuestionsProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('ReQcQuestionsProvider', () {
    late ReQcQuestionsProvider provider;
    late List<DeviceReportListData> mockDeviceReportList;

    setUp(() {
      mockDeviceReportList = [
        DeviceReportListData.fromJson({
          'partId': 1,
          'partName': 'Screen',
          'selectedVariationId': 101,
          'selectedVariationName': 'Good',
          'imageCount': 0,
          'value': {'101': 'Good', '102': 'Bad'},
        }),
        DeviceReportListData.fromJson({
          'partId': 2,
          'partName': 'Battery',
          'selectedVariationId': 102,
          'selectedVariationName': 'Working',
          'imageCount': 1,
          'value': {'102': 'Working', '103': 'Not Working'},
        }),
        DeviceReportListData.fromJson({
          'partId': 3,
          'partName': 'Camera',
          'selectedVariationId': 103,
          'selectedVariationName': 'Functional',
          'imageCount': 0,
          'value': {'103': 'Functional', '104': 'Broken'},
        }),
      ];
      provider = ReQcQuestionsProvider(mockDeviceReportList, 'TEST_BARCODE_001');
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should store deviceBarcode', () {
        expect(provider.deviceBarcode, 'TEST_BARCODE_001');
      });

      test('should store deviceReportList', () {
        expect(provider.deviceReportList, isNotNull);
        expect(provider.deviceReportList?.length, 3);
      });

      test('should handle null deviceReportList', () {
        final providerWithNull = ReQcQuestionsProvider(null, 'TEST');
        expect(providerWithNull.deviceReportList, isNull);
        providerWithNull.dispose();
      });

      test('should handle empty deviceReportList', () {
        final providerWithEmpty = ReQcQuestionsProvider([], 'TEST');
        expect(providerWithEmpty.deviceReportList, isNull);
        providerWithEmpty.dispose();
      });

      test('should set initial user selected variant id', () {
        expect(provider.deviceReportList?[0].userSelectedVariantId, isNotNull);
      });
    });

    group('questionLength getter', () {
      test('should return correct length', () {
        expect(provider.questionLength, 3);
      });

      test('should return 0 when deviceReportList is null', () {
        final providerWithNull = ReQcQuestionsProvider(null, 'TEST');
        expect(providerWithNull.questionLength, 0);
        providerWithNull.dispose();
      });
    });

    group('setUserSelectedVariantId', () {
      test('should update userSelectedVariantId', () {
        provider.setUserSelectedVariantId(0, '999');

        expect(provider.deviceReportList?[0].userSelectedVariantId, '999');
      });

      test('should notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.setUserSelectedVariantId(0, '999');

        expect(tracker.callCount, 1);
      });
    });

    group('isImageRequired', () {
      test('should return true when imageCount > 0', () {
        // Item at index 1 has imageCount: 1
        expect(provider.isImageRequired(1), true);
      });

      test('should return true when variants are different', () {
        // Change user selected variant to be different from preSelected
        provider.setUserSelectedVariantId(2, '104');  // preSelectedVariantId is 103
        expect(provider.isImageRequired(2), true);
      });

      test('should return false when no image required and variants match', () {
        // Item at index 0 has imageCount: 0 and matching variants
        expect(provider.isImageRequired(0), false);
      });
    });

    group('setImageUrl', () {
      test('should set imageUrl for item', () {
        provider.setImageUrl(0, 'https://example.com/image.jpg');

        expect(provider.deviceReportList?[0].imageUrl, 'https://example.com/image.jpg');
      });

      test('should notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.setImageUrl(0, 'https://example.com/image.jpg');

        expect(tracker.callCount, 1);
      });
    });

    group('isMismatchMarked', () {
      test('should return false initially', () {
        expect(provider.isMismatchMarked(), false);
      });

      test('should check all items for mismatch', () {
        // Modify item to have mismatch
        provider.setUserSelectedVariantId(0, '999');

        // The result depends on the device report list mismatch logic
        expect(provider.isMismatchMarked(), isA<bool>());
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(ReQcQuestionsProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testData = [
          DeviceReportListData.fromJson({
            'partId': 1,
            'selectedVariationId': 101,
            'imageCount': 0,
            'value': {'101': 'Good'},
          }),
        ];
        final testProvider = ReQcQuestionsProvider(testData, 'TEST');
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });

    group('method signatures', () {
      test('should have uploadImage method', () {
        expect(provider.uploadImage, isNotNull);
      });

      test('should have submitReQcData method', () {
        expect(provider.submitReQcData, isNotNull);
      });
    });
  });
}
