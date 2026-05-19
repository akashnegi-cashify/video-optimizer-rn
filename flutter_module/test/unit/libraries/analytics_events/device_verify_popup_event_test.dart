import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_keys.dart';
import 'package:flutter_trc/src/libraries/analytics/analytic_event_params.dart';
import 'package:flutter_trc/src/libraries/analytics/events/device_verify_popup_event.dart';

void main() {
  group('DeviceVerifyPopupEvent', () {
    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange & Act
        final event = DeviceVerifyPopupEvent('DEVICE123', 1);

        // Assert
        expect(event.barcode, equals('DEVICE123'));
        expect(event.deviceCategory, equals(1));
      });

      test('should create instance with null device category', () {
        // Arrange & Act
        final event = DeviceVerifyPopupEvent('DEVICE123', null);

        // Assert
        expect(event.barcode, equals('DEVICE123'));
        expect(event.deviceCategory, isNull);
      });

      test('should require barcode parameter', () {
        // Arrange & Act
        final event = DeviceVerifyPopupEvent('BARCODE', 1);

        // Assert
        expect(event.barcode, isNotEmpty);
      });
    });

    group('getSubordinateKey', () {
      test('should return correct subordinate key', () {
        // Arrange
        final event = DeviceVerifyPopupEvent('DEVICE', 1);

        // Act
        final key = event.getSubordinateKey();

        // Assert
        expect(key, equals(AnalyticEventKeys.manualTesting.deviceVerifyPopup));
        expect(key, equals('dmt_device_verify_pop_up'));
      });

      test('should return consistent key regardless of parameters', () {
        // Arrange
        final event1 = DeviceVerifyPopupEvent('D1', 1);
        final event2 = DeviceVerifyPopupEvent('D2', 2);
        final event3 = DeviceVerifyPopupEvent('D3', null);

        // Act & Assert
        expect(event1.getSubordinateKey(), equals(event2.getSubordinateKey()));
        expect(event2.getSubordinateKey(), equals(event3.getSubordinateKey()));
      });
    });

    group('getEventKey', () {
      test('should return parent event key', () {
        // Arrange
        final event = DeviceVerifyPopupEvent('DEVICE', 1);

        // Act
        final key = event.getEventKey();

        // Assert
        expect(key, equals(AnalyticEventKeys.manualTesting.parentEventKey));
        expect(key, equals('dmt_manual_testing'));
      });
    });

    group('getArguments', () {
      test('should include device barcode in arguments', () async {
        // Arrange
        final event = DeviceVerifyPopupEvent('DEVICE123', 1);

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceBarcode], equals('DEVICE123'));
      });

      test('should include device category in arguments', () async {
        // Arrange
        final event = DeviceVerifyPopupEvent('DEVICE123', 2);

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceCategory], equals(2));
      });

      test('should handle null device category in arguments', () async {
        // Arrange
        final event = DeviceVerifyPopupEvent('DEVICE123', null);

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceBarcode], equals('DEVICE123'));
        expect(arguments?[AnalyticEventParams.deviceCategory], isNull);
      });

      test('should include common event arguments', () async {
        // Arrange
        final event = DeviceVerifyPopupEvent('DEVICE', 1);

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?.containsKey(AnalyticEventParams.hitTimeStamp), isTrue);
      });
    });

    group('device category variations', () {
      test('should handle category 0', () async {
        // Arrange
        final event = DeviceVerifyPopupEvent('DEVICE', 0);

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceCategory], equals(0));
      });

      test('should handle large category numbers', () async {
        // Arrange
        final event = DeviceVerifyPopupEvent('DEVICE', 99999);

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceCategory], equals(99999));
      });

      test('should handle negative category numbers', () async {
        // Arrange
        final event = DeviceVerifyPopupEvent('DEVICE', -1);

        // Act
        final arguments = await event.getArguments();

        // Assert
        expect(arguments?[AnalyticEventParams.deviceCategory], equals(-1));
      });
    });
  });
}
