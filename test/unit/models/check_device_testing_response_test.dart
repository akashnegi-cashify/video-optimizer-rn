import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/resources/check_device_testing_response.dart';

/// Tests for CheckDeviceTestingResponse model.
/// Focus: Testing fromJson, toJson, isTestingPass getter, null handling, and edge cases.
void main() {
  group('CheckDeviceTestingResponse', () {
    group('fromJson', () {
      test('should parse response with testing pass status', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'dt': {'ip': true},
        };

        // Act
        final response = CheckDeviceTestingResponse.fromJson(json);

        // Assert
        expect(response.response, isNotNull);
        expect(response.response['ip'], true);
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should parse response with testing fail status', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'dt': {'ip': false},
        };

        // Act
        final response = CheckDeviceTestingResponse.fromJson(json);

        // Assert
        expect(response.response, isNotNull);
        expect(response.response['ip'], false);
      });

      test('should parse response with multiple status flags', () {
        // Arrange
        final json = {
          'dt': {
            'ip': true,
            'isComplete': true,
            'hasErrors': false,
          },
        };

        // Act
        final response = CheckDeviceTestingResponse.fromJson(json);

        // Assert
        expect(response.response['ip'], true);
        expect(response.response['isComplete'], true);
        expect(response.response['hasErrors'], false);
      });

      test('should parse CashifyAlert', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Alert Title',
            'msg': 'Alert Message',
          },
          'turl': 'https://track.com',
          'dt': {'ip': true},
        };

        // Act
        final response = CheckDeviceTestingResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should handle empty dt map', () {
        // Arrange
        final json = {
          'dt': <String, bool>{},
        };

        // Act
        final response = CheckDeviceTestingResponse.fromJson(json);

        // Assert
        expect(response.response, isEmpty);
      });
    });

    group('toJson', () {
      test('should serialize response correctly', () {
        // Arrange
        final response = CheckDeviceTestingResponse.fromJson({
          'dt': {'ip': true, 'status': false},
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], isNotNull);
        expect(json['dt']['ip'], true);
        expect(json['dt']['status'], false);
      });

      test('should serialize empty response map', () {
        // Arrange
        final response = CheckDeviceTestingResponse.fromJson({
          'dt': <String, bool>{},
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dt'], isEmpty);
      });
    });

    group('isTestingPass getter', () {
      test('should return true when ip is true', () {
        // Arrange
        final response = CheckDeviceTestingResponse.fromJson({
          'dt': {'ip': true},
        });

        // Act & Assert
        expect(response.isTestingPass, true);
      });

      test('should return false when ip is false', () {
        // Arrange
        final response = CheckDeviceTestingResponse.fromJson({
          'dt': {'ip': false},
        });

        // Act & Assert
        expect(response.isTestingPass, false);
      });

      test('should return false when ip key is missing', () {
        // Arrange
        final response = CheckDeviceTestingResponse.fromJson({
          'dt': {'other': true},
        });

        // Act & Assert
        expect(response.isTestingPass, false);
      });

      test('should return false when dt map is empty', () {
        // Arrange
        final response = CheckDeviceTestingResponse.fromJson({
          'dt': <String, bool>{},
        });

        // Act & Assert
        expect(response.isTestingPass, false);
      });
    });

    group('edge cases', () {
      test('should handle multiple boolean flags', () {
        // Arrange
        final json = {
          'dt': {
            'ip': true,
            'flag1': false,
            'flag2': true,
            'flag3': false,
          },
        };

        // Act
        final response = CheckDeviceTestingResponse.fromJson(json);

        // Assert
        expect(response.response.length, 4);
        expect(response.response['ip'], true);
        expect(response.response['flag1'], false);
        expect(response.response['flag2'], true);
        expect(response.response['flag3'], false);
      });

      test('should handle unicode characters in keys', () {
        // Arrange
        final json = {
          'dt': {
            'ip': true,
            'テスト': false,
            '测试': true,
          },
        };

        // Act
        final response = CheckDeviceTestingResponse.fromJson(json);

        // Assert
        expect(response.response['テスト'], false);
        expect(response.response['测试'], true);
      });

      test('should handle very long key names', () {
        // Arrange
        final longKey = 'this_is_a_very_long_key_name_that_might_be_used_in_testing';
        final json = {
          'dt': {
            'ip': true,
            longKey: false,
          },
        };

        // Act
        final response = CheckDeviceTestingResponse.fromJson(json);

        // Assert
        expect(response.response[longKey], false);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data integrity through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com',
          'dt': {
            'ip': true,
            'isComplete': false,
          },
        };

        // Act
        final response = CheckDeviceTestingResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['dt']['ip'], true);
        expect(serialized['dt']['isComplete'], false);
        expect(response.isTestingPass, true);
      });

      test('should maintain isTestingPass value after round-trip', () {
        // Arrange
        final originalJson = {
          'dt': {'ip': true},
        };

        // Act
        final response = CheckDeviceTestingResponse.fromJson(originalJson);
        final serialized = response.toJson();
        final reparsed = CheckDeviceTestingResponse.fromJson(serialized);

        // Assert
        expect(reparsed.isTestingPass, response.isTestingPass);
      });
    });

    group('response map access', () {
      test('should allow direct access to response map values', () {
        // Arrange
        final response = CheckDeviceTestingResponse.fromJson({
          'dt': {'ip': true, 'custom': false},
        });

        // Act & Assert
        expect(response.response.containsKey('ip'), true);
        expect(response.response.containsKey('custom'), true);
        expect(response.response.containsKey('nonexistent'), false);
      });

      test('should allow iteration over response map', () {
        // Arrange
        final response = CheckDeviceTestingResponse.fromJson({
          'dt': {'a': true, 'b': false, 'c': true},
        });

        // Act
        final trueCount = response.response.values.where((v) => v).length;
        final falseCount = response.response.values.where((v) => !v).length;

        // Assert
        expect(trueCount, 2);
        expect(falseCount, 1);
      });
    });
  });
}
