import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/gaurd/models/upload_invoice_comp_param.dart';

void main() {
  group('UploadInvoiceCompParam', () {
    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final param = UploadInvoiceCompParam(
          selectedAgent: 'FedEx',
          deviceCount: 100,
        );

        // Assert
        expect(param.selectedAgent, 'FedEx');
        expect(param.deviceCount, 100);
      });

      test('should create instance with no parameters', () {
        // Act
        final param = UploadInvoiceCompParam();

        // Assert
        expect(param.selectedAgent, isNull);
        expect(param.deviceCount, isNull);
      });

      test('should create instance with only selectedAgent', () {
        // Act
        final param = UploadInvoiceCompParam(
          selectedAgent: 'DHL',
        );

        // Assert
        expect(param.selectedAgent, 'DHL');
        expect(param.deviceCount, isNull);
      });

      test('should create instance with only deviceCount', () {
        // Act
        final param = UploadInvoiceCompParam(
          deviceCount: 50,
        );

        // Assert
        expect(param.selectedAgent, isNull);
        expect(param.deviceCount, 50);
      });
    });

    group('selectedAgent property', () {
      test('should handle empty agent string', () {
        // Act
        final param = UploadInvoiceCompParam(
          selectedAgent: '',
        );

        // Assert
        expect(param.selectedAgent, '');
      });

      test('should handle agent with special characters', () {
        // Act
        final param = UploadInvoiceCompParam(
          selectedAgent: 'Agent-001_XYZ',
        );

        // Assert
        expect(param.selectedAgent, 'Agent-001_XYZ');
      });

      test('should handle agent with unicode characters', () {
        // Act
        final param = UploadInvoiceCompParam(
          selectedAgent: 'एजेंट',
        );

        // Assert
        expect(param.selectedAgent, 'एजेंट');
      });

      test('should handle agent with whitespace', () {
        // Act
        final param = UploadInvoiceCompParam(
          selectedAgent: '  Agent Name  ',
        );

        // Assert
        expect(param.selectedAgent, '  Agent Name  ');
      });

      test('should handle long agent name', () {
        // Arrange
        final longName = 'A' * 500;

        // Act
        final param = UploadInvoiceCompParam(
          selectedAgent: longName,
        );

        // Assert
        expect(param.selectedAgent!.length, 500);
      });
    });

    group('deviceCount property', () {
      test('should handle zero device count', () {
        // Act
        final param = UploadInvoiceCompParam(
          deviceCount: 0,
        );

        // Assert
        expect(param.deviceCount, 0);
      });

      test('should handle positive device count', () {
        // Act
        final param = UploadInvoiceCompParam(
          deviceCount: 1000,
        );

        // Assert
        expect(param.deviceCount, 1000);
      });

      test('should handle large device count', () {
        // Act
        final param = UploadInvoiceCompParam(
          deviceCount: 999999999,
        );

        // Assert
        expect(param.deviceCount, 999999999);
      });

      test('should handle negative device count', () {
        // Act
        final param = UploadInvoiceCompParam(
          deviceCount: -1,
        );

        // Assert
        expect(param.deviceCount, -1);
      });

      test('should handle single device', () {
        // Act
        final param = UploadInvoiceCompParam(
          deviceCount: 1,
        );

        // Assert
        expect(param.deviceCount, 1);
      });
    });

    group('typical usage scenarios', () {
      test('should create param for invoice upload with FedEx', () {
        // Arrange & Act
        final param = UploadInvoiceCompParam(
          selectedAgent: 'FedEx',
          deviceCount: 250,
        );

        // Assert
        expect(param.selectedAgent, 'FedEx');
        expect(param.deviceCount, 250);
      });

      test('should create param for invoice upload with DHL', () {
        // Arrange & Act
        final param = UploadInvoiceCompParam(
          selectedAgent: 'DHL Express',
          deviceCount: 100,
        );

        // Assert
        expect(param.selectedAgent, 'DHL Express');
        expect(param.deviceCount, 100);
      });

      test('should create param for bulk shipment', () {
        // Arrange & Act
        final param = UploadInvoiceCompParam(
          selectedAgent: 'Bulk Courier',
          deviceCount: 5000,
        );

        // Assert
        expect(param.selectedAgent, 'Bulk Courier');
        expect(param.deviceCount, 5000);
      });

      test('should create param for small shipment', () {
        // Arrange & Act
        final param = UploadInvoiceCompParam(
          selectedAgent: 'Local Courier',
          deviceCount: 5,
        );

        // Assert
        expect(param.selectedAgent, 'Local Courier');
        expect(param.deviceCount, 5);
      });
    });

    group('edge cases', () {
      test('should handle agent name with numbers', () {
        // Act
        final param = UploadInvoiceCompParam(
          selectedAgent: 'Agent123',
        );

        // Assert
        expect(param.selectedAgent, 'Agent123');
      });

      test('should handle agent name with slashes', () {
        // Act
        final param = UploadInvoiceCompParam(
          selectedAgent: 'Agent/Sub-Agent',
        );

        // Assert
        expect(param.selectedAgent, 'Agent/Sub-Agent');
      });

      test('should handle typical courier names', () {
        // Arrange
        final courierNames = ['FedEx', 'DHL', 'BlueDart', 'DTDC', 'Delhivery'];

        for (final name in courierNames) {
          // Act
          final param = UploadInvoiceCompParam(
            selectedAgent: name,
            deviceCount: 100,
          );

          // Assert
          expect(param.selectedAgent, name);
        }
      });

      test('should handle emoji in agent name', () {
        // Act
        final param = UploadInvoiceCompParam(
          selectedAgent: 'Agent 🚚',
        );

        // Assert
        expect(param.selectedAgent, 'Agent 🚚');
      });
    });
  });

  group('UploadInvoiceCompParamKeys', () {
    test('deviceCount should have value "deviceCount"', () {
      expect(UploadInvoiceCompParamKeys.deviceCount.value, 'deviceCount');
    });

    test('selectedAgent should have value "selectedAgent"', () {
      expect(UploadInvoiceCompParamKeys.selectedAgent.value, 'selectedAgent');
    });

    test('should have exactly 2 keys', () {
      expect(UploadInvoiceCompParamKeys.values.length, 2);
    });

    group('enum names', () {
      test('deviceCount should have correct name', () {
        expect(UploadInvoiceCompParamKeys.deviceCount.name, 'deviceCount');
      });

      test('selectedAgent should have correct name', () {
        expect(UploadInvoiceCompParamKeys.selectedAgent.name, 'selectedAgent');
      });
    });

    group('enum order', () {
      test('values should be in expected order', () {
        final values = UploadInvoiceCompParamKeys.values;
        expect(values[0], UploadInvoiceCompParamKeys.deviceCount);
        expect(values[1], UploadInvoiceCompParamKeys.selectedAgent);
      });
    });

    group('enum indices', () {
      test('deviceCount should have index 0', () {
        expect(UploadInvoiceCompParamKeys.deviceCount.index, 0);
      });

      test('selectedAgent should have index 1', () {
        expect(UploadInvoiceCompParamKeys.selectedAgent.index, 1);
      });
    });

    group('typical usage', () {
      test('should support map as key', () {
        final map = {
          UploadInvoiceCompParamKeys.selectedAgent: 'FedEx',
          UploadInvoiceCompParamKeys.deviceCount: 100,
        };
        expect(map[UploadInvoiceCompParamKeys.selectedAgent], 'FedEx');
        expect(map[UploadInvoiceCompParamKeys.deviceCount], 100);
      });

      test('should iterate over all values', () {
        var count = 0;
        for (final key in UploadInvoiceCompParamKeys.values) {
          count++;
          expect(key, isA<UploadInvoiceCompParamKeys>());
        }
        expect(count, 2);
      });
    });
  });
}
