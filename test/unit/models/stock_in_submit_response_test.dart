import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/models/stock_in_submit_response.dart';

/// Tests for StockInSubmitResponse model.
/// Focus: Testing fromJson/toJson for stock-in submission response with success flags.
void main() {
  group('StockInSubmitResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'success': true,
          's': true,
          'cm': 'Stock in completed successfully',
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.success, true);
        expect(response.status, true);
        expect(response.confirmationMessage, 'Stock in completed successfully');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.success, null);
        expect(response.status, null);
        expect(response.confirmationMessage, null);
      });

      test('should handle null success only', () {
        // Arrange
        final json = {
          'success': null,
          's': true,
          'cm': 'Test message',
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.success, null);
        expect(response.status, true);
        expect(response.confirmationMessage, 'Test message');
      });

      test('should handle null status only', () {
        // Arrange
        final json = {
          'success': true,
          's': null,
          'cm': 'Test message',
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.success, true);
        expect(response.status, null);
        expect(response.confirmationMessage, 'Test message');
      });

      test('should handle null confirmationMessage only', () {
        // Arrange
        final json = {
          'success': true,
          's': true,
          'cm': null,
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.success, true);
        expect(response.status, true);
        expect(response.confirmationMessage, null);
      });

      test('should handle success as false', () {
        // Arrange
        final json = {
          'success': false,
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.success, false);
      });

      test('should handle status as false', () {
        // Arrange
        final json = {
          's': false,
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.status, false);
      });

      test('should handle both success and status as false', () {
        // Arrange
        final json = {
          'success': false,
          's': false,
          'cm': 'Operation failed',
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.success, false);
        expect(response.status, false);
        expect(response.confirmationMessage, 'Operation failed');
      });

      test('should handle mixed success and status values', () {
        // Arrange
        final json = {
          'success': true,
          's': false,
          'cm': 'Partial success',
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.success, true);
        expect(response.status, false);
        expect(response.confirmationMessage, 'Partial success');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = StockInSubmitResponse();
        response.success = true;
        response.status = true;
        response.confirmationMessage = 'Serialization test';

        // Act
        final json = response.toJson();

        // Assert
        expect(json['success'], true);
        expect(json['s'], true);
        expect(json['cm'], 'Serialization test');
      });

      test('should handle null fields in serialization', () {
        // Arrange
        final response = StockInSubmitResponse();

        // Act
        final json = response.toJson();

        // Assert
        expect(json['success'], null);
        expect(json['s'], null);
        expect(json['cm'], null);
      });

      test('should serialize false values correctly', () {
        // Arrange
        final response = StockInSubmitResponse();
        response.success = false;
        response.status = false;

        // Act
        final json = response.toJson();

        // Assert
        expect(json['success'], false);
        expect(json['s'], false);
      });

      test('should serialize partial data', () {
        // Arrange
        final response = StockInSubmitResponse();
        response.success = true;

        // Act
        final json = response.toJson();

        // Assert
        expect(json['success'], true);
        expect(json['s'], null);
        expect(json['cm'], null);
      });
    });

    group('constructor', () {
      test('should create instance with default null values', () {
        // Act
        final response = StockInSubmitResponse();

        // Assert
        expect(response.success, null);
        expect(response.status, null);
        expect(response.confirmationMessage, null);
      });

      test('should allow setting values after construction', () {
        // Act
        final response = StockInSubmitResponse();
        response.success = true;
        response.status = true;
        response.confirmationMessage = 'Set after construction';

        // Assert
        expect(response.success, true);
        expect(response.status, true);
        expect(response.confirmationMessage, 'Set after construction');
      });

      test('should allow updating values after construction', () {
        // Act
        final response = StockInSubmitResponse();
        response.success = true;
        response.success = false; // Update

        // Assert
        expect(response.success, false);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'success': true,
          's': true,
          'cm': 'Round trip test message',
        };

        // Act
        final response = StockInSubmitResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['success'], originalJson['success']);
        expect(serialized['s'], originalJson['s']);
        expect(serialized['cm'], originalJson['cm']);
      });

      test('should maintain null values through cycle', () {
        // Arrange
        final originalJson = <String, dynamic>{
          'success': null,
          's': null,
          'cm': null,
        };

        // Act
        final response = StockInSubmitResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['success'], null);
        expect(serialized['s'], null);
        expect(serialized['cm'], null);
      });

      test('should maintain false values through cycle', () {
        // Arrange
        final originalJson = {
          'success': false,
          's': false,
          'cm': 'Failed operation',
        };

        // Act
        final response = StockInSubmitResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['success'], false);
        expect(serialized['s'], false);
        expect(serialized['cm'], 'Failed operation');
      });
    });

    group('edge cases', () {
      test('should handle empty string confirmationMessage', () {
        // Arrange
        final json = {
          'cm': '',
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.confirmationMessage, '');
      });

      test('should handle whitespace-only confirmationMessage', () {
        // Arrange
        final json = {
          'cm': '   ',
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.confirmationMessage, '   ');
      });

      test('should handle long confirmationMessage', () {
        // Arrange
        final longMessage = 'A' * 1000;
        final json = {
          'cm': longMessage,
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.confirmationMessage!.length, 1000);
      });

      test('should handle special characters in confirmationMessage', () {
        // Arrange
        final json = {
          'cm': 'Stock in completed! Device #123 processed.\nTotal: 5 items.',
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.confirmationMessage!.contains('#'), true);
        expect(response.confirmationMessage!.contains('\n'), true);
      });

      test('should handle unicode in confirmationMessage', () {
        // Arrange
        final json = {
          'cm': 'स्टॉक इन सफलतापूर्वक पूर्ण हुआ ✓',
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.confirmationMessage, 'स्टॉक इन सफलतापूर्वक पूर्ण हुआ ✓');
      });

      test('should handle HTML-like content in confirmationMessage', () {
        // Arrange
        final json = {
          'cm': '<b>Success</b>: Device processed',
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.confirmationMessage, '<b>Success</b>: Device processed');
      });

      test('should handle JSON-like content in confirmationMessage', () {
        // Arrange
        final json = {
          'cm': '{"status": "ok", "count": 5}',
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.confirmationMessage, '{"status": "ok", "count": 5}');
      });
    });

    group('typical API response scenarios', () {
      test('should handle successful stock-in response', () {
        // Arrange
        final json = {
          'success': true,
          's': true,
          'cm': 'Device QR-001 successfully stocked in at location LOC-A1',
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.success, true);
        expect(response.status, true);
        expect(response.confirmationMessage!.contains('QR-001'), true);
      });

      test('should handle failed stock-in response due to invalid AWB', () {
        // Arrange
        final json = {
          'success': false,
          's': false,
          'cm': 'Invalid AWB number provided',
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.success, false);
        expect(response.status, false);
        expect(response.confirmationMessage!.contains('Invalid'), true);
      });

      test('should handle failed stock-in response due to device not found', () {
        // Arrange
        final json = {
          'success': false,
          's': false,
          'cm': 'Device not found in manifest',
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.success, false);
        expect(response.confirmationMessage!.contains('not found'), true);
      });

      test('should handle response with only success flag', () {
        // Arrange
        final json = {
          'success': true,
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.success, true);
        expect(response.status, null);
        expect(response.confirmationMessage, null);
      });

      test('should handle response with only status flag', () {
        // Arrange
        final json = {
          's': true,
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.success, null);
        expect(response.status, true);
        expect(response.confirmationMessage, null);
      });

      test('should handle response with only confirmationMessage', () {
        // Arrange
        final json = {
          'cm': 'Processing complete',
        };

        // Act
        final response = StockInSubmitResponse.fromJson(json);

        // Assert
        expect(response.success, null);
        expect(response.status, null);
        expect(response.confirmationMessage, 'Processing complete');
      });
    });
  });
}
