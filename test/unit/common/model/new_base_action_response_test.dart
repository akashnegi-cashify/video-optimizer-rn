import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/model/new_base_action_response.dart';

void main() {
  group('NewBaseActionResponse', () {
    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = {
          'r_id': 'ref-123',
          's': 1,
          'em': 'Error message',
          'sm': 'Success message',
          '__ca': null,
          'turl': 'https://track.url',
        };

        final response = NewBaseActionResponse.fromJson(json);

        expect(response.refId, 'ref-123');
        expect(response.isSuccess, 1);
        expect(response.errorMsg, 'Error message');
        expect(response.successMessage, 'Success message');
      });

      test('handles null fields', () {
        final json = <String, dynamic>{
          'r_id': null,
          's': null,
          'em': null,
          'sm': null,
        };

        final response = NewBaseActionResponse.fromJson(json);

        expect(response.refId, isNull);
        expect(response.isSuccess, isNull);
        expect(response.errorMsg, isNull);
        expect(response.successMessage, isNull);
      });

      test('parses isSuccess as integer', () {
        final json1 = {'s': 1};
        final json0 = {'s': 0};
        final jsonNeg = {'s': -1};

        expect(NewBaseActionResponse.fromJson(json1).isSuccess, 1);
        expect(NewBaseActionResponse.fromJson(json0).isSuccess, 0);
        expect(NewBaseActionResponse.fromJson(jsonNeg).isSuccess, -1);
      });

      test('parses CashifyAlert from __ca field', () {
        final json = {
          '__ca': {
            'title': 'Alert Title',
            'message': 'Alert Message',
          },
          's': 1,
        };

        final response = NewBaseActionResponse.fromJson(json);

        expect(response.cashifyAlert, isNotNull);
      });

      test('parses trackUrl from turl field', () {
        final json = {
          'turl': 'https://tracking.url/path',
        };

        final response = NewBaseActionResponse.fromJson(json);

        expect(response.trackUrl, 'https://tracking.url/path');
      });
    });

    group('toJson', () {
      test('serializes all fields correctly', () {
        final response = NewBaseActionResponse(null, 'https://track.url');
        response.refId = 'ref-789';
        response.isSuccess = 1;
        response.errorMsg = 'Error';
        response.successMessage = 'Success';

        final json = response.toJson();

        expect(json['r_id'], 'ref-789');
        expect(json['s'], 1);
        expect(json['em'], 'Error');
        expect(json['sm'], 'Success');
      });

      test('handles null values in serialization', () {
        final response = NewBaseActionResponse(null, null);

        final json = response.toJson();

        expect(json['r_id'], isNull);
        expect(json['s'], isNull);
        expect(json['em'], isNull);
        expect(json['sm'], isNull);
      });

      test('serializes isSuccess as integer', () {
        final response = NewBaseActionResponse(null, null);
        response.isSuccess = 0;

        final json = response.toJson();

        expect(json['s'], 0);
      });
    });

    group('constructor', () {
      test('accepts CashifyAlert and trackUrl', () {
        final response = NewBaseActionResponse(null, 'https://example.com');

        expect(response.trackUrl, 'https://example.com');
      });

      test('handles null constructor parameters', () {
        final response = NewBaseActionResponse(null, null);

        expect(response.cashifyAlert, isNull);
        expect(response.trackUrl, isNull);
      });
    });

    group('isSuccess as int vs bool', () {
      test('isSuccess stores integer values', () {
        final response = NewBaseActionResponse(null, null);
        response.isSuccess = 1;
        expect(response.isSuccess, isA<int>());
        expect(response.isSuccess, 1);

        response.isSuccess = 0;
        expect(response.isSuccess, 0);
      });

      test('can check success with integer comparison', () {
        final response = NewBaseActionResponse(null, null);
        response.isSuccess = 1;
        expect(response.isSuccess == 1, true);

        response.isSuccess = 0;
        expect(response.isSuccess == 0, true);
      });
    });
  });
}
