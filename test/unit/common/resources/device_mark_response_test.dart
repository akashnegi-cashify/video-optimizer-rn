import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/resources/device_mark_response.dart';

void main() {
  group('DeviceMarkResponse', () {
    group('constructor', () {
      test('creates instance with all parameters', () {
        final response = DeviceMarkResponse(
          success: true,
          status: true,
          message: 'Device marked successfully',
          confirmMessage: 'Please confirm',
        );

        expect(response.success, true);
        expect(response.status, true);
        expect(response.message, 'Device marked successfully');
        expect(response.confirmMessage, 'Please confirm');
      });

      test('creates instance with null parameters', () {
        final response = DeviceMarkResponse();

        expect(response.success, isNull);
        expect(response.status, isNull);
        expect(response.message, isNull);
        expect(response.confirmMessage, isNull);
      });

      test('creates instance with partial parameters', () {
        final response = DeviceMarkResponse(
          success: true,
          message: 'Partial message',
        );

        expect(response.success, true);
        expect(response.status, isNull);
        expect(response.message, 'Partial message');
        expect(response.confirmMessage, isNull);
      });
    });

    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = {
          'success': true,
          's': true,
          'message': 'Device has been marked',
          'cm': 'Are you sure you want to proceed?',
        };

        final response = DeviceMarkResponse.fromJson(json);

        expect(response.success, true);
        expect(response.status, true);
        expect(response.message, 'Device has been marked');
        expect(response.confirmMessage, 'Are you sure you want to proceed?');
      });

      test('handles null fields', () {
        final json = <String, dynamic>{
          'success': null,
          's': null,
          'message': null,
          'cm': null,
        };

        final response = DeviceMarkResponse.fromJson(json);

        expect(response.success, isNull);
        expect(response.status, isNull);
        expect(response.message, isNull);
        expect(response.confirmMessage, isNull);
      });

      test('handles missing fields', () {
        final json = <String, dynamic>{};

        final response = DeviceMarkResponse.fromJson(json);

        expect(response.success, isNull);
        expect(response.status, isNull);
        expect(response.message, isNull);
        expect(response.confirmMessage, isNull);
      });

      test('parses success as false', () {
        final json = {
          'success': false,
          's': false,
        };

        final response = DeviceMarkResponse.fromJson(json);

        expect(response.success, false);
        expect(response.status, false);
      });
    });

    group('toJson', () {
      test('serializes all fields correctly', () {
        final response = DeviceMarkResponse(
          success: true,
          status: true,
          message: 'Test message',
          confirmMessage: 'Test confirm',
        );

        final json = response.toJson();

        expect(json['success'], true);
        expect(json['s'], true);
        expect(json['message'], 'Test message');
        expect(json['cm'], 'Test confirm');
      });

      test('serializes null values', () {
        final response = DeviceMarkResponse();

        final json = response.toJson();

        expect(json['success'], isNull);
        expect(json['s'], isNull);
        expect(json['message'], isNull);
        expect(json['cm'], isNull);
      });

      test('serializes empty string message', () {
        final response = DeviceMarkResponse(message: '');

        final json = response.toJson();

        expect(json['message'], '');
      });
    });

    group('isValid', () {
      test('returns true when status is true', () {
        final response = DeviceMarkResponse(status: true);

        expect(response.isValid(), true);
      });

      test('returns false when status is false', () {
        final response = DeviceMarkResponse(status: false);

        expect(response.isValid(), false);
      });

      test('returns false when status is null', () {
        final response = DeviceMarkResponse(status: null);

        expect(response.isValid(), false);
      });

      test('isValid is independent of success field', () {
        // success: true, status: false -> isValid returns false
        final response1 = DeviceMarkResponse(success: true, status: false);
        expect(response1.isValid(), false);

        // success: false, status: true -> isValid returns true
        final response2 = DeviceMarkResponse(success: false, status: true);
        expect(response2.isValid(), true);
      });
    });

    group('property assignments', () {
      test('can update success', () {
        final response = DeviceMarkResponse();
        response.success = true;

        expect(response.success, true);
      });

      test('can update status', () {
        final response = DeviceMarkResponse();
        response.status = true;

        expect(response.status, true);
      });

      test('can update message', () {
        final response = DeviceMarkResponse();
        response.message = 'Updated message';

        expect(response.message, 'Updated message');
      });

      test('can update confirmMessage', () {
        final response = DeviceMarkResponse();
        response.confirmMessage = 'Updated confirm message';

        expect(response.confirmMessage, 'Updated confirm message');
      });
    });

    group('round-trip serialization', () {
      test('fromJson then toJson preserves data', () {
        final originalJson = {
          'success': true,
          's': true,
          'message': 'Round trip test',
          'cm': 'Confirm this',
        };

        final response = DeviceMarkResponse.fromJson(originalJson);
        final resultJson = response.toJson();

        expect(resultJson['success'], originalJson['success']);
        expect(resultJson['s'], originalJson['s']);
        expect(resultJson['message'], originalJson['message']);
        expect(resultJson['cm'], originalJson['cm']);
      });
    });
  });
}
