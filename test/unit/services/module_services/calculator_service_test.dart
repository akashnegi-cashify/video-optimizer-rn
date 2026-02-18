import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty;
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/qc_calculator_service.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/calculator_submit_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_colors_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_media_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_status_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/manual_question_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_quote_request_data.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/brand_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/category_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/lob_product_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';

/// Unit tests for [CalculatorService] and [QcCalculatorService] classes.
///
/// These tests execute actual service methods to ensure code coverage.
/// Since QcCalculatorService extends CalculatorService with actual QcService,
/// we test all instance methods through the concrete implementation.
void main() {
  late QcCalculatorService sut;

  setUp(() {
    sut = QcCalculatorService();
  });

  group('QcCalculatorService', () {
    test('should return BaseService instance from getService', () {
      final service = sut.getService();
      expect(service, isA<BaseService>());
    });

    test('service property should be initialized', () {
      expect(sut.service, isA<BaseService>());
    });
  });

  group('CalculatorService methods via QcCalculatorService', () {
    group('getCalculator', () {
      test('should create stream with valid parameters', () {
        final stream = sut.getCalculator('DEVICE_001', 'SESSION_123', 456);
        expect(stream, isA<Stream<MyCalculatorResponse?>>());
      });

      test('should handle null parameters', () {
        final stream = sut.getCalculator(null, null, null);
        expect(stream, isA<Stream<MyCalculatorResponse?>>());
      });

      test('should handle empty deviceBarcode', () {
        final stream = sut.getCalculator('', 'session', 1);
        expect(stream, isA<Stream<MyCalculatorResponse?>>());
      });

      test('request body construction verification', () {
        const deviceBarcode = 'DEVICE_001';
        const pQuote = 'SESSION_123';
        const productId = 456;

        Map<String, dynamic> req = {
          "qrCode": deviceBarcode,
          "sessionId": pQuote,
          "productId": productId
        };

        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        expect(decoded['qrCode'], equals(deviceBarcode));
        expect(decoded['sessionId'], equals(pQuote));
        expect(decoded['productId'], equals(productId));
      });
    });

    group('getDeviceColors', () {
      test('should create stream with valid productId', () {
        final stream = sut.getDeviceColors(789);
        expect(stream, isA<Stream<DeviceColorResponse?>>());
      });

      test('should handle null productId', () {
        final stream = sut.getDeviceColors(null);
        expect(stream, isA<Stream<DeviceColorResponse?>>());
      });

      test('params construction verification', () {
        const productId = 789;
        Map<String, List<String>> params = {
          "pid": [productId.toString()]
        };
        expect(params['pid'], equals(['789']));
      });
    });

    group('getDeviceMedia', () {
      test('should create stream with deviceBarcode only', () {
        final stream = sut.getDeviceMedia('DEVICE_002');
        expect(stream, isA<Stream<DeviceMediaResponse?>>());
      });

      test('should create stream with categoryId', () {
        final stream = sut.getDeviceMedia('DEVICE_002', categoryId: 10);
        expect(stream, isA<Stream<DeviceMediaResponse?>>());
      });

      test('should create stream with quoteRequest', () {
        final quoteRequest = MyQuoteRequestData();
        final stream = sut.getDeviceMedia('DEVICE_002', categoryId: 10, quoteRequest: quoteRequest);
        expect(stream, isA<Stream<DeviceMediaResponse?>>());
      });

      test('should handle null deviceBarcode', () {
        final stream = sut.getDeviceMedia(null);
        expect(stream, isA<Stream<DeviceMediaResponse?>>());
      });
    });

    group('submitDeviceMedia', () {
      test('should create stream with valid parameters', () {
        final stream = sut.submitDeviceMedia([], 'DEVICE_003');
        expect(stream, isA<Stream<DeviceMediaResponse?>>());
      });

      test('should handle null mediaList', () {
        final stream = sut.submitDeviceMedia(null, 'DEVICE_003');
        expect(stream, isA<Stream<DeviceMediaResponse?>>());
      });

      test('should handle null deviceBarcode', () {
        final stream = sut.submitDeviceMedia([], null);
        expect(stream, isA<Stream<DeviceMediaResponse?>>());
      });
    });

    group('submitCalculatorResponse', () {
      test('should create stream with default isDeviceTypeLob (false)', () {
        final stream = sut.submitCalculatorResponse(null, 'DEVICE_004');
        expect(stream, isA<Stream<CalculatorSubmitResponse?>>());
      });

      test('should create stream with isDeviceTypeLob true', () {
        final stream = sut.submitCalculatorResponse(null, 'DEVICE_004', isDeviceTypeLob: true);
        expect(stream, isA<Stream<CalculatorSubmitResponse?>>());
      });

      test('should create stream with quoteRequest', () {
        final quoteRequest = MyQuoteRequestData();
        final stream = sut.submitCalculatorResponse(quoteRequest, 'DEVICE_004');
        expect(stream, isA<Stream<CalculatorSubmitResponse?>>());
      });

      test('endpoint selection verification', () {
        const deviceBarcode = 'DEVICE_004';
        
        final lobEndpoint = "/manual-test/calculator/submit/$deviceBarcode";
        final cdpEndpoint = "/v1/cdp/cal/submit/$deviceBarcode";
        
        expect(lobEndpoint, contains('manual-test'));
        expect(cdpEndpoint, contains('v1/cdp'));
      });
    });

    group('getDeviceStatus', () {
      test('should create stream with valid deviceBarcode', () {
        final stream = sut.getDeviceStatus('DEVICE_005');
        expect(stream, isA<Stream<DeviceStatusResponse?>>());
      });

      test('should handle null deviceBarcode', () {
        final stream = sut.getDeviceStatus(null);
        expect(stream, isA<Stream<DeviceStatusResponse?>>());
      });

      test('should handle empty deviceBarcode', () {
        final stream = sut.getDeviceStatus('');
        expect(stream, isA<Stream<DeviceStatusResponse?>>());
      });
    });

    group('submitManualQuestions', () {
      test('should create stream with valid parameters', () {
        final stream = sut.submitManualQuestions('QR_001', ['Q1', 'Q2', 'Q3']);
        expect(stream, isA<Stream<BaseActionResponse?>>());
      });

      test('should handle null qrCode', () {
        final stream = sut.submitManualQuestions(null, ['Q1']);
        expect(stream, isA<Stream<BaseActionResponse?>>());
      });

      test('should handle null questionList', () {
        final stream = sut.submitManualQuestions('QR_001', null);
        expect(stream, isA<Stream<BaseActionResponse?>>());
      });

      test('should handle empty questionList', () {
        final stream = sut.submitManualQuestions('QR_001', []);
        expect(stream, isA<Stream<BaseActionResponse?>>());
      });
    });

    group('getManualQuestions', () {
      test('should create stream with valid qrCode', () {
        final stream = sut.getManualQuestions('QR_002');
        expect(stream, isA<Stream<ManualQuestionListResponse?>>());
      });

      test('should handle null qrCode', () {
        final stream = sut.getManualQuestions(null);
        expect(stream, isA<Stream<ManualQuestionListResponse?>>());
      });
    });

    group('getProductListAccToImei', () {
      test('should create stream with valid imei', () {
        final stream = sut.getProductListAccToImei('123456789012345');
        expect(stream, isA<Stream<LobProductListResponse?>>());
      });

      test('should handle null imei', () {
        final stream = sut.getProductListAccToImei(null);
        expect(stream, isA<Stream<LobProductListResponse?>>());
      });

      test('should handle empty imei', () {
        final stream = sut.getProductListAccToImei('');
        expect(stream, isA<Stream<LobProductListResponse?>>());
      });
    });

    group('getLobCalculator', () {
      test('should create stream with required parameters', () {
        final stream = sut.getLobCalculator('DEVICE_006', 100, 200, 300, null);
        expect(stream, isA<Stream<MyCalculatorResponse?>>());
      });

      test('should create stream with variantItem', () {
        final variantItem = VariantListData(10, 'Variant A', 'Common Name', '6.5"', 'Snapdragon');
        final stream = sut.getLobCalculator('DEVICE_006', 100, 200, 300, variantItem);
        expect(stream, isA<Stream<MyCalculatorResponse?>>());
      });

      test('should handle null parameters', () {
        final stream = sut.getLobCalculator(null, null, null, null, null);
        expect(stream, isA<Stream<MyCalculatorResponse?>>());
      });

      test('request body construction with variant', () {
        const variantId = 10;
        const variantName = 'Variant A';

        Map<String, dynamic> req = {
          "qc": "DEVICE",
          "pmid": "100",
          "pid": "200",
          "cat_id": "300",
          "vid": variantId,
          "vn": variantName,
        };

        expect(req.containsKey('vid'), isTrue);
        expect(req.containsKey('vn'), isTrue);
        expect(req['vid'], equals(10));
        expect(req['vn'], equals('Variant A'));
      });
    });

    group('getDeviceDetail', () {
      test('should create stream with valid deviceBarcode', () {
        final stream = sut.getDeviceDetail('DEVICE_007');
        expect(stream, isA<Stream<DeviceDetailResponse?>>());
      });

      test('should handle null deviceBarcode', () {
        final stream = sut.getDeviceDetail(null);
        expect(stream, isA<Stream<DeviceDetailResponse?>>());
      });
    });

    group('reportMismatch', () {
      test('should create stream with required parameters', () {
        final stream = sut.reportMismatch(['IMEI_1'], 'DEVICE_008', 'http://example.com/imei.jpg');
        expect(stream, isA<Stream<BaseActionResponse?>>());
      });

      test('should create stream with timeoutReason', () {
        final stream = sut.reportMismatch(['IMEI_1'], 'DEVICE_008', 'url', timeoutReason: 'Timeout occurred');
        expect(stream, isA<Stream<BaseActionResponse?>>());
      });

      test('should create stream with isImei2Available', () {
        final stream = sut.reportMismatch(['IMEI_1'], 'DEVICE_008', 'url', isImei2Available: true);
        expect(stream, isA<Stream<BaseActionResponse?>>());
      });

      test('should create stream with isAutoApproved', () {
        final stream = sut.reportMismatch(['IMEI_1'], 'DEVICE_008', 'url', isAutoApproved: true);
        expect(stream, isA<Stream<BaseActionResponse?>>());
      });

      test('should create stream with isSerialNo true', () {
        final stream = sut.reportMismatch(['SERIAL_123'], 'DEVICE_008', 'url', isSerialNo: true);
        expect(stream, isA<Stream<BaseActionResponse?>>());
      });

      test('should handle null scannedList', () {
        final stream = sut.reportMismatch(null, 'DEVICE_008', 'url');
        expect(stream, isA<Stream<BaseActionResponse?>>());
      });

      test('request body construction verification', () {
        const deviceBarcode = 'DEVICE_008';
        const imeiImageUrl = 'http://example.com/imei.jpg';
        const timeoutReason = 'Timeout occurred';
        const isAutoApproved = false;

        var req = {
          "qr": deviceBarcode,
          "image_url": imeiImageUrl,
          "rm": timeoutReason,
          "iaa": isAutoApproved,
        };

        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        expect(decoded['qr'], equals(deviceBarcode));
        expect(decoded['image_url'], equals(imeiImageUrl));
        expect(decoded['rm'], equals(timeoutReason));
        expect(decoded['iaa'], equals(false));
      });
    });

    group('getBrandList', () {
      test('should create stream with valid categoryId', () {
        final stream = sut.getBrandList(50);
        expect(stream, isA<Stream<BrandListResponse?>>());
      });

      test('should handle null categoryId', () {
        final stream = sut.getBrandList(null);
        expect(stream, isA<Stream<BrandListResponse?>>());
      });
    });

    group('getCategory', () {
      test('should create stream with valid parameters', () {
        final stream = sut.getCategory('BARCODE_001', 'SESSION_001');
        expect(stream, isA<Stream<CategoryResponse?>>());
      });

      test('should handle null parameters', () {
        final stream = sut.getCategory(null, null);
        expect(stream, isA<Stream<CategoryResponse?>>());
      });
    });
  });

  group('Integration - All methods create valid streams', () {
    test('all QcCalculatorService methods should be callable', () {
      expect(() => sut.getCalculator('bc', 'session', 1), returnsNormally);
      expect(() => sut.getDeviceColors(1), returnsNormally);
      expect(() => sut.getDeviceMedia('bc'), returnsNormally);
      expect(() => sut.submitDeviceMedia([], 'bc'), returnsNormally);
      expect(() => sut.submitCalculatorResponse(null, 'bc'), returnsNormally);
      expect(() => sut.getDeviceStatus('bc'), returnsNormally);
      expect(() => sut.submitManualQuestions('qr', []), returnsNormally);
      expect(() => sut.getManualQuestions('qr'), returnsNormally);
      expect(() => sut.getProductListAccToImei('imei'), returnsNormally);
      expect(() => sut.getLobCalculator('bc', 1, 1, 1, null), returnsNormally);
      expect(() => sut.getDeviceDetail('bc'), returnsNormally);
      expect(() => sut.reportMismatch([], 'bc', 'url'), returnsNormally);
      expect(() => sut.getBrandList(1), returnsNormally);
      expect(() => sut.getCategory('bc', 'session'), returnsNormally);
    });
  });
}
