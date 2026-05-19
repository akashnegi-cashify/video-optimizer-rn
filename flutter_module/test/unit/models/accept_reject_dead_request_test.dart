import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dead_repair/resources/accept_reject_dead_request.dart';
import 'package:flutter_trc/qc/modules/dead_repair/type.dart';

void main() {
  group('AcceptRejectDeadRequest', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'id': 123,
          'remark': 'Device inspection completed',
          'actionRemark': 'Approved for disposal',
          'skus': ['SKU-001', 'SKU-002'],
          'repairLevel': 'MAJOR',
        };

        // Act
        final request = AcceptRejectDeadRequest.fromJson(json);

        // Assert
        expect(request.markId, 123);
        expect(request.remark, 'Device inspection completed');
        expect(request.actionRemark, 'Approved for disposal');
        expect(request.skus, ['SKU-001', 'SKU-002']);
        expect(request.repairLevel, 'MAJOR');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final request = AcceptRejectDeadRequest.fromJson(json);

        // Assert
        expect(request.markId, isNull);
        expect(request.remark, isNull);
        expect(request.actionRemark, isNull);
        expect(request.skus, isNull);
        expect(request.repairLevel, isNull);
      });

      test('should handle partial fields', () {
        // Arrange
        final json = {
          'id': 456,
          'remark': 'Partial remark',
        };

        // Act
        final request = AcceptRejectDeadRequest.fromJson(json);

        // Assert
        expect(request.markId, 456);
        expect(request.remark, 'Partial remark');
        expect(request.actionRemark, isNull);
        expect(request.skus, isNull);
        expect(request.repairLevel, isNull);
      });

      test('should handle empty skus list', () {
        // Arrange
        final json = {
          'id': 789,
          'skus': <String>[],
        };

        // Act
        final request = AcceptRejectDeadRequest.fromJson(json);

        // Assert
        expect(request.skus, isNotNull);
        expect(request.skus!.isEmpty, true);
      });

      test('should handle single SKU in list', () {
        // Arrange
        final json = {
          'skus': ['SINGLE-SKU'],
        };

        // Act
        final request = AcceptRejectDeadRequest.fromJson(json);

        // Assert
        expect(request.skus, ['SINGLE-SKU']);
      });

      test('should handle zero markId', () {
        // Arrange
        final json = {
          'id': 0,
        };

        // Act
        final request = AcceptRejectDeadRequest.fromJson(json);

        // Assert
        expect(request.markId, 0);
      });

      test('should handle empty string values', () {
        // Arrange
        final json = {
          'remark': '',
          'actionRemark': '',
          'repairLevel': '',
        };

        // Act
        final request = AcceptRejectDeadRequest.fromJson(json);

        // Assert
        expect(request.remark, '');
        expect(request.actionRemark, '');
        expect(request.repairLevel, '');
      });

      test('should not parse requestType from JSON (excluded from JSON)', () {
        // Arrange
        final json = {
          'id': 123,
          'requestType': 1,  // This should be ignored
        };

        // Act
        final request = AcceptRejectDeadRequest.fromJson(json);

        // Assert
        expect(request.markId, 123);
        expect(request.requestType, isNull);  // Not parsed from JSON
      });
    });

    group('toJson', () {
      test('should serialize all JSON fields correctly', () {
        // Arrange
        final request = AcceptRejectDeadRequest(
          markId: 123,
          remark: 'Serialize remark',
          actionRemark: 'Serialize action',
          skus: ['SKU-A', 'SKU-B'],
          repairLevel: 'MINOR',
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['id'], 123);
        expect(json['remark'], 'Serialize remark');
        expect(json['actionRemark'], 'Serialize action');
        expect(json['skus'], ['SKU-A', 'SKU-B']);
        expect(json['repairLevel'], 'MINOR');
      });

      test('should not include null fields due to includeIfNull false', () {
        // Arrange
        final request = AcceptRejectDeadRequest();

        // Act
        final json = request.toJson();

        // Assert
        expect(json.containsKey('id'), false);
        expect(json.containsKey('remark'), false);
        expect(json.containsKey('actionRemark'), false);
        expect(json.containsKey('skus'), false);
        expect(json.containsKey('repairLevel'), false);
      });

      test('should not include requestType in JSON (excluded from JSON)', () {
        // Arrange
        final request = AcceptRejectDeadRequest(
          markId: 123,
          requestType: DeadDeviceRequestType.ACCEPT_DEAD,
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['id'], 123);
        expect(json.containsKey('requestType'), false);
      });

      test('should not include null markId', () {
        // Arrange
        final request = AcceptRejectDeadRequest(
          remark: 'Only remark',
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json.containsKey('id'), false);
        expect(json['remark'], 'Only remark');
      });

      test('should include empty skus list', () {
        // Arrange
        final request = AcceptRejectDeadRequest(
          markId: 100,
          skus: [],
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['id'], 100);
        expect(json['skus'], isNotNull);
        expect(json['skus'].isEmpty, true);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final request = AcceptRejectDeadRequest(
          markId: 999,
          remark: 'CTOR-REMARK',
          actionRemark: 'CTOR-ACTION',
          skus: ['SKU-1', 'SKU-2'],
          repairLevel: 'CRITICAL',
          requestType: DeadDeviceRequestType.REPAIR_DONE,
        );

        // Assert
        expect(request.markId, 999);
        expect(request.remark, 'CTOR-REMARK');
        expect(request.actionRemark, 'CTOR-ACTION');
        expect(request.skus, ['SKU-1', 'SKU-2']);
        expect(request.repairLevel, 'CRITICAL');
        expect(request.requestType, DeadDeviceRequestType.REPAIR_DONE);
      });

      test('should create instance with no parameters', () {
        // Act
        final request = AcceptRejectDeadRequest();

        // Assert
        expect(request.markId, isNull);
        expect(request.remark, isNull);
        expect(request.actionRemark, isNull);
        expect(request.skus, isNull);
        expect(request.repairLevel, isNull);
        expect(request.requestType, isNull);
      });

      test('should create instance with only markId and requestType', () {
        // Act
        final request = AcceptRejectDeadRequest(
          markId: 111,
          requestType: DeadDeviceRequestType.ACCEPT_DEAD,
        );

        // Assert
        expect(request.markId, 111);
        expect(request.requestType, DeadDeviceRequestType.ACCEPT_DEAD);
        expect(request.remark, isNull);
      });
    });

    group('requestType enum', () {
      test('should set ACCEPT_DEAD requestType', () {
        // Act
        final request = AcceptRejectDeadRequest(
          markId: 1,
          requestType: DeadDeviceRequestType.ACCEPT_DEAD,
        );

        // Assert
        expect(request.requestType, DeadDeviceRequestType.ACCEPT_DEAD);
        expect(request.requestType!.value, 1);
      });

      test('should set REPAIR_REJECT requestType', () {
        // Act
        final request = AcceptRejectDeadRequest(
          markId: 2,
          requestType: DeadDeviceRequestType.REPAIR_REJECT,
        );

        // Assert
        expect(request.requestType, DeadDeviceRequestType.REPAIR_REJECT);
        expect(request.requestType!.value, 2);
      });

      test('should set REPAIR_DONE requestType', () {
        // Act
        final request = AcceptRejectDeadRequest(
          markId: 3,
          requestType: DeadDeviceRequestType.REPAIR_DONE,
        );

        // Assert
        expect(request.requestType, DeadDeviceRequestType.REPAIR_DONE);
        expect(request.requestType!.value, 3);
      });

      test('requestType should not be serialized to JSON', () {
        // Arrange
        final request = AcceptRejectDeadRequest(
          markId: 123,
          requestType: DeadDeviceRequestType.ACCEPT_DEAD,
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json.containsKey('requestType'), false);
      });

      test('requestType should not be parsed from JSON', () {
        // Arrange - Even if requestType is in JSON, it should be ignored
        final json = {
          'id': 123,
        };

        // Act
        final request = AcceptRejectDeadRequest.fromJson(json);

        // Assert
        expect(request.requestType, isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain JSON data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'id': 555,
          'remark': 'RT-REMARK',
          'actionRemark': 'RT-ACTION',
          'skus': ['RT-SKU-1', 'RT-SKU-2'],
          'repairLevel': 'MEDIUM',
        };

        // Act
        final request = AcceptRejectDeadRequest.fromJson(originalJson);
        final serializedJson = request.toJson();
        final deserializedRequest = AcceptRejectDeadRequest.fromJson(serializedJson);

        // Assert
        expect(deserializedRequest.markId, request.markId);
        expect(deserializedRequest.remark, request.remark);
        expect(deserializedRequest.actionRemark, request.actionRemark);
        expect(deserializedRequest.skus, request.skus);
        expect(deserializedRequest.repairLevel, request.repairLevel);
      });

      test('should maintain data through roundtrip with partial fields', () {
        // Arrange
        final originalJson = {
          'id': 666,
          'remark': 'Partial roundtrip',
        };

        // Act
        final request = AcceptRejectDeadRequest.fromJson(originalJson);
        final serializedJson = request.toJson();

        // Assert
        expect(serializedJson['id'], 666);
        expect(serializedJson['remark'], 'Partial roundtrip');
        expect(serializedJson.containsKey('actionRemark'), false);
        expect(serializedJson.containsKey('skus'), false);
      });

      test('should handle roundtrip from constructor (excluding requestType)', () {
        // Arrange
        final original = AcceptRejectDeadRequest(
          markId: 777,
          remark: 'From constructor',
          requestType: DeadDeviceRequestType.REPAIR_DONE,  // This won't be serialized
        );

        // Act
        final json = original.toJson();
        final restored = AcceptRejectDeadRequest.fromJson(json);

        // Assert
        expect(restored.markId, original.markId);
        expect(restored.remark, original.remark);
        expect(restored.requestType, isNull);  // Not preserved through JSON
      });
    });

    group('edge cases', () {
      test('should handle very large markId', () {
        // Arrange
        final json = {
          'id': 9999999999,
        };

        // Act
        final request = AcceptRejectDeadRequest.fromJson(json);

        // Assert
        expect(request.markId, 9999999999);
      });

      test('should handle special characters in strings', () {
        // Arrange
        final json = {
          'remark': 'Remark with !@#\$%^&*() special chars',
          'actionRemark': 'Action with "quotes" and \'apostrophes\'',
          'repairLevel': 'LEVEL-!@#',
        };

        // Act
        final request = AcceptRejectDeadRequest.fromJson(json);

        // Assert
        expect(request.remark, 'Remark with !@#\$%^&*() special chars');
        expect(request.actionRemark, 'Action with "quotes" and \'apostrophes\'');
        expect(request.repairLevel, 'LEVEL-!@#');
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'remark': '备注信息',
          'actionRemark': 'कार्रवाई टिप्पणी',
          'repairLevel': '修复级别',
        };

        // Act
        final request = AcceptRejectDeadRequest.fromJson(json);

        // Assert
        expect(request.remark, '备注信息');
        expect(request.actionRemark, 'कार्रवाई टिप्पणी');
        expect(request.repairLevel, '修复级别');
      });

      test('should handle long string values', () {
        // Arrange
        final longString = 'A' * 1000;
        final json = {
          'remark': longString,
          'actionRemark': longString,
        };

        // Act
        final request = AcceptRejectDeadRequest.fromJson(json);

        // Assert
        expect(request.remark!.length, 1000);
        expect(request.actionRemark!.length, 1000);
      });

      test('should handle large skus list', () {
        // Arrange
        final manySkus = List.generate(100, (i) => 'SKU-$i');
        final json = {
          'skus': manySkus,
        };

        // Act
        final request = AcceptRejectDeadRequest.fromJson(json);

        // Assert
        expect(request.skus!.length, 100);
        expect(request.skus![0], 'SKU-0');
        expect(request.skus![99], 'SKU-99');
      });

      test('should handle skus with empty strings', () {
        // Arrange
        final json = {
          'skus': ['', 'SKU-1', ''],
        };

        // Act
        final request = AcceptRejectDeadRequest.fromJson(json);

        // Assert
        expect(request.skus, ['', 'SKU-1', '']);
      });

      test('should handle whitespace in strings', () {
        // Arrange
        final json = {
          'remark': '  Remark with spaces  ',
          'repairLevel': '\tLEVEL\n',
        };

        // Act
        final request = AcceptRejectDeadRequest.fromJson(json);

        // Assert
        expect(request.remark, '  Remark with spaces  ');
        expect(request.repairLevel, '\tLEVEL\n');
      });
    });

    group('typical usage scenarios', () {
      test('should create request for accepting dead device', () {
        // Arrange & Act
        final request = AcceptRejectDeadRequest(
          markId: 12345,
          actionRemark: 'Device approved for disposal',
          requestType: DeadDeviceRequestType.ACCEPT_DEAD,
        );
        final json = request.toJson();

        // Assert
        expect(json['id'], 12345);
        expect(json['actionRemark'], 'Device approved for disposal');
        expect(json.containsKey('requestType'), false);
      });

      test('should create request for rejecting repair', () {
        // Arrange & Act
        final request = AcceptRejectDeadRequest(
          markId: 67890,
          remark: 'Device cannot be repaired',
          actionRemark: 'Repair rejected - cost exceeds device value',
          requestType: DeadDeviceRequestType.REPAIR_REJECT,
        );
        final json = request.toJson();

        // Assert
        expect(json['id'], 67890);
        expect(json['remark'], 'Device cannot be repaired');
        expect(json['actionRemark'], 'Repair rejected - cost exceeds device value');
      });

      test('should create request for repair done with parts', () {
        // Arrange & Act
        final request = AcceptRejectDeadRequest(
          markId: 11111,
          actionRemark: 'Repair completed successfully',
          skus: ['SCREEN-IPHONE-14', 'BATTERY-IPHONE-14'],
          repairLevel: 'MAJOR',
          requestType: DeadDeviceRequestType.REPAIR_DONE,
        );
        final json = request.toJson();

        // Assert
        expect(json['id'], 11111);
        expect(json['actionRemark'], 'Repair completed successfully');
        expect(json['skus'], ['SCREEN-IPHONE-14', 'BATTERY-IPHONE-14']);
        expect(json['repairLevel'], 'MAJOR');
      });

      test('should create request with repair level only', () {
        // Arrange & Act
        final request = AcceptRejectDeadRequest(
          markId: 22222,
          repairLevel: 'MINOR',
        );
        final json = request.toJson();

        // Assert
        expect(json['id'], 22222);
        expect(json['repairLevel'], 'MINOR');
        expect(json.containsKey('remark'), false);
        expect(json.containsKey('skus'), false);
      });

      test('should handle typical repair levels', () {
        // Arrange & Act
        final levels = ['MINOR', 'MEDIUM', 'MAJOR', 'CRITICAL'];

        for (final level in levels) {
          final request = AcceptRejectDeadRequest(
            markId: 1,
            repairLevel: level,
          );
          final json = request.toJson();

          // Assert
          expect(json['repairLevel'], level);
        }
      });
    });
  });

  group('DeadDeviceRequestType', () {
    test('ACCEPT_DEAD should have value 1', () {
      expect(DeadDeviceRequestType.ACCEPT_DEAD.value, 1);
    });

    test('REPAIR_REJECT should have value 2', () {
      expect(DeadDeviceRequestType.REPAIR_REJECT.value, 2);
    });

    test('REPAIR_DONE should have value 3', () {
      expect(DeadDeviceRequestType.REPAIR_DONE.value, 3);
    });

    test('should have exactly 3 values', () {
      expect(DeadDeviceRequestType.values.length, 3);
    });
  });
}
