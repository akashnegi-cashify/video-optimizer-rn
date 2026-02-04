import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dead_repair/resources/reason_submit_request.dart';

void main() {
  group('ReasonSubmitRequest', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'qrCode': 'QR-12345',
          'remark': 'Device has screen damage',
          'id': 123,
          'actionRemark': 'Marked for repair',
          'skus': ['SKU-001', 'SKU-002', 'SKU-003'],
        };

        // Act
        final request = ReasonSubmitRequest.fromJson(json);

        // Assert
        expect(request.code, 'QR-12345');
        expect(request.remark, 'Device has screen damage');
        expect(request.id, 123);
        expect(request.actionRemark, 'Marked for repair');
        expect(request.skus, ['SKU-001', 'SKU-002', 'SKU-003']);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final request = ReasonSubmitRequest.fromJson(json);

        // Assert
        expect(request.code, isNull);
        expect(request.remark, isNull);
        expect(request.id, isNull);
        expect(request.actionRemark, isNull);
        expect(request.skus, isNull);
      });

      test('should handle partial fields', () {
        // Arrange
        final json = {
          'qrCode': 'QR-PARTIAL',
          'remark': 'Partial remark',
        };

        // Act
        final request = ReasonSubmitRequest.fromJson(json);

        // Assert
        expect(request.code, 'QR-PARTIAL');
        expect(request.remark, 'Partial remark');
        expect(request.id, isNull);
        expect(request.actionRemark, isNull);
        expect(request.skus, isNull);
      });

      test('should handle empty skus list', () {
        // Arrange
        final json = {
          'qrCode': 'QR-EMPTY-SKUS',
          'skus': <String>[],
        };

        // Act
        final request = ReasonSubmitRequest.fromJson(json);

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
        final request = ReasonSubmitRequest.fromJson(json);

        // Assert
        expect(request.skus, ['SINGLE-SKU']);
      });

      test('should handle zero id', () {
        // Arrange
        final json = {
          'id': 0,
        };

        // Act
        final request = ReasonSubmitRequest.fromJson(json);

        // Assert
        expect(request.id, 0);
      });

      test('should handle empty string values', () {
        // Arrange
        final json = {
          'qrCode': '',
          'remark': '',
          'actionRemark': '',
        };

        // Act
        final request = ReasonSubmitRequest.fromJson(json);

        // Assert
        expect(request.code, '');
        expect(request.remark, '');
        expect(request.actionRemark, '');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final request = ReasonSubmitRequest(
          code: 'QR-SERIALIZE',
          remark: 'Serialize remark',
          id: 456,
          actionRemark: 'Serialize action',
          skus: ['SKU-A', 'SKU-B'],
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['qrCode'], 'QR-SERIALIZE');
        expect(json['remark'], 'Serialize remark');
        expect(json['id'], 456);
        expect(json['actionRemark'], 'Serialize action');
        expect(json['skus'], ['SKU-A', 'SKU-B']);
      });

      test('should not include null fields due to includeIfNull false', () {
        // Arrange
        final request = ReasonSubmitRequest();

        // Act
        final json = request.toJson();

        // Assert
        expect(json.containsKey('qrCode'), false);
        expect(json.containsKey('remark'), false);
        expect(json.containsKey('id'), false);
        expect(json.containsKey('actionRemark'), false);
        expect(json.containsKey('skus'), false);
      });

      test('should not include null code', () {
        // Arrange
        final request = ReasonSubmitRequest(
          remark: 'Only remark',
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json.containsKey('qrCode'), false);
        expect(json['remark'], 'Only remark');
      });

      test('should not include null remark', () {
        // Arrange
        final request = ReasonSubmitRequest(
          code: 'QR-ONLY',
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['qrCode'], 'QR-ONLY');
        expect(json.containsKey('remark'), false);
      });

      test('should not include null skus', () {
        // Arrange
        final request = ReasonSubmitRequest(
          code: 'QR-NO-SKUS',
          id: 100,
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['qrCode'], 'QR-NO-SKUS');
        expect(json['id'], 100);
        expect(json.containsKey('skus'), false);
      });

      test('should include empty skus list', () {
        // Arrange
        final request = ReasonSubmitRequest(
          code: 'QR-EMPTY-SKUS',
          skus: [],
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['skus'], isNotNull);
        expect(json['skus'].isEmpty, true);
      });

      test('should include empty string values', () {
        // Arrange
        final request = ReasonSubmitRequest(
          code: '',
          remark: '',
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['qrCode'], '');
        expect(json['remark'], '');
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final request = ReasonSubmitRequest(
          code: 'CTOR-CODE',
          remark: 'CTOR-REMARK',
          id: 789,
          actionRemark: 'CTOR-ACTION',
          skus: ['SKU-1', 'SKU-2'],
        );

        // Assert
        expect(request.code, 'CTOR-CODE');
        expect(request.remark, 'CTOR-REMARK');
        expect(request.id, 789);
        expect(request.actionRemark, 'CTOR-ACTION');
        expect(request.skus, ['SKU-1', 'SKU-2']);
      });

      test('should create instance with no parameters', () {
        // Act
        final request = ReasonSubmitRequest();

        // Assert
        expect(request.code, isNull);
        expect(request.remark, isNull);
        expect(request.id, isNull);
        expect(request.actionRemark, isNull);
        expect(request.skus, isNull);
      });

      test('should create instance with only code and remark', () {
        // Act
        final request = ReasonSubmitRequest(
          code: 'QR-BASIC',
          remark: 'Basic remark',
        );

        // Assert
        expect(request.code, 'QR-BASIC');
        expect(request.remark, 'Basic remark');
        expect(request.id, isNull);
        expect(request.actionRemark, isNull);
        expect(request.skus, isNull);
      });

      test('should create instance with only skus for repair', () {
        // Act
        final request = ReasonSubmitRequest(
          skus: ['REPAIR-SKU-1', 'REPAIR-SKU-2'],
        );

        // Assert
        expect(request.code, isNull);
        expect(request.skus, ['REPAIR-SKU-1', 'REPAIR-SKU-2']);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle with all fields', () {
        // Arrange
        final originalJson = {
          'qrCode': 'RT-QR',
          'remark': 'RT-REMARK',
          'id': 999,
          'actionRemark': 'RT-ACTION',
          'skus': ['RT-SKU-1', 'RT-SKU-2'],
        };

        // Act
        final request = ReasonSubmitRequest.fromJson(originalJson);
        final serializedJson = request.toJson();
        final deserializedRequest = ReasonSubmitRequest.fromJson(serializedJson);

        // Assert
        expect(deserializedRequest.code, request.code);
        expect(deserializedRequest.remark, request.remark);
        expect(deserializedRequest.id, request.id);
        expect(deserializedRequest.actionRemark, request.actionRemark);
        expect(deserializedRequest.skus, request.skus);
      });

      test('should maintain data through roundtrip with partial fields', () {
        // Arrange
        final originalJson = {
          'qrCode': 'PARTIAL-RT',
          'remark': 'Partial roundtrip',
        };

        // Act
        final request = ReasonSubmitRequest.fromJson(originalJson);
        final serializedJson = request.toJson();

        // Assert
        expect(serializedJson['qrCode'], 'PARTIAL-RT');
        expect(serializedJson['remark'], 'Partial roundtrip');
        expect(serializedJson.containsKey('id'), false);
        expect(serializedJson.containsKey('actionRemark'), false);
        expect(serializedJson.containsKey('skus'), false);
      });

      test('should handle roundtrip from constructor', () {
        // Arrange
        final original = ReasonSubmitRequest(
          code: 'FROM-CTOR',
          remark: 'From constructor',
          id: 111,
          skus: ['CTOR-SKU'],
        );

        // Act
        final json = original.toJson();
        final restored = ReasonSubmitRequest.fromJson(json);

        // Assert
        expect(restored.code, original.code);
        expect(restored.remark, original.remark);
        expect(restored.id, original.id);
        expect(restored.skus, original.skus);
      });
    });

    group('edge cases', () {
      test('should handle very large id', () {
        // Arrange
        final json = {
          'id': 9999999999,
        };

        // Act
        final request = ReasonSubmitRequest.fromJson(json);

        // Assert
        expect(request.id, 9999999999);
      });

      test('should handle special characters in strings', () {
        // Arrange
        final json = {
          'qrCode': 'QR-!@#\$%^&*()',
          'remark': 'Remark with "quotes" and \'apostrophes\'',
          'actionRemark': 'Action<br/>with<script>tags</script>',
        };

        // Act
        final request = ReasonSubmitRequest.fromJson(json);

        // Assert
        expect(request.code, 'QR-!@#\$%^&*()');
        expect(request.remark, 'Remark with "quotes" and \'apostrophes\'');
        expect(request.actionRemark, 'Action<br/>with<script>tags</script>');
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'qrCode': 'QR-日本語',
          'remark': '备注信息',
          'actionRemark': 'कार्रवाई टिप्पणी',
        };

        // Act
        final request = ReasonSubmitRequest.fromJson(json);

        // Assert
        expect(request.code, 'QR-日本語');
        expect(request.remark, '备注信息');
        expect(request.actionRemark, 'कार्रवाई टिप्पणी');
      });

      test('should handle long string values', () {
        // Arrange
        final longString = 'A' * 1000;
        final json = {
          'qrCode': longString,
          'remark': longString,
        };

        // Act
        final request = ReasonSubmitRequest.fromJson(json);

        // Assert
        expect(request.code!.length, 1000);
        expect(request.remark!.length, 1000);
      });

      test('should handle large skus list', () {
        // Arrange
        final manySkus = List.generate(100, (i) => 'SKU-$i');
        final json = {
          'skus': manySkus,
        };

        // Act
        final request = ReasonSubmitRequest.fromJson(json);

        // Assert
        expect(request.skus!.length, 100);
        expect(request.skus![0], 'SKU-0');
        expect(request.skus![99], 'SKU-99');
      });

      test('should handle whitespace in strings', () {
        // Arrange
        final json = {
          'qrCode': '  QR WITH SPACES  ',
          'remark': '\tRemark\nWith\tTabs\n',
        };

        // Act
        final request = ReasonSubmitRequest.fromJson(json);

        // Assert
        expect(request.code, '  QR WITH SPACES  ');
        expect(request.remark, '\tRemark\nWith\tTabs\n');
      });

      test('should handle skus with empty strings', () {
        // Arrange
        final json = {
          'skus': ['', 'SKU-1', ''],
        };

        // Act
        final request = ReasonSubmitRequest.fromJson(json);

        // Assert
        expect(request.skus, ['', 'SKU-1', '']);
      });
    });

    group('typical usage scenarios', () {
      test('should create request for marking device dead', () {
        // Arrange & Act
        final request = ReasonSubmitRequest(
          code: 'DEV-2024-001',
          remark: 'Device has water damage - not repairable',
        );
        final json = request.toJson();

        // Assert
        expect(json['qrCode'], 'DEV-2024-001');
        expect(json['remark'], 'Device has water damage - not repairable');
        expect(json.containsKey('skus'), false);
      });

      test('should create request for marking device for repair with SKUs', () {
        // Arrange & Act
        final request = ReasonSubmitRequest(
          code: 'REPAIR-DEV-001',
          remark: 'Screen and battery replacement needed',
          skus: ['SCREEN-IPHONE-14', 'BATTERY-IPHONE-14'],
        );
        final json = request.toJson();

        // Assert
        expect(json['qrCode'], 'REPAIR-DEV-001');
        expect(json['remark'], 'Screen and battery replacement needed');
        expect(json['skus'], ['SCREEN-IPHONE-14', 'BATTERY-IPHONE-14']);
      });

      test('should create request for accepting dead device', () {
        // Arrange & Act
        final request = ReasonSubmitRequest(
          id: 12345,
          actionRemark: 'Approved for disposal',
        );
        final json = request.toJson();

        // Assert
        expect(json['id'], 12345);
        expect(json['actionRemark'], 'Approved for disposal');
        expect(json.containsKey('qrCode'), false);
      });

      test('should create request for repair completion', () {
        // Arrange & Act
        final request = ReasonSubmitRequest(
          code: 'REPAIRED-DEV-001',
          id: 67890,
          actionRemark: 'Repair completed - screen replaced',
          skus: ['SCREEN-SAMSUNG-S23'],
        );
        final json = request.toJson();

        // Assert
        expect(json['qrCode'], 'REPAIRED-DEV-001');
        expect(json['id'], 67890);
        expect(json['actionRemark'], 'Repair completed - screen replaced');
        expect(json['skus'], ['SCREEN-SAMSUNG-S23']);
      });

      test('should create minimal request with only remark', () {
        // Arrange & Act
        final request = ReasonSubmitRequest(
          remark: 'General remark',
        );
        final json = request.toJson();

        // Assert
        expect(json['remark'], 'General remark');
        expect(json.length, 1);
      });
    });
  });
}
