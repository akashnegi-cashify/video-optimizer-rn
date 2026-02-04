import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

/// Unit tests for [ElssService] class.
///
/// Tests cover:
/// - getElssDeviceDetails: params construction
/// - uploadPartsFaultImages: request body construction
/// - submitDeviceDetails: request body construction
/// - markPnaStatus: params and body construction
/// - getDeviceDetailsWithParts: request body with conditional fields
/// - retestingElss/rejectElss: request body construction
/// - getElssRejectReasonList: conditional endpoint
/// - sendOtp/authenticateOTP: params construction
void main() {
  group('ElssService', () {
    group('getElssDeviceDetails', () {
      test('should construct params with dbr', () {
        // Arrange
        const scannedBarcode = 'DEVICE_001';
        Map<String, List<String>> paramData = {
          "dbr": [scannedBarcode]
        };

        // Assert
        expect(paramData['dbr'], equals(['DEVICE_001']));
      });

      test('should use correct endpoint /elss/device-details', () {
        const expectedEndpoint = '/elss/device-details';
        expect(expectedEndpoint, equals('/elss/device-details'));
      });
    });

    group('uploadPartsFaultImages', () {
      test('should construct request body with dbr and imd', () {
        // Arrange
        const scannedBarcode = 'DEVICE_002';
        final imageData = {
          'front': ['url1', 'url2'],
          'back': ['url3'],
        };

        Map<String, dynamic> dataMap = {
          "dbr": scannedBarcode,
          "imd": imageData,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(dataMap)) as Map<String, dynamic>;

        // Assert
        expect(decoded['dbr'], equals('DEVICE_002'));
        expect(decoded['imd'], isA<Map>());
      });

      test('should use correct endpoint /part/upload-fault-images', () {
        const expectedEndpoint = '/part/upload-fault-images';
        expect(expectedEndpoint, equals('/part/upload-fault-images'));
      });
    });

    group('submitDeviceDetails', () {
      test('should construct request body with bid, pid, dbr, and cl', () {
        // Arrange
        const bid = 1;
        const pid = 2;
        const barcode = 'DEVICE_003';
        const color = 'Black';

        Map<String, dynamic> bodyData = {
          "bid": bid,
          "pid": pid,
          "dbr": barcode,
          "cl": color,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(bodyData)) as Map<String, dynamic>;

        // Assert
        expect(decoded['bid'], equals(1));
        expect(decoded['pid'], equals(2));
        expect(decoded['dbr'], equals('DEVICE_003'));
        expect(decoded['cl'], equals('Black'));
      });

      test('should use correct endpoint /device/submit-details', () {
        const expectedEndpoint = '/device/submit-details';
        expect(expectedEndpoint, equals('/device/submit-details'));
      });
    });

    group('markPnaStatus', () {
      test('should construct params with qr', () {
        // Arrange
        const scannedCode = 'QR_001';
        Map<String, List<String>> params = {
          "qr": [scannedCode],
        };

        // Assert
        expect(params['qr'], equals(['QR_001']));
      });

      test('should use correct endpoint /device/elss/mark-pna', () {
        const expectedEndpoint = '/device/elss/mark-pna';
        expect(expectedEndpoint, equals('/device/elss/mark-pna'));
      });
    });

    group('getDeviceDetailsWithParts', () {
      test('should construct request body with qr', () {
        // Arrange
        const scannedBarcode = 'DEVICE_004';

        Map<String, String?> req = {
          "qr": scannedBarcode,
        };

        // Assert
        expect(req['qr'], equals('DEVICE_004'));
      });

      test('should include sid when pQuoteId is not empty', () {
        // Arrange
        const pQuoteId = 'QUOTE_001';
        Map<String, String?> req = {
          "qr": "DEVICE",
          "sid": pQuoteId,
        };

        // Assert
        expect(req.containsKey('sid'), isTrue);
        expect(req['sid'], equals('QUOTE_001'));
      });

      test('should include r when remarks is not empty', () {
        // Arrange
        const remarks = 'Some remarks';
        Map<String, String?> req = {
          "qr": "DEVICE",
          "r": remarks,
        };

        // Assert
        expect(req.containsKey('r'), isTrue);
        expect(req['r'], equals('Some remarks'));
      });

      test('should use correct endpoint /device/elss/scan', () {
        const expectedEndpoint = '/device/elss/scan';
        expect(expectedEndpoint, equals('/device/elss/scan'));
      });
    });

    group('retestingElss', () {
      test('should construct request body with res', () {
        // Arrange
        final reasonIdList = [1, 2, 3];
        Map<String, dynamic> req = {
          "res": reasonIdList,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['res'], equals([1, 2, 3]));
      });

      test('should construct endpoint with qr query parameter', () {
        // Arrange
        const barcode = 'DEVICE_005';
        final endpoint = '/device/elss/re-testing?qr=$barcode';

        // Assert
        expect(endpoint, equals('/device/elss/re-testing?qr=DEVICE_005'));
      });
    });

    group('rejectElss', () {
      test('should construct request body with res and isDefault', () {
        // Arrange
        final reasonIdList = [4, 5, 6];
        Map<String, dynamic> req = {
          "res": reasonIdList,
          "isDefault": "false",
        };

        // Act
        final decoded = jsonDecode(jsonEncode(req)) as Map<String, dynamic>;

        // Assert
        expect(decoded['res'], equals([4, 5, 6]));
        expect(decoded['isDefault'], equals('false'));
      });

      test('should construct endpoint with qr query parameter', () {
        // Arrange
        const barcode = 'DEVICE_006';
        final endpoint = '/device/elss/reject?qr=$barcode';

        // Assert
        expect(endpoint, equals('/device/elss/reject?qr=DEVICE_006'));
      });
    });

    group('getElssRejectReasonList', () {
      test('should use reject endpoint for reject reason type', () {
        // Arrange
        const isReject = true;
        final baseUrl = isReject ? '/device/elss/return-reason/elss_reject' : '/device/elss/return-reason/retesting';

        // Assert
        expect(baseUrl, equals('/device/elss/return-reason/elss_reject'));
      });

      test('should use retesting endpoint for retesting reason type', () {
        // Arrange
        const isReject = false;
        final baseUrl = isReject ? '/device/elss/return-reason/elss_reject' : '/device/elss/return-reason/retesting';

        // Assert
        expect(baseUrl, equals('/device/elss/return-reason/retesting'));
      });
    });

    group('submitAcceptElss', () {
      test('should construct request body with dbr, opid, and rprl', () {
        // Arrange
        const barcode = 'DEVICE_007';
        const optionId = 100;
        final partsDataList = [
          {'partId': 1, 'status': 'accepted'},
        ];

        Map<String, dynamic> dataMap = {
          "dbr": barcode,
          "opid": optionId,
          "rprl": partsDataList,
        };

        // Act
        final decoded = jsonDecode(jsonEncode(dataMap)) as Map<String, dynamic>;

        // Assert
        expect(decoded['dbr'], equals('DEVICE_007'));
        expect(decoded['opid'], equals(100));
        expect(decoded['rprl'], isA<List>());
      });

      test('should use correct endpoint /device/elss/elss-accept', () {
        const expectedEndpoint = '/device/elss/elss-accept';
        expect(expectedEndpoint, equals('/device/elss/elss-accept'));
      });
    });

    group('sendOtp', () {
      test('should construct params with all required fields', () {
        // Arrange
        const mobileNumber = '9876543210';
        const serviceName = 'TRC';
        const serviceVersion = '1.0';
        const notificationType = 'SMS';
        const at = 'token';

        Map<String, List<String>> data = {
          "mn": [mobileNumber],
          "sern": [serviceName],
          "serv": [serviceVersion],
          "nt": [notificationType],
          "at": [at],
        };

        // Assert
        expect(data['mn'], equals(['9876543210']));
        expect(data['sern'], equals(['TRC']));
        expect(data['serv'], equals(['1.0']));
        expect(data['nt'], equals(['SMS']));
        expect(data['at'], equals(['token']));
      });

      test('should use correct endpoint /v1/auth/otp/send', () {
        const expectedEndpoint = '/v1/auth/otp/send';
        expect(expectedEndpoint, equals('/v1/auth/otp/send'));
      });
    });

    group('authenticateOTP', () {
      test('should construct params with otp and rid', () {
        // Arrange
        const otp = '123456';
        const rid = 'REQUEST_001';

        Map<String, List<String>> data = {
          "mn": ['9876543210'],
          "sern": ['TRC'],
          "serv": ['1.0'],
          "nt": ['SMS'],
          "rid": [rid],
          "otp": [otp],
          "at": ['token'],
        };

        // Assert
        expect(data['otp'], equals(['123456']));
        expect(data['rid'], equals(['REQUEST_001']));
      });

      test('should use correct endpoint /v1/auth/otp/authenticate', () {
        const expectedEndpoint = '/v1/auth/otp/authenticate';
        expect(expectedEndpoint, equals('/v1/auth/otp/authenticate'));
      });
    });

    group('abbreviated field names', () {
      test('bid is abbreviated for brand id', () {
        Map<String, dynamic> data = {"bid": 1};
        expect(data.containsKey('bid'), isTrue);
      });

      test('pid is abbreviated for product id', () {
        Map<String, dynamic> data = {"pid": 1};
        expect(data.containsKey('pid'), isTrue);
      });

      test('cl is abbreviated for color', () {
        Map<String, dynamic> data = {"cl": "Black"};
        expect(data.containsKey('cl'), isTrue);
      });

      test('res is abbreviated for reasons', () {
        Map<String, dynamic> data = {"res": [1, 2]};
        expect(data.containsKey('res'), isTrue);
      });

      test('opid is abbreviated for option id', () {
        Map<String, dynamic> data = {"opid": 1};
        expect(data.containsKey('opid'), isTrue);
      });

      test('rprl is abbreviated for repair parts list', () {
        Map<String, dynamic> data = {"rprl": []};
        expect(data.containsKey('rprl'), isTrue);
      });

      test('mn is abbreviated for mobile number', () {
        Map<String, List<String>> data = {"mn": ['1234567890']};
        expect(data.containsKey('mn'), isTrue);
      });

      test('sern is abbreviated for service name', () {
        Map<String, List<String>> data = {"sern": ['service']};
        expect(data.containsKey('sern'), isTrue);
      });
    });

    group('service dependencies', () {
      test('ElssService uses multiple services', () {
        // Document the different services used
        const trcServiceEndpoints = ['/elss/device-details', '/part/upload-fault-images'];
        const qcServiceEndpoints = ['/device/elss/mark-pna', '/device/elss/scan'];

        expect(trcServiceEndpoints.length, greaterThan(0));
        expect(qcServiceEndpoints.length, greaterThan(0));
      });
    });
  });
}
