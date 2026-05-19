import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/models/stock_in_submit_request.dart';

/// Tests for StockInSubmitRequest, SelectionData, and AccessoriesData models.
/// Focus: Testing fromJson/toJson for stock-in submission with nested objects.
void main() {
  group('StockInSubmitRequest', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'awb': 'AWB123456789',
          'qrcode': 'QR-DEVICE-001',
          'selection': [
            {
              'gl': 'Condition',
              'k': 'screen_damage',
              'v': 1,
            }
          ],
          'bctr': {
            's': 'warehouse',
            'qr': 'ACC-QR-001',
            'hb': 1,
            'hc': 1,
            'hbc': 1,
            'a': 'track',
          },
        };

        // Act
        final request = StockInSubmitRequest.fromJson(json);

        // Assert
        expect(request.awbNumber, 'AWB123456789');
        expect(request.qrcode, 'QR-DEVICE-001');
        expect(request.selection, isNotNull);
        expect(request.selection!.length, 1);
        expect(request.barcodeChargerTracking, isNotNull);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final request = StockInSubmitRequest.fromJson(json);

        // Assert
        expect(request.awbNumber, null);
        expect(request.qrcode, null);
        expect(request.selection, null);
        expect(request.barcodeChargerTracking, null);
      });

      test('should handle null awb only', () {
        // Arrange
        final json = {
          'awb': null,
          'qrcode': 'QR-001',
        };

        // Act
        final request = StockInSubmitRequest.fromJson(json);

        // Assert
        expect(request.awbNumber, null);
        expect(request.qrcode, 'QR-001');
      });

      test('should handle null qrcode only', () {
        // Arrange
        final json = {
          'awb': 'AWB-001',
          'qrcode': null,
        };

        // Act
        final request = StockInSubmitRequest.fromJson(json);

        // Assert
        expect(request.awbNumber, 'AWB-001');
        expect(request.qrcode, null);
      });

      test('should handle empty selection list', () {
        // Arrange
        final json = {
          'awb': 'AWB-001',
          'selection': <Map<String, dynamic>>[],
        };

        // Act
        final request = StockInSubmitRequest.fromJson(json);

        // Assert
        expect(request.selection, isNotNull);
        expect(request.selection!.length, 0);
      });

      test('should handle multiple selection items', () {
        // Arrange
        final json = {
          'selection': [
            {'gl': 'Group1', 'k': 'key1', 'v': 1},
            {'gl': 'Group2', 'k': 'key2', 'v': 2},
            {'gl': 'Group3', 'k': 'key3', 'v': 3},
          ],
        };

        // Act
        final request = StockInSubmitRequest.fromJson(json);

        // Assert
        expect(request.selection!.length, 3);
        expect(request.selection![0].groupLabel, 'Group1');
        expect(request.selection![1].groupLabel, 'Group2');
        expect(request.selection![2].groupLabel, 'Group3');
      });

      test('should handle null bctr', () {
        // Arrange
        final json = {
          'awb': 'AWB-001',
          'bctr': null,
        };

        // Act
        final request = StockInSubmitRequest.fromJson(json);

        // Assert
        expect(request.barcodeChargerTracking, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final request = StockInSubmitRequest(
          awbNumber: 'AWB-SERIALIZE-001',
          qrcode: 'QR-SERIALIZE-001',
          selection: [
            SelectionData(groupLabel: 'TestGroup', key: 'test_key', value: 5),
          ],
          barcodeChargerTracking: AccessoriesData(
            source: 'test_source',
            qrCode: 'ACC-QR-001',
            hasBox: 1,
            hasCharger: 1,
            hasBoxCharger: 0,
            action: 'create',
          ),
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['awb'], 'AWB-SERIALIZE-001');
        expect(json['qrcode'], 'QR-SERIALIZE-001');
        expect(json['selection'], isNotNull);
        expect(json['bctr'], isNotNull);
      });

      test('should handle null fields in serialization', () {
        // Arrange
        final request = StockInSubmitRequest();

        // Act
        final json = request.toJson();

        // Assert
        expect(json['awb'], null);
        expect(json['qrcode'], null);
        expect(json['selection'], null);
        expect(json['bctr'], null);
      });

      test('should serialize empty selection list', () {
        // Arrange
        final request = StockInSubmitRequest(
          selection: [],
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['selection'], isNotNull);
        expect((json['selection'] as List).length, 0);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final request = StockInSubmitRequest(
          awbNumber: 'AWB-CONST-001',
          qrcode: 'QR-CONST-001',
          selection: [SelectionData(key: 'test')],
          barcodeChargerTracking: AccessoriesData(source: 'test'),
        );

        // Assert
        expect(request.awbNumber, 'AWB-CONST-001');
        expect(request.qrcode, 'QR-CONST-001');
        expect(request.selection, isNotNull);
        expect(request.barcodeChargerTracking, isNotNull);
      });

      test('should create instance with no parameters', () {
        // Act
        final request = StockInSubmitRequest();

        // Assert
        expect(request.awbNumber, null);
        expect(request.qrcode, null);
        expect(request.selection, null);
        expect(request.barcodeChargerTracking, null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'awb': 'AWB-ROUND-001',
          'qrcode': 'QR-ROUND-001',
          'selection': [
            {'gl': 'Cosmetic', 'k': 'scratch', 'v': 2},
          ],
          'bctr': {
            's': 'return',
            'qr': 'TRACK-001',
            'hb': 1,
            'hc': 0,
            'hbc': 0,
            'a': 'update',
          },
        };

        // Act
        final request = StockInSubmitRequest.fromJson(originalJson);
        final serialized = request.toJson();

        // Assert
        expect(serialized['awb'], originalJson['awb']);
        expect(serialized['qrcode'], originalJson['qrcode']);
      });
    });
  });

  group('SelectionData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'gl': 'Physical Condition',
          'k': 'screen_crack',
          'v': 3,
          'imgs': ['https://example.com/img1.jpg', 'https://example.com/img2.jpg'],
          'vids': ['https://example.com/vid1.mp4'],
        };

        // Act
        final selection = SelectionData.fromJson(json);

        // Assert
        expect(selection.groupLabel, 'Physical Condition');
        expect(selection.key, 'screen_crack');
        expect(selection.value, 3);
        expect(selection.imgList, isNotNull);
        expect(selection.imgList!.length, 2);
        expect(selection.videoList, isNotNull);
        expect(selection.videoList!.length, 1);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final selection = SelectionData.fromJson(json);

        // Assert
        expect(selection.groupLabel, null);
        expect(selection.key, null);
        expect(selection.value, null);
        expect(selection.imgList, null);
        expect(selection.videoList, null);
      });

      test('should handle empty image list', () {
        // Arrange
        final json = {
          'k': 'test',
          'imgs': <String>[],
        };

        // Act
        final selection = SelectionData.fromJson(json);

        // Assert
        expect(selection.imgList, isNotNull);
        expect(selection.imgList!.length, 0);
      });

      test('should handle empty video list', () {
        // Arrange
        final json = {
          'k': 'test',
          'vids': <String>[],
        };

        // Act
        final selection = SelectionData.fromJson(json);

        // Assert
        expect(selection.videoList, isNotNull);
        expect(selection.videoList!.length, 0);
      });

      test('should handle null values in image list', () {
        // Arrange
        final json = {
          'imgs': ['https://example.com/img1.jpg', null, 'https://example.com/img2.jpg'],
        };

        // Act
        final selection = SelectionData.fromJson(json);

        // Assert
        expect(selection.imgList!.length, 3);
        expect(selection.imgList![0], 'https://example.com/img1.jpg');
        expect(selection.imgList![1], null);
        expect(selection.imgList![2], 'https://example.com/img2.jpg');
      });

      test('should handle null values in video list', () {
        // Arrange
        final json = {
          'vids': [null, 'https://example.com/vid1.mp4'],
        };

        // Act
        final selection = SelectionData.fromJson(json);

        // Assert
        expect(selection.videoList!.length, 2);
        expect(selection.videoList![0], null);
        expect(selection.videoList![1], 'https://example.com/vid1.mp4');
      });

      test('should handle zero value', () {
        // Arrange
        final json = {
          'v': 0,
        };

        // Act
        final selection = SelectionData.fromJson(json);

        // Assert
        expect(selection.value, 0);
      });

      test('should handle negative value', () {
        // Arrange
        final json = {
          'v': -1,
        };

        // Act
        final selection = SelectionData.fromJson(json);

        // Assert
        expect(selection.value, -1);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly with includeIfNull false', () {
        // Arrange
        final selection = SelectionData(
          groupLabel: 'Test Group',
          key: 'test_key',
          value: 5,
          imgList: ['img1.jpg', 'img2.jpg'],
          videoList: ['vid1.mp4'],
        );

        // Act
        final json = selection.toJson();

        // Assert
        expect(json['gl'], 'Test Group');
        expect(json['k'], 'test_key');
        expect(json['v'], 5);
        expect(json['imgs'], ['img1.jpg', 'img2.jpg']);
        expect(json['vids'], ['vid1.mp4']);
      });

      test('should exclude null fields due to includeIfNull false', () {
        // Arrange
        final selection = SelectionData();

        // Act
        final json = selection.toJson();

        // Assert
        // With includeIfNull: false, null fields should not be in JSON
        expect(json.containsKey('gl'), false);
        expect(json.containsKey('k'), false);
        expect(json.containsKey('v'), false);
        expect(json.containsKey('imgs'), false);
        expect(json.containsKey('vids'), false);
      });

      test('should only include non-null fields', () {
        // Arrange
        final selection = SelectionData(
          key: 'only_key',
          value: 10,
        );

        // Act
        final json = selection.toJson();

        // Assert
        expect(json.containsKey('k'), true);
        expect(json.containsKey('v'), true);
        expect(json.containsKey('gl'), false);
        expect(json.containsKey('imgs'), false);
        expect(json.containsKey('vids'), false);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final selection = SelectionData(
          groupLabel: 'Const Group',
          key: 'const_key',
          value: 7,
          imgList: ['img.jpg'],
          videoList: ['vid.mp4'],
        );

        // Assert
        expect(selection.groupLabel, 'Const Group');
        expect(selection.key, 'const_key');
        expect(selection.value, 7);
        expect(selection.imgList!.length, 1);
        expect(selection.videoList!.length, 1);
      });

      test('should create instance with no parameters', () {
        // Act
        final selection = SelectionData();

        // Assert
        expect(selection.groupLabel, null);
        expect(selection.key, null);
        expect(selection.value, null);
        expect(selection.imgList, null);
        expect(selection.videoList, null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain non-null data through cycle', () {
        // Arrange
        final originalJson = {
          'gl': 'Round Trip Group',
          'k': 'round_key',
          'v': 15,
          'imgs': ['https://cdn.example.com/image.jpg'],
          'vids': ['https://cdn.example.com/video.mp4'],
        };

        // Act
        final selection = SelectionData.fromJson(originalJson);
        final serialized = selection.toJson();

        // Assert
        expect(serialized['gl'], originalJson['gl']);
        expect(serialized['k'], originalJson['k']);
        expect(serialized['v'], originalJson['v']);
        expect(serialized['imgs'], originalJson['imgs']);
        expect(serialized['vids'], originalJson['vids']);
      });
    });

    group('edge cases', () {
      test('should handle empty string groupLabel', () {
        // Arrange
        final json = {'gl': ''};

        // Act
        final selection = SelectionData.fromJson(json);

        // Assert
        expect(selection.groupLabel, '');
      });

      test('should handle special characters in key', () {
        // Arrange
        final json = {'k': 'screen_damage_level_1'};

        // Act
        final selection = SelectionData.fromJson(json);

        // Assert
        expect(selection.key, 'screen_damage_level_1');
      });

      test('should handle large value', () {
        // Arrange
        final json = {'v': 999999999};

        // Act
        final selection = SelectionData.fromJson(json);

        // Assert
        expect(selection.value, 999999999);
      });

      test('should handle many images', () {
        // Arrange
        final imageList = List.generate(50, (i) => 'https://example.com/img$i.jpg');
        final json = {'imgs': imageList};

        // Act
        final selection = SelectionData.fromJson(json);

        // Assert
        expect(selection.imgList!.length, 50);
      });

      test('should handle S3 URLs in image list', () {
        // Arrange
        final json = {
          'imgs': [
            'https://bucket.s3.amazonaws.com/images/device-001.jpg?token=abc123',
          ],
        };

        // Act
        final selection = SelectionData.fromJson(json);

        // Assert
        expect(selection.imgList![0]!.contains('s3'), true);
      });
    });
  });

  group('AccessoriesData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          's': 'warehouse_return',
          'qr': 'ACC-QR-123456',
          'hb': 1,
          'hc': 1,
          'hbc': 1,
          'a': 'create_tracking',
        };

        // Act
        final accessories = AccessoriesData.fromJson(json);

        // Assert
        expect(accessories.source, 'warehouse_return');
        expect(accessories.qrCode, 'ACC-QR-123456');
        expect(accessories.hasBox, 1);
        expect(accessories.hasCharger, 1);
        expect(accessories.hasBoxCharger, 1);
        expect(accessories.action, 'create_tracking');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final accessories = AccessoriesData.fromJson(json);

        // Assert
        expect(accessories.source, null);
        expect(accessories.qrCode, null);
        expect(accessories.hasBox, null);
        expect(accessories.hasCharger, null);
        expect(accessories.hasBoxCharger, null);
        expect(accessories.action, null);
      });

      test('should handle zero values for has fields', () {
        // Arrange
        final json = {
          'hb': 0,
          'hc': 0,
          'hbc': 0,
        };

        // Act
        final accessories = AccessoriesData.fromJson(json);

        // Assert
        expect(accessories.hasBox, 0);
        expect(accessories.hasCharger, 0);
        expect(accessories.hasBoxCharger, 0);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          's': 'partial_source',
          'hc': 1,
        };

        // Act
        final accessories = AccessoriesData.fromJson(json);

        // Assert
        expect(accessories.source, 'partial_source');
        expect(accessories.hasCharger, 1);
        expect(accessories.qrCode, null);
        expect(accessories.hasBox, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly with includeIfNull false', () {
        // Arrange
        final accessories = AccessoriesData(
          source: 'test_source',
          qrCode: 'TEST-QR-001',
          hasBox: 1,
          hasCharger: 1,
          hasBoxCharger: 0,
          action: 'update',
        );

        // Act
        final json = accessories.toJson();

        // Assert
        expect(json['s'], 'test_source');
        expect(json['qr'], 'TEST-QR-001');
        expect(json['hb'], 1);
        expect(json['hc'], 1);
        expect(json['hbc'], 0);
        expect(json['a'], 'update');
      });

      test('should exclude null fields due to includeIfNull false', () {
        // Arrange
        final accessories = AccessoriesData();

        // Act
        final json = accessories.toJson();

        // Assert
        expect(json.containsKey('s'), false);
        expect(json.containsKey('qr'), false);
        expect(json.containsKey('hb'), false);
        expect(json.containsKey('hc'), false);
        expect(json.containsKey('hbc'), false);
        expect(json.containsKey('a'), false);
      });

      test('should only include non-null fields', () {
        // Arrange
        final accessories = AccessoriesData(
          hasBox: 1,
          hasCharger: 0,
        );

        // Act
        final json = accessories.toJson();

        // Assert
        expect(json.containsKey('hb'), true);
        expect(json.containsKey('hc'), true);
        expect(json.containsKey('s'), false);
        expect(json.containsKey('qr'), false);
        expect(json.containsKey('hbc'), false);
        expect(json.containsKey('a'), false);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final accessories = AccessoriesData(
          source: 'full_source',
          qrCode: 'FULL-QR-001',
          hasBox: 1,
          hasCharger: 1,
          hasBoxCharger: 1,
          action: 'complete',
        );

        // Assert
        expect(accessories.source, 'full_source');
        expect(accessories.qrCode, 'FULL-QR-001');
        expect(accessories.hasBox, 1);
        expect(accessories.hasCharger, 1);
        expect(accessories.hasBoxCharger, 1);
        expect(accessories.action, 'complete');
      });

      test('should create instance with no parameters', () {
        // Act
        final accessories = AccessoriesData();

        // Assert
        expect(accessories.source, null);
        expect(accessories.qrCode, null);
        expect(accessories.hasBox, null);
        expect(accessories.hasCharger, null);
        expect(accessories.hasBoxCharger, null);
        expect(accessories.action, null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain non-null data through cycle', () {
        // Arrange
        final originalJson = {
          's': 'round_source',
          'qr': 'ROUND-QR-001',
          'hb': 1,
          'hc': 0,
          'hbc': 1,
          'a': 'track',
        };

        // Act
        final accessories = AccessoriesData.fromJson(originalJson);
        final serialized = accessories.toJson();

        // Assert
        expect(serialized['s'], originalJson['s']);
        expect(serialized['qr'], originalJson['qr']);
        expect(serialized['hb'], originalJson['hb']);
        expect(serialized['hc'], originalJson['hc']);
        expect(serialized['hbc'], originalJson['hbc']);
        expect(serialized['a'], originalJson['a']);
      });
    });

    group('edge cases', () {
      test('should handle empty string source', () {
        // Arrange
        final json = {'s': ''};

        // Act
        final accessories = AccessoriesData.fromJson(json);

        // Assert
        expect(accessories.source, '');
      });

      test('should handle empty string qrCode', () {
        // Arrange
        final json = {'qr': ''};

        // Act
        final accessories = AccessoriesData.fromJson(json);

        // Assert
        expect(accessories.qrCode, '');
      });

      test('should handle empty string action', () {
        // Arrange
        final json = {'a': ''};

        // Act
        final accessories = AccessoriesData.fromJson(json);

        // Assert
        expect(accessories.action, '');
      });

      test('should handle large integer values', () {
        // Arrange
        final json = {
          'hb': 999,
          'hc': 999,
          'hbc': 999,
        };

        // Act
        final accessories = AccessoriesData.fromJson(json);

        // Assert
        expect(accessories.hasBox, 999);
        expect(accessories.hasCharger, 999);
        expect(accessories.hasBoxCharger, 999);
      });

      test('should handle negative integer values', () {
        // Arrange
        final json = {
          'hb': -1,
          'hc': -1,
          'hbc': -1,
        };

        // Act
        final accessories = AccessoriesData.fromJson(json);

        // Assert
        expect(accessories.hasBox, -1);
        expect(accessories.hasCharger, -1);
        expect(accessories.hasBoxCharger, -1);
      });

      test('should handle special characters in source', () {
        // Arrange
        final json = {'s': 'warehouse_return_v2_2024-01'};

        // Act
        final accessories = AccessoriesData.fromJson(json);

        // Assert
        expect(accessories.source, 'warehouse_return_v2_2024-01');
      });

      test('should handle different action types', () {
        // Arrange
        final createJson = {'a': 'create'};
        final updateJson = {'a': 'update'};
        final deleteJson = {'a': 'delete'};
        final trackJson = {'a': 'track'};

        // Act
        final createAcc = AccessoriesData.fromJson(createJson);
        final updateAcc = AccessoriesData.fromJson(updateJson);
        final deleteAcc = AccessoriesData.fromJson(deleteJson);
        final trackAcc = AccessoriesData.fromJson(trackJson);

        // Assert
        expect(createAcc.action, 'create');
        expect(updateAcc.action, 'update');
        expect(deleteAcc.action, 'delete');
        expect(trackAcc.action, 'track');
      });

      test('should handle long qrCode', () {
        // Arrange
        final longQr = 'ACC-QR-' + 'A' * 200;
        final json = {'qr': longQr};

        // Act
        final accessories = AccessoriesData.fromJson(json);

        // Assert
        expect(accessories.qrCode!.length, 207);
      });
    });

    group('boolean-like integer fields', () {
      test('should handle hasBox as 1 (true)', () {
        // Arrange
        final json = {'hb': 1};

        // Act
        final accessories = AccessoriesData.fromJson(json);

        // Assert
        expect(accessories.hasBox, 1);
      });

      test('should handle hasBox as 0 (false)', () {
        // Arrange
        final json = {'hb': 0};

        // Act
        final accessories = AccessoriesData.fromJson(json);

        // Assert
        expect(accessories.hasBox, 0);
      });

      test('should handle hasCharger as 1 (true)', () {
        // Arrange
        final json = {'hc': 1};

        // Act
        final accessories = AccessoriesData.fromJson(json);

        // Assert
        expect(accessories.hasCharger, 1);
      });

      test('should handle hasCharger as 0 (false)', () {
        // Arrange
        final json = {'hc': 0};

        // Act
        final accessories = AccessoriesData.fromJson(json);

        // Assert
        expect(accessories.hasCharger, 0);
      });

      test('should handle hasBoxCharger as 1 (true)', () {
        // Arrange
        final json = {'hbc': 1};

        // Act
        final accessories = AccessoriesData.fromJson(json);

        // Assert
        expect(accessories.hasBoxCharger, 1);
      });

      test('should handle hasBoxCharger as 0 (false)', () {
        // Arrange
        final json = {'hbc': 0};

        // Act
        final accessories = AccessoriesData.fromJson(json);

        // Assert
        expect(accessories.hasBoxCharger, 0);
      });
    });
  });
}
