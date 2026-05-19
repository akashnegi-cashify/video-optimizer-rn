import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/warehouse_audit/resources/ongoing_audit_response.dart';

/// Tests for OnGoingAuditResponse and OnGoingAuditData models.
/// Focus: Testing fromJson, toJson, null handling, nested data, and edge cases.
void main() {
  group('OnGoingAuditResponse', () {
    group('fromJson', () {
      test('should parse response with complete data', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'data': [
            {
              'id': 1001,
              'facilityName': 'Main Warehouse',
              'status': 1,
              'statusDesc': 'In Progress',
              'remark': 'Audit started',
              'startDate': 1704067200000.0,
              'endDate': 1704153600000.0,
            },
            {
              'id': 1002,
              'facilityName': 'Secondary Warehouse',
              'status': 2,
              'statusDesc': 'Completed',
              'remark': 'Audit finished successfully',
              'startDate': 1703980800000.0,
              'endDate': 1704067200000.0,
            },
          ],
        };

        // Act
        final response = OnGoingAuditResponse.fromJson(json);

        // Assert
        expect(response.onGoingAuditList, isNotNull);
        expect(response.onGoingAuditList!.length, 2);
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should handle null data field', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com',
          'data': null,
        };

        // Act
        final response = OnGoingAuditResponse.fromJson(json);

        // Assert
        expect(response.onGoingAuditList, null);
        expect(response.trackUrl, 'https://example.com');
      });

      test('should handle empty data list', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'data': <Map<String, dynamic>>[],
        };

        // Act
        final response = OnGoingAuditResponse.fromJson(json);

        // Assert
        expect(response.onGoingAuditList, isNotNull);
        expect(response.onGoingAuditList!.isEmpty, true);
      });

      test('should handle all null values', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'data': null,
        };

        // Act
        final response = OnGoingAuditResponse.fromJson(json);

        // Assert
        expect(response.onGoingAuditList, null);
        expect(response.trackUrl, null);
        expect(response.cashifyAlert, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = OnGoingAuditResponse.fromJson(json);

        // Assert
        expect(response.onGoingAuditList, null);
        expect(response.trackUrl, null);
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Audit Alert',
            'msg': 'New audits available',
          },
          'turl': 'https://track.com',
          'data': null,
        };

        // Act
        final response = OnGoingAuditResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should parse single audit list', () {
        // Arrange
        final json = {
          'data': [
            {
              'id': 999,
              'facilityName': 'Single Facility',
              'status': 1,
              'statusDesc': 'Active',
            },
          ],
        };

        // Act
        final response = OnGoingAuditResponse.fromJson(json);

        // Assert
        expect(response.onGoingAuditList!.length, 1);
        expect(response.onGoingAuditList![0].auditId, 999);
      });

      test('should parse large audit list', () {
        // Arrange
        final audits = List.generate(
          100,
          (i) => {
            'id': i,
            'facilityName': 'Facility $i',
            'status': i % 3,
            'statusDesc': 'Status $i',
            'remark': 'Remark $i',
            'startDate': 1704067200000.0 + i * 86400000,
            'endDate': 1704153600000.0 + i * 86400000,
          },
        );
        final json = {'data': audits};

        // Act
        final response = OnGoingAuditResponse.fromJson(json);

        // Assert
        expect(response.onGoingAuditList!.length, 100);
        expect(response.onGoingAuditList![50].auditId, 50);
        expect(response.onGoingAuditList![99].facilityName, 'Facility 99');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'data': [
            {
              'id': 1001,
              'facilityName': 'Test Warehouse',
              'status': 1,
              'statusDesc': 'Active',
              'remark': 'Test remark',
              'startDate': 1704067200000.0,
              'endDate': 1704153600000.0,
            },
          ],
        };
        final response = OnGoingAuditResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['turl'], 'https://example.com/track');
        expect(serialized['data'], isNotNull);
        expect((serialized['data'] as List).length, 1);
      });

      test('should handle null values in serialization', () {
        // Arrange
        final response = OnGoingAuditResponse.fromJson({
          '__ca': null,
          'turl': null,
          'data': null,
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['data'], null);
        expect(serialized['turl'], null);
      });

      test('should serialize empty list', () {
        // Arrange
        final response = OnGoingAuditResponse.fromJson({
          'data': <Map<String, dynamic>>[],
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['data'], isNotNull);
        expect((serialized['data'] as List).isEmpty, true);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com',
          'data': [
            {
              'id': 123,
              'facilityName': 'Test Facility',
              'status': 2,
              'statusDesc': 'Complete',
              'remark': 'Test message',
              'startDate': 1704067200000.0,
              'endDate': 1704153600000.0,
            },
          ],
        };

        // Act
        final response = OnGoingAuditResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['turl'], 'https://example.com');
        final dataList = serialized['data'] as List;
        expect(dataList.length, 1);
        // toJson returns OnGoingAuditData objects, not raw maps
        expect((dataList[0] as OnGoingAuditData).auditId, 123);
      });
    });
  });

  group('OnGoingAuditData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'id': 1001,
          'facilityName': 'Main Distribution Center',
          'status': 1,
          'statusDesc': 'In Progress',
          'remark': 'Scheduled audit for Q1 2024',
          'startDate': 1704067200000.0,
          'endDate': 1704153600000.0,
        };

        // Act
        final data = OnGoingAuditData.fromJson(json);

        // Assert
        expect(data.auditId, 1001);
        expect(data.facilityName, 'Main Distribution Center');
        expect(data.status, 1);
        expect(data.statusDescription, 'In Progress');
        expect(data.message, 'Scheduled audit for Q1 2024');
        expect(data.startDate, 1704067200000.0);
        expect(data.endDate, 1704153600000.0);
      });

      test('should handle null values', () {
        // Arrange
        final json = {
          'id': null,
          'facilityName': null,
          'status': null,
          'statusDesc': null,
          'remark': null,
          'startDate': null,
          'endDate': null,
        };

        // Act
        final data = OnGoingAuditData.fromJson(json);

        // Assert
        expect(data.auditId, null);
        expect(data.facilityName, null);
        expect(data.status, null);
        expect(data.statusDescription, null);
        expect(data.message, null);
        expect(data.startDate, null);
        expect(data.endDate, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = OnGoingAuditData.fromJson(json);

        // Assert
        expect(data.auditId, null);
        expect(data.facilityName, null);
        expect(data.status, null);
        expect(data.statusDescription, null);
        expect(data.message, null);
        expect(data.startDate, null);
        expect(data.endDate, null);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          'id': 100,
          'facilityName': 'Partial Facility',
          'status': 0,
        };

        // Act
        final data = OnGoingAuditData.fromJson(json);

        // Assert
        expect(data.auditId, 100);
        expect(data.facilityName, 'Partial Facility');
        expect(data.status, 0);
        expect(data.statusDescription, null);
        expect(data.message, null);
        expect(data.startDate, null);
        expect(data.endDate, null);
      });

      test('should handle integer dates converted to double', () {
        // Arrange
        final json = {
          'id': 1,
          'startDate': 1704067200000,
          'endDate': 1704153600000,
        };

        // Act
        final data = OnGoingAuditData.fromJson(json);

        // Assert
        expect(data.startDate, 1704067200000.0);
        expect(data.endDate, 1704153600000.0);
      });

      test('should handle various status values', () {
        // Arrange
        final statuses = [0, 1, 2, 3, 4, 5, -1, 99];

        for (final statusValue in statuses) {
          final json = {'status': statusValue};

          // Act
          final data = OnGoingAuditData.fromJson(json);

          // Assert
          expect(data.status, statusValue);
        }
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = OnGoingAuditData.fromJson({
          'id': 2001,
          'facilityName': 'Serialization Test Facility',
          'status': 2,
          'statusDesc': 'Completed',
          'remark': 'Serialization test remark',
          'startDate': 1704067200000.0,
          'endDate': 1704153600000.0,
        });

        // Act
        final json = data.toJson();

        // Assert
        expect(json['id'], 2001);
        expect(json['facilityName'], 'Serialization Test Facility');
        expect(json['status'], 2);
        expect(json['statusDesc'], 'Completed');
        expect(json['remark'], 'Serialization test remark');
        expect(json['startDate'], 1704067200000.0);
        expect(json['endDate'], 1704153600000.0);
      });

      test('should handle null values in serialization', () {
        // Arrange
        final data = OnGoingAuditData.fromJson({
          'id': null,
          'facilityName': null,
        });

        // Act
        final json = data.toJson();

        // Assert
        expect(json['id'], null);
        expect(json['facilityName'], null);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange & Act
        final data = OnGoingAuditData(
          1001,
          'Constructor Facility',
          1,
          'Active',
          'Constructor message',
          1704067200000.0,
          1704153600000.0,
        );

        // Assert
        expect(data.auditId, 1001);
        expect(data.facilityName, 'Constructor Facility');
        expect(data.status, 1);
        expect(data.statusDescription, 'Active');
        expect(data.message, 'Constructor message');
        expect(data.startDate, 1704067200000.0);
        expect(data.endDate, 1704153600000.0);
      });

      test('should create instance with null parameters', () {
        // Arrange & Act
        final data = OnGoingAuditData(null, null, null, null, null, null, null);

        // Assert
        expect(data.auditId, null);
        expect(data.facilityName, null);
        expect(data.status, null);
        expect(data.statusDescription, null);
        expect(data.message, null);
        expect(data.startDate, null);
        expect(data.endDate, null);
      });
    });

    group('edge cases', () {
      test('should handle unicode characters in facility name', () {
        // Arrange
        final json = {
          'id': 1,
          'facilityName': '北京仓库 📦',
          'statusDesc': '进行中 ✓',
          'remark': '审计备注 - 特殊字符测试',
        };

        // Act
        final data = OnGoingAuditData.fromJson(json);

        // Assert
        expect(data.facilityName, '北京仓库 📦');
        expect(data.statusDescription, '进行中 ✓');
        expect(data.message, '审计备注 - 特殊字符测试');
      });

      test('should handle special characters in strings', () {
        // Arrange
        final json = {
          'id': 1,
          'facilityName': 'Facility (Main) - Branch #1',
          'statusDesc': 'In Progress: Phase 2/3',
          'remark': 'Audit @2024 - Priority: HIGH!',
        };

        // Act
        final data = OnGoingAuditData.fromJson(json);

        // Assert
        expect(data.facilityName, 'Facility (Main) - Branch #1');
        expect(data.statusDescription, 'In Progress: Phase 2/3');
        expect(data.message, 'Audit @2024 - Priority: HIGH!');
      });

      test('should handle very long strings', () {
        // Arrange
        final longString = 'A' * 1000;
        final json = {
          'facilityName': longString,
          'statusDesc': longString,
          'remark': longString,
        };

        // Act
        final data = OnGoingAuditData.fromJson(json);

        // Assert
        expect(data.facilityName!.length, 1000);
        expect(data.statusDescription!.length, 1000);
        expect(data.message!.length, 1000);
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'id': 1,
          'facilityName': '',
          'statusDesc': '',
          'remark': '',
        };

        // Act
        final data = OnGoingAuditData.fromJson(json);

        // Assert
        expect(data.facilityName, '');
        expect(data.statusDescription, '');
        expect(data.message, '');
      });

      test('should handle zero values', () {
        // Arrange
        final json = {
          'id': 0,
          'status': 0,
          'startDate': 0.0,
          'endDate': 0.0,
        };

        // Act
        final data = OnGoingAuditData.fromJson(json);

        // Assert
        expect(data.auditId, 0);
        expect(data.status, 0);
        expect(data.startDate, 0.0);
        expect(data.endDate, 0.0);
      });

      test('should handle negative audit id', () {
        // Arrange
        final json = {
          'id': -1,
          'status': -1,
        };

        // Act
        final data = OnGoingAuditData.fromJson(json);

        // Assert
        expect(data.auditId, -1);
        expect(data.status, -1);
      });

      test('should handle large audit id', () {
        // Arrange
        final json = {
          'id': 2147483647,
        };

        // Act
        final data = OnGoingAuditData.fromJson(json);

        // Assert
        expect(data.auditId, 2147483647);
      });

      test('should handle future dates', () {
        // Arrange - dates in year 2050
        final json = {
          'startDate': 2524608000000.0,
          'endDate': 2524694400000.0,
        };

        // Act
        final data = OnGoingAuditData.fromJson(json);

        // Assert
        expect(data.startDate, 2524608000000.0);
        expect(data.endDate, 2524694400000.0);
      });

      test('should handle date precision', () {
        // Arrange - dates with millisecond precision
        final json = {
          'startDate': 1704067200123.456,
          'endDate': 1704153600789.012,
        };

        // Act
        final data = OnGoingAuditData.fromJson(json);

        // Assert
        expect(data.startDate, 1704067200123.456);
        expect(data.endDate, 1704153600789.012);
      });

      test('should handle various status descriptions', () {
        // Arrange
        final descriptions = [
          'Pending',
          'In Progress',
          'Completed',
          'Cancelled',
          'On Hold',
          'Failed',
          'Scheduled',
        ];

        for (final desc in descriptions) {
          final json = {'statusDesc': desc};

          // Act
          final data = OnGoingAuditData.fromJson(json);

          // Assert
          expect(data.statusDescription, desc);
        }
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'id': 1234,
          'facilityName': 'Roundtrip Facility',
          'status': 1,
          'statusDesc': 'In Progress',
          'remark': 'Roundtrip test',
          'startDate': 1704067200000.0,
          'endDate': 1704153600000.0,
        };

        // Act
        final data = OnGoingAuditData.fromJson(originalJson);
        final serialized = data.toJson();
        final reparsed = OnGoingAuditData.fromJson(serialized);

        // Assert
        expect(reparsed.auditId, data.auditId);
        expect(reparsed.facilityName, data.facilityName);
        expect(reparsed.status, data.status);
        expect(reparsed.statusDescription, data.statusDescription);
        expect(reparsed.message, data.message);
        expect(reparsed.startDate, data.startDate);
        expect(reparsed.endDate, data.endDate);
      });

      test('should maintain null values through cycle', () {
        // Arrange
        final originalJson = {
          'id': null,
          'facilityName': null,
          'status': null,
          'statusDesc': null,
          'remark': null,
          'startDate': null,
          'endDate': null,
        };

        // Act
        final data = OnGoingAuditData.fromJson(originalJson);
        final serialized = data.toJson();
        final reparsed = OnGoingAuditData.fromJson(serialized);

        // Assert
        expect(reparsed.auditId, null);
        expect(reparsed.facilityName, null);
        expect(reparsed.status, null);
        expect(reparsed.statusDescription, null);
        expect(reparsed.message, null);
        expect(reparsed.startDate, null);
        expect(reparsed.endDate, null);
      });
    });
  });

  group('integration tests', () {
    test('should handle complete nested response structure', () {
      // Arrange
      final json = {
        '__ca': {
          't': 'Audit Report',
          'msg': 'Multiple ongoing audits found',
        },
        'turl': 'https://api.example.com/track/audits',
        'data': [
          {
            'id': 1001,
            'facilityName': 'North Region Warehouse',
            'status': 1,
            'statusDesc': 'In Progress',
            'remark': 'Q1 2024 Inventory Audit',
            'startDate': 1704067200000.0,
            'endDate': 1706745600000.0,
          },
          {
            'id': 1002,
            'facilityName': 'South Region Warehouse',
            'status': 2,
            'statusDesc': 'Completed',
            'remark': 'Annual Audit - Passed',
            'startDate': 1701388800000.0,
            'endDate': 1703980800000.0,
          },
          {
            'id': 1003,
            'facilityName': 'East Region Warehouse',
            'status': 0,
            'statusDesc': 'Scheduled',
            'remark': 'Upcoming Q2 Audit',
            'startDate': 1711929600000.0,
            'endDate': 1714521600000.0,
          },
        ],
      };

      // Act
      final response = OnGoingAuditResponse.fromJson(json);

      // Assert
      expect(response.cashifyAlert, isNotNull);
      expect(response.trackUrl, 'https://api.example.com/track/audits');
      expect(response.onGoingAuditList!.length, 3);

      // Verify first audit
      expect(response.onGoingAuditList![0].auditId, 1001);
      expect(response.onGoingAuditList![0].facilityName, 'North Region Warehouse');
      expect(response.onGoingAuditList![0].status, 1);
      expect(response.onGoingAuditList![0].statusDescription, 'In Progress');

      // Verify second audit
      expect(response.onGoingAuditList![1].auditId, 1002);
      expect(response.onGoingAuditList![1].status, 2);

      // Verify third audit
      expect(response.onGoingAuditList![2].auditId, 1003);
      expect(response.onGoingAuditList![2].statusDescription, 'Scheduled');
    });

    test('should handle response with audits having partial data', () {
      // Arrange
      final json = {
        'data': [
          {
            'id': 1,
            'facilityName': 'Full Data Facility',
            'status': 1,
            'statusDesc': 'Active',
            'remark': 'Complete',
            'startDate': 1704067200000.0,
            'endDate': 1704153600000.0,
          },
          {
            'id': 2,
            'facilityName': 'Partial Data Facility',
          },
          {
            'id': 3,
          },
        ],
      };

      // Act
      final response = OnGoingAuditResponse.fromJson(json);

      // Assert
      expect(response.onGoingAuditList!.length, 3);
      expect(response.onGoingAuditList![0].message, 'Complete');
      expect(response.onGoingAuditList![1].status, null);
      expect(response.onGoingAuditList![2].facilityName, null);
    });

    test('should handle complete round-trip for response with audits', () {
      // Arrange
      final originalJson = {
        '__ca': null,
        'turl': 'https://example.com/track',
        'data': [
          {
            'id': 100,
            'facilityName': 'Roundtrip Facility A',
            'status': 1,
            'statusDesc': 'Active',
            'remark': 'Test A',
            'startDate': 1704067200000.0,
            'endDate': 1704153600000.0,
          },
          {
            'id': 101,
            'facilityName': 'Roundtrip Facility B',
            'status': 2,
            'statusDesc': 'Complete',
            'remark': 'Test B',
            'startDate': 1704240000000.0,
            'endDate': 1704326400000.0,
          },
        ],
      };

      // Act
      final response = OnGoingAuditResponse.fromJson(originalJson);
      final serialized = response.toJson();

      // Assert
      expect(serialized['turl'], 'https://example.com/track');
      final dataList = serialized['data'] as List;
      expect(dataList.length, 2);
      // toJson returns OnGoingAuditData objects, not raw maps
      expect((dataList[0] as OnGoingAuditData).auditId, 100);
      expect((dataList[0] as OnGoingAuditData).facilityName, 'Roundtrip Facility A');
      expect((dataList[1] as OnGoingAuditData).auditId, 101);
      expect((dataList[1] as OnGoingAuditData).statusDescription, 'Complete');
    });
  });
}
