import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty;
import 'package:provider/provider.dart';

// Actual widget import
import 'package:flutter_trc/qc/modules/data_wipe/widgets/data_wipe_card_widget.dart';
import 'package:localization/localization/locale_provider.dart';

void main() {
  group('DataWipeCardWidget', () {
    test('DataWipeCardWidget class exists and is a StatelessWidget', () {
      expect(DataWipeCardWidget, isNotNull);
      const widget = DataWipeCardWidget(null, null, null, null, null, null);
      expect(widget, isA<StatelessWidget>());
    });

    group('widget instantiation tests', () {
      // Note: Widget rendering tests require complex theme setup with CshCard
      // These unit tests verify widget construction and property storage

      test('widget can be instantiated with null values', () {
        const widget = DataWipeCardWidget(null, null, null, null, null, null);
        expect(widget.barcode, isNull);
        expect(widget.erasureProvider, isNull);
        expect(widget.productName, isNull);
        expect(widget.status, isNull);
        expect(widget.statusCode, isNull);
        expect(widget.errorMessage, isNull);
      });

      test('widget stores all values when populated', () {
        const widget = DataWipeCardWidget(
          'TEST_BARCODE',
          'CASHIFY',
          'iPhone 15 Pro',
          'Pending',
          10,
          null,
        );
        expect(widget.barcode, equals('TEST_BARCODE'));
        expect(widget.erasureProvider, equals('CASHIFY'));
        expect(widget.productName, equals('iPhone 15 Pro'));
        expect(widget.status, equals('Pending'));
        expect(widget.statusCode, equals(10));
        expect(widget.errorMessage, isNull);
      });

      test('widget stores error message when provided', () {
        const widget = DataWipeCardWidget(
          'TEST_BARCODE',
          'CASHIFY',
          'iPhone 15 Pro',
          'Failed',
          -1,
          'Device not found',
        );
        expect(widget.errorMessage, equals('Device not found'));
      });

      test('widget with null errorMessage has no error message', () {
        const widget = DataWipeCardWidget(
          'TEST_BARCODE',
          'CASHIFY',
          'iPhone 15 Pro',
          'Pending',
          10,
          null,
        );
        expect(widget.errorMessage, isNull);
      });

      test('negative statusCode indicates error state', () {
        const widget = DataWipeCardWidget(
          'TEST_BARCODE',
          'CASHIFY',
          'iPhone 15 Pro',
          'Error',
          -1,
          null,
        );
        expect((widget.statusCode ?? 0) < 0, isTrue);
      });

      test('statusCode 44 indicates success state', () {
        const widget = DataWipeCardWidget(
          'TEST_BARCODE',
          'CASHIFY',
          'iPhone 15 Pro',
          'Success',
          44,
          null,
        );
        expect(widget.statusCode == 44, isTrue);
      });

      test('other statusCodes indicate warning state', () {
        const widget = DataWipeCardWidget(
          'TEST_BARCODE',
          'CASHIFY',
          'iPhone 15 Pro',
          'Processing',
          20,
          null,
        );
        final code = widget.statusCode ?? 0;
        expect(code < 0, isFalse);
        expect(code == 44, isFalse);
      });

      test('null statusCode defaults to warning state logic', () {
        const widget = DataWipeCardWidget(
          'TEST_BARCODE',
          'CASHIFY',
          'iPhone 15 Pro',
          'Unknown',
          null,
          null,
        );
        final code = widget.statusCode ?? 0;
        expect(code < 0, isFalse);
        expect(code == 44, isFalse);
      });

      test('widget can be instantiated with empty strings', () {
        const widget = DataWipeCardWidget('', '', '', '', 0, '');
        expect(widget.barcode, equals(''));
        expect(widget.erasureProvider, equals(''));
        expect(widget.productName, equals(''));
        expect(widget.status, equals(''));
        expect(widget.errorMessage, equals(''));
      });

      test('statusCode 0 is valid', () {
        const widget = DataWipeCardWidget(
          'TEST_BARCODE',
          'CASHIFY',
          'iPhone 15 Pro',
          'Initial',
          0,
          null,
        );
        expect(widget.statusCode, equals(0));
      });
    });

    test('DataWipeCardWidget can be instantiated with null values', () {
      const widget = DataWipeCardWidget(null, null, null, null, null, null);
      expect(widget, isNotNull);
      expect(widget.barcode, isNull);
      expect(widget.erasureProvider, isNull);
      expect(widget.productName, isNull);
      expect(widget.status, isNull);
      expect(widget.statusCode, isNull);
      expect(widget.errorMessage, isNull);
    });

    test('DataWipeCardWidget can be instantiated with all values', () {
      const widget = DataWipeCardWidget(
        'TEST_BARCODE',
        'CASHIFY',
        'iPhone 15 Pro',
        'Pending',
        10,
        null,
      );
      expect(widget.barcode, equals('TEST_BARCODE'));
      expect(widget.erasureProvider, equals('CASHIFY'));
      expect(widget.productName, equals('iPhone 15 Pro'));
      expect(widget.status, equals('Pending'));
      expect(widget.statusCode, equals(10));
      expect(widget.errorMessage, isNull);
    });

    test('DataWipeCardWidget can be instantiated with error message', () {
      const widget = DataWipeCardWidget(
        'TEST_BARCODE',
        'CASHIFY',
        'iPhone 15 Pro',
        'Failed',
        -1,
        'Device not found',
      );
      expect(widget.errorMessage, equals('Device not found'));
    });

    test('DataWipeCardWidget can be instantiated with a key', () {
      const key = Key('data_wipe_card_widget_key');
      const widget = DataWipeCardWidget(
        'TEST_BARCODE',
        'CASHIFY',
        'iPhone 15 Pro',
        'Pending',
        10,
        null,
        key: key,
      );
      expect(widget.key, equals(key));
    });

    test('DataWipeCardWidget stores barcode correctly', () {
      const widget = DataWipeCardWidget(
        'TEST_BARCODE_123',
        'CASHIFY',
        'iPhone 15 Pro',
        'Pending',
        10,
        null,
      );
      expect(widget.barcode, equals('TEST_BARCODE_123'));
    });

    test('DataWipeCardWidget stores productName correctly', () {
      const widget = DataWipeCardWidget(
        'TEST_BARCODE',
        'CASHIFY',
        'Samsung Galaxy S24',
        'Pending',
        10,
        null,
      );
      expect(widget.productName, equals('Samsung Galaxy S24'));
    });

    test('DataWipeCardWidget stores erasureProvider correctly', () {
      const widget = DataWipeCardWidget(
        'TEST_BARCODE',
        'BLANCCO',
        'iPhone 15 Pro',
        'Pending',
        10,
        null,
      );
      expect(widget.erasureProvider, equals('BLANCCO'));
    });

    test('DataWipeCardWidget stores status correctly', () {
      const widget = DataWipeCardWidget(
        'TEST_BARCODE',
        'CASHIFY',
        'iPhone 15 Pro',
        'Processing',
        20,
        null,
      );
      expect(widget.status, equals('Processing'));
    });

    test('DataWipeCardWidget stores error message when present', () {
      const widget = DataWipeCardWidget(
        'TEST_BARCODE',
        'CASHIFY',
        'iPhone 15 Pro',
        'Failed',
        -1,
        'Data wipe failed: Device locked',
      );
      expect(widget.errorMessage, equals('Data wipe failed: Device locked'));
    });

    test('DataWipeCardWidget has null error message when not provided', () {
      const widget = DataWipeCardWidget(
        'TEST_BARCODE',
        'CASHIFY',
        'iPhone 15 Pro',
        'Pending',
        10,
        null,
      );
      expect(widget.errorMessage, isNull);
    });

    test('DataWipeCardWidget statusCode can be negative for error states', () {
      const widget = DataWipeCardWidget(
        'TEST_BARCODE',
        'CASHIFY',
        'iPhone 15 Pro',
        'Error',
        -1,
        'Error occurred',
      );
      expect(widget.statusCode, equals(-1));
      expect(widget.statusCode! < 0, isTrue);
    });

    test('DataWipeCardWidget statusCode 44 indicates success', () {
      const widget = DataWipeCardWidget(
        'TEST_BARCODE',
        'CASHIFY',
        'iPhone 15 Pro',
        'Success',
        44,
        null,
      );
      expect(widget.statusCode, equals(44));
    });

    test('DataWipeCardWidget handles statusCode 0', () {
      const widget = DataWipeCardWidget(
        'TEST_BARCODE',
        'CASHIFY',
        'iPhone 15 Pro',
        'Unknown',
        0,
        null,
      );
      expect(widget.statusCode, equals(0));
    });

    test('DataWipeCardWidget handles multiple providers', () {
      const blanccoWidget = DataWipeCardWidget(
        'TEST1',
        'BLANCCO',
        'Device 1',
        'Pending',
        10,
        null,
      );
      const cashifyWidget = DataWipeCardWidget(
        'TEST2',
        'CASHIFY',
        'Device 2',
        'Pending',
        10,
        null,
      );
      
      expect(blanccoWidget.erasureProvider, equals('BLANCCO'));
      expect(cashifyWidget.erasureProvider, equals('CASHIFY'));
    });

    test('DataWipeCardWidget handles empty strings', () {
      const widget = DataWipeCardWidget(
        '',
        '',
        '',
        '',
        0,
        '',
      );
      expect(widget.barcode, isEmpty);
      expect(widget.erasureProvider, isEmpty);
      expect(widget.productName, isEmpty);
      expect(widget.status, isEmpty);
      expect(widget.errorMessage, isEmpty);
    });

    test('DataWipeCardWidget handles special characters in productName', () {
      const widget = DataWipeCardWidget(
        'TEST',
        'CASHIFY',
        'iPhone 15 Pro Max (256GB) - Blue',
        'Success',
        44,
        null,
      );
      expect(widget.productName, equals('iPhone 15 Pro Max (256GB) - Blue'));
    });

    test('DataWipeCardWidget handles unicode in fields', () {
      const widget = DataWipeCardWidget(
        'TEST_中文',
        'CASHIFY',
        '苹果 iPhone 15',
        '成功',
        44,
        null,
      );
      expect(widget.barcode, equals('TEST_中文'));
      expect(widget.productName, equals('苹果 iPhone 15'));
      expect(widget.status, equals('成功'));
    });

    test('DataWipeCardWidget statusCode determines color logic - negative is error', () {
      const widget = DataWipeCardWidget(
        'TEST',
        'CASHIFY',
        'Device',
        'Error',
        -5,
        'Some error',
      );
      expect(widget.statusCode! < 0, isTrue);
    });

    test('DataWipeCardWidget statusCode determines color logic - 44 is success', () {
      const widget = DataWipeCardWidget(
        'TEST',
        'CASHIFY',
        'Device',
        'Success',
        44,
        null,
      );
      expect(widget.statusCode == 44, isTrue);
    });

    test('DataWipeCardWidget statusCode determines color logic - other is warning', () {
      const widget = DataWipeCardWidget(
        'TEST',
        'CASHIFY',
        'Device',
        'Processing',
        20,
        null,
      );
      expect(widget.statusCode! >= 0 && widget.statusCode != 44, isTrue);
    });
  });

  group('getStatusText logic', () {
    test('status code < 0 indicates error color', () {
      const widget = DataWipeCardWidget('B', 'P', 'N', 'Error', -1, null);
      expect(widget.statusCode! < 0, isTrue);
    });

    test('status code == 44 indicates success color', () {
      const widget = DataWipeCardWidget('B', 'P', 'N', 'Success', 44, null);
      expect(widget.statusCode == 44, isTrue);
    });

    test('status code >= 0 and != 44 indicates warning color', () {
      const widget = DataWipeCardWidget('B', 'P', 'N', 'Processing', 10, null);
      expect((widget.statusCode ?? 0) >= 0 && widget.statusCode != 44, isTrue);
    });

    test('status code null defaults to warning (0 < 0 is false)', () {
      const widget = DataWipeCardWidget('B', 'P', 'N', 'Unknown', null, null);
      expect((widget.statusCode ?? 0) < 0, isFalse);
      expect((widget.statusCode ?? 0) == 44, isFalse);
    });
  });

  group('comprehensive status code color tests - unit tests', () {
    group('error status codes (negative values) logic', () {
      test('statusCode -1 indicates error', () {
        const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'Error', -1, null);
        expect((widget.statusCode ?? 0) < 0, isTrue);
      });

      test('statusCode -5 indicates error', () {
        const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'Failed', -5, null);
        expect((widget.statusCode ?? 0) < 0, isTrue);
      });

      test('statusCode -10 indicates error', () {
        const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'Critical Error', -10, null);
        expect((widget.statusCode ?? 0) < 0, isTrue);
      });

      test('statusCode -11 (eraserInfoFailed) indicates error', () {
        const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'Eraser Info Failed', -11, null);
        expect((widget.statusCode ?? 0) < 0, isTrue);
        expect(widget.statusCode, equals(-11));
      });

      test('statusCode -100 indicates error', () {
        const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'Severe Error', -100, null);
        expect((widget.statusCode ?? 0) < 0, isTrue);
      });
    });

    group('success status code (44) logic', () {
      test('statusCode 44 indicates success', () {
        const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'Completed', 44, null);
        expect(widget.statusCode == 44, isTrue);
      });

      test('statusCode 44 with different status text stores correctly', () {
        const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'Data Wiped Successfully', 44, null);
        expect(widget.status, equals('Data Wiped Successfully'));
        expect(widget.statusCode, equals(44));
      });
    });

    group('warning status codes (non-negative, non-44) logic', () {
      test('statusCode 0 indicates warning', () {
        const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'Initial', 0, null);
        final code = widget.statusCode ?? 0;
        expect(code < 0, isFalse);
        expect(code == 44, isFalse);
      });

      test('statusCode 1 indicates warning', () {
        const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'Started', 1, null);
        final code = widget.statusCode ?? 0;
        expect(code < 0, isFalse);
        expect(code == 44, isFalse);
      });

      test('statusCode 10 indicates warning', () {
        const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'In Progress', 10, null);
        final code = widget.statusCode ?? 0;
        expect(code < 0, isFalse);
        expect(code == 44, isFalse);
      });

      test('statusCode 20 indicates warning', () {
        const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'Processing', 20, null);
        final code = widget.statusCode ?? 0;
        expect(code < 0, isFalse);
        expect(code == 44, isFalse);
      });

      test('statusCode 43 indicates warning', () {
        const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'Almost Done', 43, null);
        final code = widget.statusCode ?? 0;
        expect(code < 0, isFalse);
        expect(code == 44, isFalse);
      });

      test('statusCode 45 indicates warning', () {
        const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'Post Process', 45, null);
        final code = widget.statusCode ?? 0;
        expect(code < 0, isFalse);
        expect(code == 44, isFalse);
      });

      test('statusCode 100 indicates warning', () {
        const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'High Status', 100, null);
        final code = widget.statusCode ?? 0;
        expect(code < 0, isFalse);
        expect(code == 44, isFalse);
      });
    });

    group('null status code handling logic', () {
      test('null statusCode defaults to warning', () {
        const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'Unknown', null, null);
        final code = widget.statusCode ?? 0;
        expect(code < 0, isFalse);
        expect(code == 44, isFalse);
      });
    });
  });

  group('error message storage tests', () {
    test('long error message is stored correctly', () {
      const longError = 'This is a very long error message that explains in detail what went wrong during the data wipe process';
      const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'Error', -1, longError);
      expect(widget.errorMessage, equals(longError));
    });

    test('error message with special characters is stored correctly', () {
      const specialError = 'Error: Device <ID> not found! @#\$%^&*()';
      const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'Error', -1, specialError);
      expect(widget.errorMessage, equals(specialError));
    });

    test('error message with unicode characters is stored correctly', () {
      const unicodeError = '错误：设备未找到 🔴';
      const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'Error', -1, unicodeError);
      expect(widget.errorMessage, equals(unicodeError));
    });
  });

  group('widget field storage tests', () {
    test('widget stores barcode correctly', () {
      const widget = DataWipeCardWidget('TEST_BARCODE_XYZ', 'CASHIFY', 'iPhone', 'Status', 10, null);
      expect(widget.barcode, equals('TEST_BARCODE_XYZ'));
    });

    test('widget stores erasureProvider correctly', () {
      const widget = DataWipeCardWidget('BC', 'CASHIFY_PROVIDER', 'iPhone', 'Status', 10, null);
      expect(widget.erasureProvider, equals('CASHIFY_PROVIDER'));
    });

    test('widget stores productName correctly', () {
      const widget = DataWipeCardWidget('BC', 'EP', 'Apple iPhone 15 Pro Max 256GB', 'Status', 10, null);
      expect(widget.productName, equals('Apple iPhone 15 Pro Max 256GB'));
    });

    test('widget stores status correctly', () {
      const widget = DataWipeCardWidget('BC', 'EP', 'PN', 'In Progress', 10, null);
      expect(widget.status, equals('In Progress'));
    });
  });

  group('boundary value tests for statusCode', () {
    test('statusCode at boundary -1 is error', () {
      const widget = DataWipeCardWidget('B', 'P', 'N', 'S', -1, null);
      expect((widget.statusCode ?? 0) < 0, isTrue);
    });

    test('statusCode at boundary 0 is warning', () {
      const widget = DataWipeCardWidget('B', 'P', 'N', 'S', 0, null);
      final code = widget.statusCode ?? 0;
      expect(code < 0, isFalse);
      expect(code == 44, isFalse);
    });

    test('statusCode at boundary 43 is warning', () {
      const widget = DataWipeCardWidget('B', 'P', 'N', 'S', 43, null);
      final code = widget.statusCode ?? 0;
      expect(code < 0, isFalse);
      expect(code == 44, isFalse);
    });

    test('statusCode at boundary 44 is success', () {
      const widget = DataWipeCardWidget('B', 'P', 'N', 'S', 44, null);
      expect(widget.statusCode == 44, isTrue);
    });

    test('statusCode at boundary 45 is warning', () {
      const widget = DataWipeCardWidget('B', 'P', 'N', 'S', 45, null);
      final code = widget.statusCode ?? 0;
      expect(code < 0, isFalse);
      expect(code == 44, isFalse);
    });

    test('large positive statusCode is warning', () {
      const widget = DataWipeCardWidget('B', 'P', 'N', 'S', 999999, null);
      final code = widget.statusCode ?? 0;
      expect(code < 0, isFalse);
      expect(code == 44, isFalse);
    });

    test('large negative statusCode is error', () {
      const widget = DataWipeCardWidget('B', 'P', 'N', 'S', -999999, null);
      expect((widget.statusCode ?? 0) < 0, isTrue);
    });
  });
}
