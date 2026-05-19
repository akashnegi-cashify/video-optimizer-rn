import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/re_qc_list_response.dart';

/// Tests for ReQcListResponse and ReQcListData models.
/// Focus: Testing fromJson/toJson for list response and nested data items.
void main() {
  group('ReQcListResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': [
            {
              'lotGroupName': 'LOT-GROUP-001',
              'lotCount': 10,
              'id': 123,
              'qcPending': 5,
              'qcDone': 3,
              'qcAudit': 2,
              'lotType': 'NORMAL',
              'skipReQc': false,
            },
          ],
        };

        // Act
        final response = ReQcListResponse.fromJson(json);

        // Assert
        expect(response.list, isNotNull);
        expect(response.list!.length, 1);
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should handle null list', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': null,
        };

        // Act
        final response = ReQcListResponse.fromJson(json);

        // Assert
        expect(response.list, null);
      });

      test('should handle empty list', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com',
          'dt': <Map<String, dynamic>>[],
        };

        // Act
        final response = ReQcListResponse.fromJson(json);

        // Assert
        expect(response.list, isNotNull);
        expect(response.list!.isEmpty, true);
      });

      test('should parse multiple list items', () {
        // Arrange
        final json = {
          'dt': [
            {'lotGroupName': 'LOT-001', 'id': 1},
            {'lotGroupName': 'LOT-002', 'id': 2},
            {'lotGroupName': 'LOT-003', 'id': 3},
          ],
        };

        // Act
        final response = ReQcListResponse.fromJson(json);

        // Assert
        expect(response.list, isNotNull);
        expect(response.list!.length, 3);
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Alert Title',
            'msg': 'Alert Message',
          },
          'turl': 'https://track.com',
          'dt': null,
        };

        // Act
        final response = ReQcListResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should handle missing dt field', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': 'https://example.com',
        };

        // Act
        final response = ReQcListResponse.fromJson(json);

        // Assert
        expect(response.list, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': [
            {
              'lotGroupName': 'LOT-GROUP-001',
              'lotCount': 10,
              'id': 123,
              'qcPending': 5,
              'qcDone': 3,
              'qcAudit': 2,
              'lotType': 'NORMAL',
              'skipReQc': false,
            },
          ],
        };
        final response = ReQcListResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['dt'], isNotNull);
        expect(serialized['turl'], 'https://example.com/track');
      });

      test('should handle null list in serialization', () {
        // Arrange
        final response = ReQcListResponse.fromJson({
          '__ca': null,
          'turl': null,
          'dt': null,
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['dt'], null);
      });

      test('should serialize empty list', () {
        // Arrange
        final response = ReQcListResponse.fromJson({
          'dt': <Map<String, dynamic>>[],
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['dt'], isNotNull);
        expect((serialized['dt'] as List).isEmpty, true);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com',
          'dt': [
            {
              'lotGroupName': 'LOT-GROUP-001',
              'lotCount': 10,
              'id': 123,
              'qcPending': 5,
              'qcDone': 3,
              'qcAudit': 2,
              'lotType': 'NORMAL',
              'skipReQc': true,
            },
          ],
        };

        // Act
        final response = ReQcListResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['turl'], 'https://example.com');
        expect(serialized['dt'], isNotNull);
        final dtList = serialized['dt'] as List;
        expect(dtList.length, 1);
      });
    });
  });

  group('ReQcListData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'lotGroupName': 'LOT-GROUP-001',
          'lotCount': 10,
          'id': 123,
          'qcPending': 5,
          'qcDone': 3,
          'qcAudit': 2,
          'lotType': 'NORMAL',
          'skipReQc': false,
        };

        // Act
        final data = ReQcListData.fromJson(json);

        // Assert
        expect(data.lotGroupName, 'LOT-GROUP-001');
        expect(data.lotCount, 10);
        expect(data.lotId, 123);
        expect(data.pendingCount, 5);
        expect(data.doneCount, 3);
        expect(data.auditCount, 2);
        expect(data.lotType, 'NORMAL');
        expect(data.skipReQc, false);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = ReQcListData.fromJson(json);

        // Assert
        expect(data.lotGroupName, null);
        expect(data.lotCount, null);
        expect(data.lotId, null);
        expect(data.pendingCount, null);
        expect(data.doneCount, null);
        expect(data.auditCount, null);
        expect(data.lotType, null);
        expect(data.skipReQc, null);
      });

      test('should handle partial fields', () {
        // Arrange
        final json = {
          'lotGroupName': 'PARTIAL-LOT',
          'id': 456,
          'qcPending': 10,
        };

        // Act
        final data = ReQcListData.fromJson(json);

        // Assert
        expect(data.lotGroupName, 'PARTIAL-LOT');
        expect(data.lotId, 456);
        expect(data.pendingCount, 10);
        expect(data.lotCount, null);
        expect(data.doneCount, null);
        expect(data.auditCount, null);
        expect(data.lotType, null);
        expect(data.skipReQc, null);
      });

      test('should handle skipReQc true', () {
        // Arrange
        final json = {
          'lotGroupName': 'SKIP-LOT',
          'skipReQc': true,
        };

        // Act
        final data = ReQcListData.fromJson(json);

        // Assert
        expect(data.skipReQc, true);
      });

      test('should handle zero counts', () {
        // Arrange
        final json = {
          'lotCount': 0,
          'qcPending': 0,
          'qcDone': 0,
          'qcAudit': 0,
        };

        // Act
        final data = ReQcListData.fromJson(json);

        // Assert
        expect(data.lotCount, 0);
        expect(data.pendingCount, 0);
        expect(data.doneCount, 0);
        expect(data.auditCount, 0);
      });

      test('should handle different lot types', () {
        // Arrange
        final normalJson = {'lotType': 'NORMAL'};
        final specialJson = {'lotType': 'SPECIAL'};
        final priorityJson = {'lotType': 'PRIORITY'};

        // Act
        final normalData = ReQcListData.fromJson(normalJson);
        final specialData = ReQcListData.fromJson(specialJson);
        final priorityData = ReQcListData.fromJson(priorityJson);

        // Assert
        expect(normalData.lotType, 'NORMAL');
        expect(specialData.lotType, 'SPECIAL');
        expect(priorityData.lotType, 'PRIORITY');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = ReQcListData(
          lotGroupName: 'LOT-GROUP-001',
          lotCount: 10,
          lotId: 123,
          pendingCount: 5,
          doneCount: 3,
          auditCount: 2,
          lotType: 'NORMAL',
          skipReQc: false,
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json['lotGroupName'], 'LOT-GROUP-001');
        expect(json['lotCount'], 10);
        expect(json['id'], 123);
        expect(json['qcPending'], 5);
        expect(json['qcDone'], 3);
        expect(json['qcAudit'], 2);
        expect(json['lotType'], 'NORMAL');
        expect(json['skipReQc'], false);
      });

      test('should handle null fields in serialization', () {
        // Arrange
        final data = ReQcListData();

        // Act
        final json = data.toJson();

        // Assert
        expect(json['lotGroupName'], null);
        expect(json['lotCount'], null);
        expect(json['id'], null);
        expect(json['qcPending'], null);
        expect(json['qcDone'], null);
        expect(json['qcAudit'], null);
        expect(json['lotType'], null);
        expect(json['skipReQc'], null);
      });

      test('should serialize partial data correctly', () {
        // Arrange
        final data = ReQcListData(
          lotGroupName: 'PARTIAL-LOT',
          lotId: 789,
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json['lotGroupName'], 'PARTIAL-LOT');
        expect(json['id'], 789);
        expect(json['lotCount'], null);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final data = ReQcListData(
          lotGroupName: 'LOT-001',
          lotCount: 100,
          pendingCount: 50,
          doneCount: 30,
          auditCount: 20,
          lotType: 'NORMAL',
          lotId: 999,
          skipReQc: true,
        );

        // Assert
        expect(data.lotGroupName, 'LOT-001');
        expect(data.lotCount, 100);
        expect(data.pendingCount, 50);
        expect(data.doneCount, 30);
        expect(data.auditCount, 20);
        expect(data.lotType, 'NORMAL');
        expect(data.lotId, 999);
        expect(data.skipReQc, true);
      });

      test('should create instance with no parameters', () {
        // Act
        final data = ReQcListData();

        // Assert
        expect(data.lotGroupName, null);
        expect(data.lotCount, null);
        expect(data.lotId, null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'lotGroupName': 'LOT-GROUP-001',
          'lotCount': 10,
          'id': 123,
          'qcPending': 5,
          'qcDone': 3,
          'qcAudit': 2,
          'lotType': 'NORMAL',
          'skipReQc': true,
        };

        // Act
        final data = ReQcListData.fromJson(originalJson);
        final serialized = data.toJson();

        // Assert
        expect(serialized['lotGroupName'], originalJson['lotGroupName']);
        expect(serialized['lotCount'], originalJson['lotCount']);
        expect(serialized['id'], originalJson['id']);
        expect(serialized['qcPending'], originalJson['qcPending']);
        expect(serialized['qcDone'], originalJson['qcDone']);
        expect(serialized['qcAudit'], originalJson['qcAudit']);
        expect(serialized['lotType'], originalJson['lotType']);
        expect(serialized['skipReQc'], originalJson['skipReQc']);
      });
    });

    group('edge cases', () {
      test('should handle large count values', () {
        // Arrange
        final json = {
          'lotCount': 999999,
          'qcPending': 500000,
          'qcDone': 400000,
          'qcAudit': 99999,
        };

        // Act
        final data = ReQcListData.fromJson(json);

        // Assert
        expect(data.lotCount, 999999);
        expect(data.pendingCount, 500000);
        expect(data.doneCount, 400000);
        expect(data.auditCount, 99999);
      });

      test('should handle empty string lotGroupName', () {
        // Arrange
        final json = {
          'lotGroupName': '',
          'lotType': '',
        };

        // Act
        final data = ReQcListData.fromJson(json);

        // Assert
        expect(data.lotGroupName, '');
        expect(data.lotType, '');
      });

      test('should handle negative id', () {
        // Arrange
        final json = {
          'id': -1,
        };

        // Act
        final data = ReQcListData.fromJson(json);

        // Assert
        expect(data.lotId, -1);
      });
    });
  });
}
