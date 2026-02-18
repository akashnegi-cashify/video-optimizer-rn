import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/model/base_action_response.dart';

void main() {
  group('BaseActionResponse', () {
    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = {
          'r_id': 'ref-123',
          's': true,
          'em': 'Error message',
          'sm': 'Success message',
          '__ca': null,
          'turl': 'https://track.url',
        };

        final response = BaseActionResponse.fromJson(json);

        expect(response.refId, 'ref-123');
        expect(response.isSuccess, true);
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

        final response = BaseActionResponse.fromJson(json);

        expect(response.refId, isNull);
        expect(response.isSuccess, false); // defaultValue: false
        expect(response.errorMsg, isNull);
        expect(response.successMessage, isNull);
      });

      test('uses default value for isSuccess when missing', () {
        final json = <String, dynamic>{};

        final response = BaseActionResponse.fromJson(json);

        expect(response.isSuccess, false);
      });

      test('parses boolean isSuccess correctly', () {
        final jsonTrue = {'s': true};
        final jsonFalse = {'s': false};

        final responseTrue = BaseActionResponse.fromJson(jsonTrue);
        final responseFalse = BaseActionResponse.fromJson(jsonFalse);

        expect(responseTrue.isSuccess, true);
        expect(responseFalse.isSuccess, false);
      });
    });

    group('fromJsonWithInt', () {
      test('parses isSuccess from integer 1 as true', () {
        final json = {
          'r_id': 'ref-456',
          's': 1,
          'em': null,
          'sm': 'Success!',
        };

        final response = BaseActionResponse.fromJsonWithInt(json);

        expect(response.refId, 'ref-456');
        expect(response.isSuccess, true);
        expect(response.successMessage, 'Success!');
      });

      test('parses isSuccess from integer 0 as false', () {
        final json = {
          's': 0,
        };

        final response = BaseActionResponse.fromJsonWithInt(json);

        expect(response.isSuccess, false);
      });

      test('parses isSuccess from null as false', () {
        final json = <String, dynamic>{
          's': null,
        };

        final response = BaseActionResponse.fromJsonWithInt(json);

        expect(response.isSuccess, false);
      });

      test('parses isSuccess from other integers as false', () {
        final json2 = {'s': 2};
        final jsonNeg = {'s': -1};
        final json100 = {'s': 100};

        expect(BaseActionResponse.fromJsonWithInt(json2).isSuccess, false);
        expect(BaseActionResponse.fromJsonWithInt(jsonNeg).isSuccess, false);
        expect(BaseActionResponse.fromJsonWithInt(json100).isSuccess, false);
      });

      test('parses CashifyAlert from __ca field', () {
        final json = {
          '__ca': {
            'title': 'Alert Title',
            'message': 'Alert Message',
          },
          's': 1,
        };

        final response = BaseActionResponse.fromJsonWithInt(json);

        expect(response.cashifyAlert, isNotNull);
      });

      test('parses trackUrl from turl field', () {
        final json = {
          'turl': 'https://tracking.url/path',
          's': 1,
        };

        final response = BaseActionResponse.fromJsonWithInt(json);

        expect(response.trackUrl, 'https://tracking.url/path');
      });
    });

    group('toJson', () {
      test('serializes all fields correctly', () {
        final response = BaseActionResponse(null, 'https://track.url');
        response.refId = 'ref-789';
        response.isSuccess = true;
        response.errorMsg = 'Error';
        response.successMessage = 'Success';

        final json = response.toJson();

        expect(json['r_id'], 'ref-789');
        expect(json['s'], true);
        expect(json['em'], 'Error');
        expect(json['sm'], 'Success');
      });

      test('handles null values in serialization', () {
        final response = BaseActionResponse(null, null);
        response.isSuccess = false;

        final json = response.toJson();

        expect(json['r_id'], isNull);
        expect(json['s'], false);
        expect(json['em'], isNull);
        expect(json['sm'], isNull);
      });
    });

    group('constructor', () {
      test('accepts CashifyAlert and trackUrl', () {
        final response = BaseActionResponse(null, 'https://example.com');

        expect(response.trackUrl, 'https://example.com');
      });

      test('handles null constructor parameters', () {
        final response = BaseActionResponse(null, null);

        expect(response.cashifyAlert, isNull);
        expect(response.trackUrl, isNull);
      });
    });
  });
}
