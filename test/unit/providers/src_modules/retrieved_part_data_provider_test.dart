import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/engineer/retreived_parts/providers/retrieved_part_data_provider.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';

/// Tests for RetrievedPartsDataProviders - Engineer module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('RetrievedPartsDataProviders', () {
    late RetrievedPartsDataProviders provider;

    setUp(() {
      provider = RetrievedPartsDataProviders();
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should create instance', () {
        expect(provider, isNotNull);
      });

      test('should initialize retrievedPartRequest', () {
        expect(provider.retrievedPartRequest, isNotNull);
      });

      test('should accept optional partInfo', () {
        final partInfo = EngineerPartInfo(prId: 123, partId: 456);
        final providerWithPart = RetrievedPartsDataProviders(partInfo: partInfo);
        expect(providerWithPart.partInfo, isNotNull);
        expect(providerWithPart.partInfo?.prId, 123);
        expect(providerWithPart.retrievedPartRequest.partRequestId, 123);
        providerWithPart.dispose();
      });

      test('should accept optional onSuccess callback', () {
        bool callbackCalled = false;
        final providerWithCallback = RetrievedPartsDataProviders(
          onSuccess: () => callbackCalled = true,
        );
        expect(providerWithCallback.onSuccess, isNotNull);
        providerWithCallback.dispose();
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(RetrievedPartsDataProviders.of, isNotNull);
      });
    });

    group('partInfo', () {
      test('should be null initially', () {
        expect(provider.partInfo, isNull);
      });
    });

    group('reasonList', () {
      test('should be null initially', () {
        expect(provider.reasonList, isNull);
      });
    });

    group('retrievedPartRequest', () {
      test('should be initialized', () {
        expect(provider.retrievedPartRequest, isNotNull);
      });

      test('should be RetrievedPartRequest type', () {
        expect(provider.retrievedPartRequest, isA<RetrievedPartRequest>());
      });
    });

    group('onS3UrlChange', () {
      test('should update imageUrl', () {
        provider.onS3UrlChange('https://example.com/image.jpg');
        expect(provider.retrievedPartRequest.imageUrl, 'https://example.com/image.jpg');
      });
    });

    group('onReasonSelected', () {
      test('should update reasonId', () {
        provider.onReasonSelected('Test Reason', 42);
        expect(provider.retrievedPartRequest.reasonId, 42);
      });
    });

    group('onBarcodeChanged', () {
      test('should update partBarcode', () {
        provider.onBarcodeChanged('BARCODE123');
        expect(provider.retrievedPartRequest.partBarcode, 'BARCODE123');
      });
    });

    group('onRemarkChanged', () {
      test('should update remarks', () {
        provider.onRemarkChanged('Test remarks');
        expect(provider.retrievedPartRequest.remarks, 'Test remarks');
      });
    });

    group('isMandatoryFieldsSubmitted', () {
      test('should return false when all fields are empty', () {
        expect(provider.isMandatoryFieldsSubmitted(), isFalse);
      });

      test('should return false when only partBarcode is set', () {
        provider.onBarcodeChanged('BARCODE123');
        expect(provider.isMandatoryFieldsSubmitted(), isFalse);
      });

      test('should return false when only imageUrl is set', () {
        provider.onS3UrlChange('https://example.com/image.jpg');
        expect(provider.isMandatoryFieldsSubmitted(), isFalse);
      });

      test('should return false when only reasonId is set', () {
        provider.onReasonSelected('Reason', 1);
        expect(provider.isMandatoryFieldsSubmitted(), isFalse);
      });

      test('should return true when all mandatory fields are set', () {
        provider.onBarcodeChanged('BARCODE123');
        provider.onS3UrlChange('https://example.com/image.jpg');
        provider.onReasonSelected('Reason', 1);
        expect(provider.isMandatoryFieldsSubmitted(), isTrue);
      });
    });

    group('updateRetrievedPartWithDeviceReceive', () {
      test('should have updateRetrievedPartWithDeviceReceive method', () {
        expect(provider.updateRetrievedPartWithDeviceReceive, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = RetrievedPartsDataProviders();
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });

  group('RetrievedPartRequest', () {
    test('should create instance with default null values', () {
      final request = RetrievedPartRequest();
      expect(request.imageUrl, isNull);
      expect(request.remarks, isNull);
      expect(request.partBarcode, isNull);
      expect(request.reasonId, isNull);
      expect(request.partRequestId, isNull);
    });

    test('should allow setting values', () {
      final request = RetrievedPartRequest();
      request.imageUrl = 'test_url';
      request.remarks = 'test remarks';
      request.partBarcode = 'PART001';
      request.reasonId = 100;
      request.partRequestId = 200;

      expect(request.imageUrl, 'test_url');
      expect(request.remarks, 'test remarks');
      expect(request.partBarcode, 'PART001');
      expect(request.reasonId, 100);
      expect(request.partRequestId, 200);
    });
  });
}
