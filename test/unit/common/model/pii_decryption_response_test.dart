import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/resources/pii_decryption_response.dart';

void main() {
  group('PiiDecryptionResponse', () {
    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = {
          'data': 'decrypted-data-123',
          'piiEnum': 'EMAIL',
          'displayData': 'user@example.com',
          '__ca': null,
          'turl': null,
        };

        final response = PiiDecryptionResponse.fromJson(json);

        expect(response.data, 'decrypted-data-123');
        expect(response.piiEnum, 'EMAIL');
        expect(response.displayData, 'user@example.com');
      });

      test('handles null fields', () {
        final json = <String, dynamic>{
          'data': null,
          'piiEnum': null,
          'displayData': null,
        };

        final response = PiiDecryptionResponse.fromJson(json);

        expect(response.data, isNull);
        expect(response.piiEnum, isNull);
        expect(response.displayData, isNull);
      });

      test('parses with only data field', () {
        final json = {
          'data': 'only-data',
        };

        final response = PiiDecryptionResponse.fromJson(json);

        expect(response.data, 'only-data');
        expect(response.piiEnum, isNull);
        expect(response.displayData, isNull);
      });

      test('parses different piiEnum values', () {
        final jsonEmail = {'piiEnum': 'EMAIL'};
        final jsonPhone = {'piiEnum': 'PHONE'};
        final jsonAddress = {'piiEnum': 'ADDRESS'};

        expect(PiiDecryptionResponse.fromJson(jsonEmail).piiEnum, 'EMAIL');
        expect(PiiDecryptionResponse.fromJson(jsonPhone).piiEnum, 'PHONE');
        expect(PiiDecryptionResponse.fromJson(jsonAddress).piiEnum, 'ADDRESS');
      });

      test('parses CashifyAlert from __ca field', () {
        final json = {
          '__ca': {
            'title': 'Alert',
            'message': 'PII Alert Message',
          },
          'data': 'test-data',
        };

        final response = PiiDecryptionResponse.fromJson(json);

        expect(response.cashifyAlert, isNotNull);
      });

      test('parses trackUrl from turl field', () {
        final json = {
          'turl': 'https://tracking.url',
          'data': 'test',
        };

        final response = PiiDecryptionResponse.fromJson(json);

        expect(response.trackUrl, 'https://tracking.url');
      });
    });

    group('toJson', () {
      test('serializes all fields correctly', () {
        final response = PiiDecryptionResponse(null, null);
        response.data = 'encrypted-data';
        response.piiEnum = 'PHONE';
        response.displayData = '+1 234 567 8900';

        final json = response.toJson();

        expect(json['data'], 'encrypted-data');
        expect(json['piiEnum'], 'PHONE');
        expect(json['displayData'], '+1 234 567 8900');
      });

      test('handles null values in serialization', () {
        final response = PiiDecryptionResponse(null, null);

        final json = response.toJson();

        expect(json['data'], isNull);
        expect(json['piiEnum'], isNull);
        expect(json['displayData'], isNull);
      });

      test('serializes empty string values', () {
        final response = PiiDecryptionResponse(null, null);
        response.data = '';
        response.displayData = '';

        final json = response.toJson();

        expect(json['data'], '');
        expect(json['displayData'], '');
      });
    });

    group('constructor', () {
      test('accepts CashifyAlert and trackUrl', () {
        final response = PiiDecryptionResponse(null, 'https://example.com');

        expect(response.trackUrl, 'https://example.com');
      });

      test('handles null constructor parameters', () {
        final response = PiiDecryptionResponse(null, null);

        expect(response.cashifyAlert, isNull);
        expect(response.trackUrl, isNull);
      });
    });

    group('property assignments', () {
      test('can update data field', () {
        final response = PiiDecryptionResponse(null, null);
        response.data = 'initial';
        expect(response.data, 'initial');

        response.data = 'updated';
        expect(response.data, 'updated');
      });

      test('can update piiEnum field', () {
        final response = PiiDecryptionResponse(null, null);
        response.piiEnum = 'EMAIL';
        expect(response.piiEnum, 'EMAIL');

        response.piiEnum = 'PHONE';
        expect(response.piiEnum, 'PHONE');
      });

      test('can update displayData field', () {
        final response = PiiDecryptionResponse(null, null);
        response.displayData = 'Display 1';
        expect(response.displayData, 'Display 1');

        response.displayData = 'Display 2';
        expect(response.displayData, 'Display 2');
      });
    });
  });
}
