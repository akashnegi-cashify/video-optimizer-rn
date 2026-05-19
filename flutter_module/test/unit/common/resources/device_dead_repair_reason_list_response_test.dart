import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/resources/device_dead_repair_reason_list_response.dart';

void main() {
  group('DeviceDeadRepairReasonListResponse', () {
    group('constructor', () {
      test('creates instance with data', () {
        final response = DeviceDeadRepairReasonListResponse(
          data: ['Reason 1', 'Reason 2', 'Reason 3'],
        );

        expect(response.data, ['Reason 1', 'Reason 2', 'Reason 3']);
      });

      test('creates instance with null data', () {
        final response = DeviceDeadRepairReasonListResponse(data: null);

        expect(response.data, isNull);
      });

      test('creates instance with empty data', () {
        final response = DeviceDeadRepairReasonListResponse(data: []);

        expect(response.data, isEmpty);
      });

      test('creates instance with data containing nulls', () {
        final response = DeviceDeadRepairReasonListResponse(
          data: ['Reason 1', null, 'Reason 3'],
        );

        expect(response.data?.length, 3);
        expect(response.data?[1], isNull);
      });
    });

    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = {
          'dt': ['Water damage', 'Screen broken', 'Dead battery'],
          'success': true,
          's': 1,
          'message': 'Reasons fetched successfully',
        };

        final response = DeviceDeadRepairReasonListResponse.fromJson(json);

        expect(response.data?.length, 3);
        expect(response.data?[0], 'Water damage');
        expect(response.success, true);
        expect(response.status, 1);
        expect(response.message, 'Reasons fetched successfully');
      });

      test('handles null fields', () {
        final json = <String, dynamic>{
          'dt': null,
          'success': null,
          's': null,
          'message': null,
        };

        final response = DeviceDeadRepairReasonListResponse.fromJson(json);

        expect(response.data, isNull);
        expect(response.success, isNull);
        expect(response.status, isNull);
        expect(response.message, isNull);
      });

      test('handles missing fields', () {
        final json = <String, dynamic>{};

        final response = DeviceDeadRepairReasonListResponse.fromJson(json);

        expect(response.data, isNull);
        expect(response.success, isNull);
        expect(response.status, isNull);
      });

      test('parses success as false', () {
        final json = {
          'success': false,
          's': 0,
        };

        final response = DeviceDeadRepairReasonListResponse.fromJson(json);

        expect(response.success, false);
        expect(response.status, 0);
      });

      test('parses empty data list', () {
        final json = {
          'dt': <String>[],
        };

        final response = DeviceDeadRepairReasonListResponse.fromJson(json);

        expect(response.data, isEmpty);
      });
    });

    group('toJson', () {
      test('serializes all fields correctly', () {
        final response = DeviceDeadRepairReasonListResponse(
          data: ['Reason A', 'Reason B'],
        );
        response.success = true;
        response.status = 1;
        response.message = 'Success';

        final json = response.toJson();

        expect(json['dt'], ['Reason A', 'Reason B']);
        expect(json['success'], true);
        expect(json['s'], 1);
        expect(json['message'], 'Success');
      });

      test('serializes null values', () {
        final response = DeviceDeadRepairReasonListResponse();

        final json = response.toJson();

        expect(json['dt'], isNull);
        expect(json['success'], isNull);
        expect(json['s'], isNull);
        expect(json['message'], isNull);
      });
    });

    group('isValid', () {
      test('returns true when status is 1', () {
        final response = DeviceDeadRepairReasonListResponse();
        response.status = 1;

        expect(response.isValid(), true);
      });

      test('returns false when status is 0', () {
        final response = DeviceDeadRepairReasonListResponse();
        response.status = 0;

        expect(response.isValid(), false);
      });

      test('returns false when status is null', () {
        final response = DeviceDeadRepairReasonListResponse();
        response.status = null;

        expect(response.isValid(), false);
      });

      test('returns false when status is negative', () {
        final response = DeviceDeadRepairReasonListResponse();
        response.status = -1;

        expect(response.isValid(), false);
      });

      test('returns false when status is greater than 1', () {
        final response = DeviceDeadRepairReasonListResponse();
        response.status = 2;

        expect(response.isValid(), false);
      });
    });

    group('property assignments', () {
      test('can update data', () {
        final response = DeviceDeadRepairReasonListResponse();
        response.data = ['New reason'];

        expect(response.data, ['New reason']);
      });

      test('can update success', () {
        final response = DeviceDeadRepairReasonListResponse();
        response.success = true;

        expect(response.success, true);
      });

      test('can update status', () {
        final response = DeviceDeadRepairReasonListResponse();
        response.status = 1;

        expect(response.status, 1);
      });

      test('can update message', () {
        final response = DeviceDeadRepairReasonListResponse();
        response.message = 'New message';

        expect(response.message, 'New message');
      });
    });
  });
}
