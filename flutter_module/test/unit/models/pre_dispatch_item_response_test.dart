import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/pre_dispatch/resources/pre_dispatch_item_response.dart';

void main() {
  group('PreDispatchItemResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'dt': [
            {
              'id': 1,
              'did': 1001,
              'mpid': 2001,
              'qr_code': 'QR-001',
              'm': 'iPhone 13',
              'b': 'Apple',
              'im': '123456789012345',
              's': 1,
              'gr': 'A',
              'pt': 'iPhone 13 128GB Black',
              'ta': 30,
              'sd': 'Ready for dispatch',
            },
          ],
          'tc': 100,
          'success': true,
          's': true,
        };

        // Act
        final response = PreDispatchItemResponse.fromJson(json);

        // Assert
        expect(response.items, isNotNull);
        expect(response.items!.length, 1);
        expect(response.totalCount, 100);
        expect(response.success, true);
        expect(response.status, true);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = PreDispatchItemResponse.fromJson(json);

        // Assert
        expect(response.items, isNull);
        expect(response.totalCount, isNull);
        expect(response.success, isNull);
        expect(response.status, isNull);
      });

      test('should handle empty data array', () {
        // Arrange
        final json = {
          'dt': <Map<String, dynamic>>[],
          'tc': 0,
          'success': true,
          's': true,
        };

        // Act
        final response = PreDispatchItemResponse.fromJson(json);

        // Assert
        expect(response.items, isEmpty);
        expect(response.totalCount, 0);
      });

      test('should parse multiple items', () {
        // Arrange
        final json = {
          'dt': [
            {'id': 1, 'qr_code': 'QR-001'},
            {'id': 2, 'qr_code': 'QR-002'},
            {'id': 3, 'qr_code': 'QR-003'},
          ],
          'tc': 3,
        };

        // Act
        final response = PreDispatchItemResponse.fromJson(json);

        // Assert
        expect(response.items!.length, 3);
        expect(response.items![0]?.id, 1);
        expect(response.items![1]?.id, 2);
        expect(response.items![2]?.id, 3);
      });

      test('should handle false success and status', () {
        // Arrange
        final json = {
          'dt': [],
          'tc': 0,
          'success': false,
          's': false,
        };

        // Act
        final response = PreDispatchItemResponse.fromJson(json);

        // Assert
        expect(response.success, false);
        expect(response.status, false);
      });

      test('should handle partial response data', () {
        // Arrange
        final json = {
          'tc': 50,
          'success': true,
        };

        // Act
        final response = PreDispatchItemResponse.fromJson(json);

        // Assert
        expect(response.items, isNull);
        expect(response.totalCount, 50);
        expect(response.success, true);
        expect(response.status, isNull);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final item = PreDispatchItem(
          id: 100,
          deviceId: 200,
          qrCode: 'TEST-QR',
        );
        final response = PreDispatchItemResponse(
          items: [item],
          totalCount: 1,
          success: true,
          status: true,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], isA<List>());
        expect((json['dt'] as List).length, 1);
        expect(json['tc'], 1);
        expect(json['success'], true);
        expect(json['s'], true);
      });

      test('should serialize null values correctly', () {
        // Arrange
        final response = PreDispatchItemResponse();

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], isNull);
        expect(json['tc'], isNull);
        expect(json['success'], isNull);
        expect(json['s'], isNull);
      });

      test('should serialize empty items list', () {
        // Arrange
        final response = PreDispatchItemResponse(items: []);

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], isEmpty);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange
        final items = [
          PreDispatchItem(id: 1),
          PreDispatchItem(id: 2),
        ];

        // Act
        final response = PreDispatchItemResponse(
          items: items,
          totalCount: 100,
          success: true,
          status: true,
        );

        // Assert
        expect(response.items!.length, 2);
        expect(response.totalCount, 100);
        expect(response.success, true);
        expect(response.status, true);
      });

      test('should create instance with no parameters', () {
        // Act
        final response = PreDispatchItemResponse();

        // Assert
        expect(response.items, isNull);
        expect(response.totalCount, isNull);
        expect(response.success, isNull);
        expect(response.status, isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'dt': [
            {'id': 500, 'qr_code': 'ROUNDTRIP-QR'},
          ],
          'tc': 25,
          'success': true,
          's': true,
        };

        // Act
        final response = PreDispatchItemResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['tc'], originalJson['tc']);
        expect(serializedJson['success'], originalJson['success']);
        expect(serializedJson['s'], originalJson['s']);
      });
    });
  });

  group('PreDispatchItem', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'id': 1001,
          'did': 2001,
          'mpid': 3001,
          'qr_code': 'DEVICE-QR-12345',
          'm': 'Galaxy S22',
          'b': 'Samsung',
          'im': '987654321098765',
          's': 1,
          'gr': 'A+',
          'pt': 'Samsung Galaxy S22 Ultra 256GB',
          'ta': 15,
          'sd': 'Quality check passed',
        };

        // Act
        final item = PreDispatchItem.fromJson(json);

        // Assert
        expect(item.id, 1001);
        expect(item.deviceId, 2001);
        expect(item.mpid, 3001);
        expect(item.qrCode, 'DEVICE-QR-12345');
        expect(item.model, 'Galaxy S22');
        expect(item.brand, 'Samsung');
        expect(item.imei, '987654321098765');
        expect(item.status, 1);
        expect(item.grade, 'A+');
        expect(item.productTitle, 'Samsung Galaxy S22 Ultra 256GB');
        expect(item.testAge, 15);
        expect(item.statusDescription, 'Quality check passed');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final item = PreDispatchItem.fromJson(json);

        // Assert
        expect(item.id, isNull);
        expect(item.deviceId, isNull);
        expect(item.mpid, isNull);
        expect(item.qrCode, isNull);
        expect(item.model, isNull);
        expect(item.brand, isNull);
        expect(item.imei, isNull);
        expect(item.status, isNull);
        expect(item.grade, isNull);
        expect(item.productTitle, isNull);
        expect(item.testAge, isNull);
        expect(item.statusDescription, isNull);
      });

      test('should handle partial fields', () {
        // Arrange
        final json = {
          'id': 999,
          'qr_code': 'PARTIAL-QR',
          'b': 'Apple',
          'm': 'iPhone 14',
        };

        // Act
        final item = PreDispatchItem.fromJson(json);

        // Assert
        expect(item.id, 999);
        expect(item.qrCode, 'PARTIAL-QR');
        expect(item.brand, 'Apple');
        expect(item.model, 'iPhone 14');
        expect(item.deviceId, isNull);
        expect(item.imei, isNull);
        expect(item.grade, isNull);
      });

      test('should handle zero values', () {
        // Arrange
        final json = {
          'id': 0,
          'did': 0,
          's': 0,
          'ta': 0,
        };

        // Act
        final item = PreDispatchItem.fromJson(json);

        // Assert
        expect(item.id, 0);
        expect(item.deviceId, 0);
        expect(item.status, 0);
        expect(item.testAge, 0);
      });

      test('should handle different status values', () {
        // Arrange
        final jsonStatus0 = {'s': 0};
        final jsonStatus1 = {'s': 1};
        final jsonStatus2 = {'s': 2};

        // Act
        final item0 = PreDispatchItem.fromJson(jsonStatus0);
        final item1 = PreDispatchItem.fromJson(jsonStatus1);
        final item2 = PreDispatchItem.fromJson(jsonStatus2);

        // Assert
        expect(item0.status, 0);
        expect(item1.status, 1);
        expect(item2.status, 2);
      });

      test('should handle different grade values', () {
        // Arrange
        final jsonGradeA = {'gr': 'A'};
        final jsonGradeB = {'gr': 'B'};
        final jsonGradeC = {'gr': 'C'};
        final jsonGradePlus = {'gr': 'A+'};

        // Act
        final itemA = PreDispatchItem.fromJson(jsonGradeA);
        final itemB = PreDispatchItem.fromJson(jsonGradeB);
        final itemC = PreDispatchItem.fromJson(jsonGradeC);
        final itemPlus = PreDispatchItem.fromJson(jsonGradePlus);

        // Assert
        expect(itemA.grade, 'A');
        expect(itemB.grade, 'B');
        expect(itemC.grade, 'C');
        expect(itemPlus.grade, 'A+');
      });

      test('should handle negative test age', () {
        // Arrange (edge case, though unlikely in production)
        final json = {
          'ta': -1,
        };

        // Act
        final item = PreDispatchItem.fromJson(json);

        // Assert
        expect(item.testAge, -1);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final item = PreDispatchItem(
          id: 5001,
          deviceId: 6001,
          mpid: 7001,
          qrCode: 'SERIALIZE-QR',
          model: 'Pixel 7',
          brand: 'Google',
          imei: '111222333444555',
          status: 1,
          grade: 'A',
          productTitle: 'Google Pixel 7 Pro 128GB',
          testAge: 7,
          statusDescription: 'Serialization test',
        );

        // Act
        final json = item.toJson();

        // Assert
        expect(json['id'], 5001);
        expect(json['did'], 6001);
        expect(json['mpid'], 7001);
        expect(json['qr_code'], 'SERIALIZE-QR');
        expect(json['m'], 'Pixel 7');
        expect(json['b'], 'Google');
        expect(json['im'], '111222333444555');
        expect(json['s'], 1);
        expect(json['gr'], 'A');
        expect(json['pt'], 'Google Pixel 7 Pro 128GB');
        expect(json['ta'], 7);
        expect(json['sd'], 'Serialization test');
      });

      test('should serialize null values correctly', () {
        // Arrange
        final item = PreDispatchItem();

        // Act
        final json = item.toJson();

        // Assert
        expect(json['id'], isNull);
        expect(json['did'], isNull);
        expect(json['mpid'], isNull);
        expect(json['qr_code'], isNull);
        expect(json['m'], isNull);
        expect(json['b'], isNull);
        expect(json['im'], isNull);
        expect(json['s'], isNull);
        expect(json['gr'], isNull);
        expect(json['pt'], isNull);
        expect(json['ta'], isNull);
        expect(json['sd'], isNull);
      });

      test('should serialize partial values correctly', () {
        // Arrange
        final item = PreDispatchItem(
          id: 123,
          qrCode: 'PARTIAL-SERIALIZE',
          brand: 'OnePlus',
        );

        // Act
        final json = item.toJson();

        // Assert
        expect(json['id'], 123);
        expect(json['qr_code'], 'PARTIAL-SERIALIZE');
        expect(json['b'], 'OnePlus');
        expect(json['m'], isNull);
        expect(json['did'], isNull);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final item = PreDispatchItem(
          id: 8001,
          deviceId: 9001,
          mpid: 10001,
          qrCode: 'CONSTRUCTOR-QR',
          model: 'OnePlus 11',
          brand: 'OnePlus',
          imei: '555666777888999',
          status: 2,
          grade: 'B+',
          productTitle: 'OnePlus 11 5G 256GB',
          testAge: 21,
          statusDescription: 'Constructor test item',
        );

        // Assert
        expect(item.id, 8001);
        expect(item.deviceId, 9001);
        expect(item.mpid, 10001);
        expect(item.qrCode, 'CONSTRUCTOR-QR');
        expect(item.model, 'OnePlus 11');
        expect(item.brand, 'OnePlus');
        expect(item.imei, '555666777888999');
        expect(item.status, 2);
        expect(item.grade, 'B+');
        expect(item.productTitle, 'OnePlus 11 5G 256GB');
        expect(item.testAge, 21);
        expect(item.statusDescription, 'Constructor test item');
      });

      test('should create instance with no parameters', () {
        // Act
        final item = PreDispatchItem();

        // Assert
        expect(item.id, isNull);
        expect(item.deviceId, isNull);
        expect(item.mpid, isNull);
        expect(item.qrCode, isNull);
        expect(item.model, isNull);
        expect(item.brand, isNull);
        expect(item.imei, isNull);
        expect(item.status, isNull);
        expect(item.grade, isNull);
        expect(item.productTitle, isNull);
        expect(item.testAge, isNull);
        expect(item.statusDescription, isNull);
      });

      test('should create instance with minimal parameters', () {
        // Act
        final item = PreDispatchItem(
          id: 1,
          qrCode: 'MINIMAL-QR',
        );

        // Assert
        expect(item.id, 1);
        expect(item.qrCode, 'MINIMAL-QR');
        expect(item.deviceId, isNull);
        expect(item.brand, isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'id': 11001,
          'did': 12001,
          'mpid': 13001,
          'qr_code': 'ROUNDTRIP-ITEM-QR',
          'm': 'Xiaomi 13',
          'b': 'Xiaomi',
          'im': '999888777666555',
          's': 1,
          'gr': 'A',
          'pt': 'Xiaomi 13 Pro 512GB',
          'ta': 45,
          'sd': 'Roundtrip test device',
        };

        // Act
        final item = PreDispatchItem.fromJson(originalJson);
        final serializedJson = item.toJson();

        // Assert
        expect(serializedJson['id'], originalJson['id']);
        expect(serializedJson['did'], originalJson['did']);
        expect(serializedJson['mpid'], originalJson['mpid']);
        expect(serializedJson['qr_code'], originalJson['qr_code']);
        expect(serializedJson['m'], originalJson['m']);
        expect(serializedJson['b'], originalJson['b']);
        expect(serializedJson['im'], originalJson['im']);
        expect(serializedJson['s'], originalJson['s']);
        expect(serializedJson['gr'], originalJson['gr']);
        expect(serializedJson['pt'], originalJson['pt']);
        expect(serializedJson['ta'], originalJson['ta']);
        expect(serializedJson['sd'], originalJson['sd']);
      });
    });

    group('edge cases', () {
      test('should handle empty string values', () {
        // Arrange
        final json = {
          'qr_code': '',
          'm': '',
          'b': '',
          'im': '',
          'gr': '',
          'pt': '',
          'sd': '',
        };

        // Act
        final item = PreDispatchItem.fromJson(json);

        // Assert
        expect(item.qrCode, '');
        expect(item.model, '');
        expect(item.brand, '');
        expect(item.imei, '');
        expect(item.grade, '');
        expect(item.productTitle, '');
        expect(item.statusDescription, '');
      });

      test('should handle large id values', () {
        // Arrange
        final json = {
          'id': 999999999,
          'did': 888888888,
          'mpid': 777777777,
        };

        // Act
        final item = PreDispatchItem.fromJson(json);

        // Assert
        expect(item.id, 999999999);
        expect(item.deviceId, 888888888);
        expect(item.mpid, 777777777);
      });

      test('should handle long IMEI string', () {
        // Arrange
        final json = {
          'im': '123456789012345678901234567890',
        };

        // Act
        final item = PreDispatchItem.fromJson(json);

        // Assert
        expect(item.imei, '123456789012345678901234567890');
      });

      test('should handle long product title', () {
        // Arrange
        final longTitle = 'A' * 500;
        final json = {
          'pt': longTitle,
        };

        // Act
        final item = PreDispatchItem.fromJson(json);

        // Assert
        expect(item.productTitle, longTitle);
        expect(item.productTitle!.length, 500);
      });

      test('should handle special characters in strings', () {
        // Arrange
        final json = {
          'qr_code': 'QR-!@#\$%^&*()',
          'pt': 'Product with "quotes" and \'apostrophes\'',
          'sd': 'Status with\nnewline',
        };

        // Act
        final item = PreDispatchItem.fromJson(json);

        // Assert
        expect(item.qrCode, 'QR-!@#\$%^&*()');
        expect(item.productTitle, 'Product with "quotes" and \'apostrophes\'');
        expect(item.statusDescription, 'Status with\nnewline');
      });
    });
  });
}
