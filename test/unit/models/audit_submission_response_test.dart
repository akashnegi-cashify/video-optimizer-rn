import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/resources/audit_submission_response.dart';

/// Tests for AuditSubmissionResponse, AuditSubmissionResponseData, and PartsStatus models.
/// Focus: Testing fromJson, toJson, null handling, and edge cases.
void main() {
  group('AuditSubmissionResponse', () {
    group('fromJson', () {
      test('should parse response with complete data', () {
        // Arrange
        final json = {
          'success': true,
          'r_id': 'REF-12345',
          's': true,
          'dt': {
            'r_id': 'REF-12345',
            'pn': 'iPhone 15 Pro',
            'bn': 'Apple',
            'qa': 95.5,
            'gr': 'A',
            'ps': [
              {'l': 'Screen', 'p': 'Pass'},
              {'l': 'Battery', 'p': 'Pass'},
            ],
          },
        };

        // Act
        final response = AuditSubmissionResponse.fromJson(json);

        // Assert
        expect(response.success, true);
        expect(response.referenceId, 'REF-12345');
        expect(response.status, true);
        expect(response.auditSubmissionData, isNotNull);
        expect(response.auditSubmissionData?.productName, 'iPhone 15 Pro');
      });

      test('should handle null dt field', () {
        // Arrange
        final json = {
          'success': true,
          'r_id': 'REF-001',
          's': false,
          'dt': null,
        };

        // Act
        final response = AuditSubmissionResponse.fromJson(json);

        // Assert
        expect(response.success, true);
        expect(response.referenceId, 'REF-001');
        expect(response.status, false);
        expect(response.auditSubmissionData, null);
      });

      test('should handle all null values', () {
        // Arrange
        final json = {
          'success': null,
          'r_id': null,
          's': null,
          'dt': null,
        };

        // Act
        final response = AuditSubmissionResponse.fromJson(json);

        // Assert
        expect(response.success, null);
        expect(response.referenceId, null);
        expect(response.status, null);
        expect(response.auditSubmissionData, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = AuditSubmissionResponse.fromJson(json);

        // Assert
        expect(response.success, null);
        expect(response.referenceId, null);
        expect(response.status, null);
        expect(response.auditSubmissionData, null);
      });

      test('should handle false status', () {
        // Arrange
        final json = {
          'success': false,
          's': false,
        };

        // Act
        final response = AuditSubmissionResponse.fromJson(json);

        // Assert
        expect(response.success, false);
        expect(response.status, false);
      });
    });

    group('toJson', () {
      test('should serialize response correctly', () {
        // Arrange
        final response = AuditSubmissionResponse.fromJson({
          'success': true,
          'r_id': 'REF-999',
          's': true,
          'dt': {
            'r_id': 'REF-999',
            'pn': 'Test Product',
            'bn': 'Test Brand',
            'qa': 80.0,
            'gr': 'B',
          },
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['success'], true);
        expect(json['r_id'], 'REF-999');
        expect(json['s'], true);
        expect(json['dt'], isNotNull);
      });

      test('should handle null values in serialization', () {
        // Arrange
        final response = AuditSubmissionResponse.fromJson({
          'success': null,
          'r_id': null,
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['success'], null);
        expect(json['r_id'], null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data integrity through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'success': true,
          'r_id': 'REF-12345',
          's': true,
          'dt': {
            'r_id': 'REF-12345',
            'pn': 'iPhone 15',
            'bn': 'Apple',
            'qa': 90.0,
            'gr': 'A',
          },
        };

        // Act
        final response = AuditSubmissionResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['success'], true);
        expect(serialized['r_id'], 'REF-12345');
        expect(response.auditSubmissionData?.productName, 'iPhone 15');
      });
    });
  });

  group('AuditSubmissionResponseData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'r_id': 'REF-42',
          'pn': 'Samsung Galaxy S24',
          'bn': 'Samsung',
          'qa': 92.5,
          'gr': 'A+',
          'ps': [
            {'l': 'Display', 'p': 'Excellent'},
            {'l': 'Camera', 'p': 'Good'},
            {'l': 'Battery', 'p': 'Excellent'},
          ],
        };

        // Act
        final data = AuditSubmissionResponseData.fromJson(json);

        // Assert
        expect(data.referenceId, 'REF-42');
        expect(data.productName, 'Samsung Galaxy S24');
        expect(data.brandName, 'Samsung');
        expect(data.qa, 92.5);
        expect(data.grade, 'A+');
        expect(data.partsStatusList?.length, 3);
      });

      test('should handle null values', () {
        // Arrange
        final json = {
          'r_id': null,
          'pn': null,
          'bn': null,
          'qa': null,
          'gr': null,
          'ps': null,
        };

        // Act
        final data = AuditSubmissionResponseData.fromJson(json);

        // Assert
        expect(data.referenceId, null);
        expect(data.productName, null);
        expect(data.brandName, null);
        expect(data.qa, null);
        expect(data.grade, null);
        expect(data.partsStatusList, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = AuditSubmissionResponseData.fromJson(json);

        // Assert
        expect(data.referenceId, null);
        expect(data.productName, null);
        expect(data.brandName, null);
        expect(data.qa, null);
        expect(data.grade, null);
        expect(data.partsStatusList, null);
      });

      test('should handle empty parts status list', () {
        // Arrange
        final json = {
          'r_id': 'REF-001',
          'ps': <Map<String, dynamic>>[],
        };

        // Act
        final data = AuditSubmissionResponseData.fromJson(json);

        // Assert
        expect(data.partsStatusList, isEmpty);
      });

      test('should handle integer qa value', () {
        // Arrange
        final json = {
          'qa': 85,
        };

        // Act
        final data = AuditSubmissionResponseData.fromJson(json);

        // Assert
        expect(data.qa, 85.0);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          'pn': 'Test Product',
          'gr': 'B',
        };

        // Act
        final data = AuditSubmissionResponseData.fromJson(json);

        // Assert
        expect(data.productName, 'Test Product');
        expect(data.grade, 'B');
        expect(data.referenceId, null);
        expect(data.brandName, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = AuditSubmissionResponseData.fromJson({
          'r_id': 'REF-10',
          'pn': 'Pixel 8',
          'bn': 'Google',
          'qa': 88.5,
          'gr': 'A',
          'ps': [
            {'l': 'Screen', 'p': 'Pass'},
          ],
        });

        // Act
        final json = data.toJson();

        // Assert
        expect(json['r_id'], 'REF-10');
        expect(json['pn'], 'Pixel 8');
        expect(json['bn'], 'Google');
        expect(json['qa'], 88.5);
        expect(json['gr'], 'A');
        expect(json['ps'], isNotNull);
      });

      test('should handle null values in serialization', () {
        // Arrange
        final data = AuditSubmissionResponseData.fromJson({
          'r_id': null,
          'pn': null,
        });

        // Act
        final json = data.toJson();

        // Assert
        expect(json['r_id'], null);
        expect(json['pn'], null);
      });
    });

    group('edge cases', () {
      test('should handle zero qa value', () {
        // Arrange
        final json = {
          'qa': 0.0,
        };

        // Act
        final data = AuditSubmissionResponseData.fromJson(json);

        // Assert
        expect(data.qa, 0.0);
      });

      test('should handle 100 qa value', () {
        // Arrange
        final json = {
          'qa': 100.0,
        };

        // Act
        final data = AuditSubmissionResponseData.fromJson(json);

        // Assert
        expect(data.qa, 100.0);
      });

      test('should handle unicode characters in product name', () {
        // Arrange
        final json = {
          'pn': 'Xiaomi 小米 14 Ultra 📱',
          'bn': '小米',
        };

        // Act
        final data = AuditSubmissionResponseData.fromJson(json);

        // Assert
        expect(data.productName, 'Xiaomi 小米 14 Ultra 📱');
        expect(data.brandName, '小米');
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'r_id': '',
          'pn': '',
          'bn': '',
          'gr': '',
        };

        // Act
        final data = AuditSubmissionResponseData.fromJson(json);

        // Assert
        expect(data.referenceId, '');
        expect(data.productName, '');
        expect(data.brandName, '');
        expect(data.grade, '');
      });

      test('should handle various grade formats', () {
        // Arrange
        final grades = ['A+', 'A', 'A-', 'B+', 'B', 'B-', 'C', 'D', 'F'];

        for (final gradeValue in grades) {
          final json = {'gr': gradeValue};

          // Act
          final data = AuditSubmissionResponseData.fromJson(json);

          // Assert
          expect(data.grade, gradeValue);
        }
      });
    });
  });

  group('PartsStatus', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'l': 'Screen',
          'p': 'Pass',
        };

        // Act
        final partsStatus = PartsStatus.fromJson(json);

        // Assert
        expect(partsStatus.label, 'Screen');
        expect(partsStatus.p, 'Pass');
      });

      test('should handle null values', () {
        // Arrange
        final json = {
          'l': null,
          'p': null,
        };

        // Act
        final partsStatus = PartsStatus.fromJson(json);

        // Assert
        expect(partsStatus.label, null);
        expect(partsStatus.p, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final partsStatus = PartsStatus.fromJson(json);

        // Assert
        expect(partsStatus.label, null);
        expect(partsStatus.p, null);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          'l': 'Battery',
        };

        // Act
        final partsStatus = PartsStatus.fromJson(json);

        // Assert
        expect(partsStatus.label, 'Battery');
        expect(partsStatus.p, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final partsStatus = PartsStatus.fromJson({
          'l': 'Camera',
          'p': 'Good',
        });

        // Act
        final json = partsStatus.toJson();

        // Assert
        expect(json['l'], 'Camera');
        expect(json['p'], 'Good');
      });

      test('should handle null values in serialization', () {
        // Arrange
        final partsStatus = PartsStatus.fromJson({
          'l': null,
          'p': null,
        });

        // Act
        final json = partsStatus.toJson();

        // Assert
        expect(json['l'], null);
        expect(json['p'], null);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange & Act
        final partsStatus = PartsStatus('Display', 'Excellent');

        // Assert
        expect(partsStatus.label, 'Display');
        expect(partsStatus.p, 'Excellent');
      });

      test('should create instance with null parameters', () {
        // Arrange & Act
        final partsStatus = PartsStatus(null, null);

        // Assert
        expect(partsStatus.label, null);
        expect(partsStatus.p, null);
      });
    });

    group('edge cases', () {
      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'l': '画面 📱',
          'p': '良好 ✓',
        };

        // Act
        final partsStatus = PartsStatus.fromJson(json);

        // Assert
        expect(partsStatus.label, '画面 📱');
        expect(partsStatus.p, '良好 ✓');
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          'l': '',
          'p': '',
        };

        // Act
        final partsStatus = PartsStatus.fromJson(json);

        // Assert
        expect(partsStatus.label, '');
        expect(partsStatus.p, '');
      });

      test('should handle long label names', () {
        // Arrange
        final longLabel = 'This is a very long label name that might be used for detailed part descriptions';
        final json = {
          'l': longLabel,
          'p': 'Status',
        };

        // Act
        final partsStatus = PartsStatus.fromJson(json);

        // Assert
        expect(partsStatus.label, longLabel);
      });

      test('should handle various status values', () {
        // Arrange
        final statuses = ['Pass', 'Fail', 'Good', 'Excellent', 'Poor', 'N/A', 'Unknown'];

        for (final status in statuses) {
          final json = {'l': 'Test', 'p': status};

          // Act
          final partsStatus = PartsStatus.fromJson(json);

          // Assert
          expect(partsStatus.p, status);
        }
      });
    });

    group('round-trip serialization', () {
      test('should maintain data integrity through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'l': 'Fingerprint Sensor',
          'p': 'Working',
        };

        // Act
        final partsStatus = PartsStatus.fromJson(originalJson);
        final serialized = partsStatus.toJson();
        final reparsed = PartsStatus.fromJson(serialized);

        // Assert
        expect(reparsed.label, partsStatus.label);
        expect(reparsed.p, partsStatus.p);
      });
    });
  });

  group('integration tests', () {
    test('should handle complete nested response structure', () {
      // Arrange
      final json = {
        'success': true,
        'r_id': 'REF-COMPLETE-001',
        's': true,
        'dt': {
          'r_id': 'REF-COMPLETE-001',
          'pn': 'iPhone 15 Pro Max',
          'bn': 'Apple',
          'qa': 97.5,
          'gr': 'A+',
          'ps': [
            {'l': 'Display', 'p': 'Excellent'},
            {'l': 'Touch Screen', 'p': 'Pass'},
            {'l': 'Face ID', 'p': 'Working'},
            {'l': 'Battery', 'p': 'Good (85%)'},
            {'l': 'Camera', 'p': 'Excellent'},
            {'l': 'Speakers', 'p': 'Pass'},
          ],
        },
      };

      // Act
      final response = AuditSubmissionResponse.fromJson(json);

      // Assert
      expect(response.success, true);
      expect(response.auditSubmissionData, isNotNull);
      expect(response.auditSubmissionData?.partsStatusList?.length, 6);
      expect(response.auditSubmissionData?.partsStatusList?[0].label, 'Display');
      expect(response.auditSubmissionData?.partsStatusList?[0].p, 'Excellent');
      expect(response.auditSubmissionData?.partsStatusList?[3].label, 'Battery');
      expect(response.auditSubmissionData?.partsStatusList?[3].p, 'Good (85%)');
    });

    test('should handle round-trip for complete response', () {
      // Arrange
      final originalJson = {
        'success': true,
        'r_id': 'REF-999',
        's': true,
        'dt': {
          'r_id': 'REF-999',
          'pn': 'Test Device',
          'bn': 'Test Brand',
          'qa': 80.0,
          'gr': 'B',
          'ps': [
            {'l': 'Part 1', 'p': 'Status 1'},
          ],
        },
      };

      // Act
      final response = AuditSubmissionResponse.fromJson(originalJson);
      final serialized = response.toJson();

      // Assert
      expect(serialized['success'], true);
      expect(serialized['r_id'], 'REF-999');
      expect(serialized['dt'], isNotNull);
      expect(response.auditSubmissionData?.partsStatusList?.length, 1);
    });
  });
}
