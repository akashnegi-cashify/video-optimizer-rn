import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/version_updates/app_version_response.dart';

void main() {
  group('AppVersionResponse', () {
    group('constructor', () {
      test('creates instance with versionList', () {
        final versionData = AppVersionData('1.0.0', false);
        final response = AppVersionResponse([versionData]);
        
        expect(response.versionList, isNotNull);
        expect(response.versionList?.length, 1);
      });

      test('creates instance with null versionList', () {
        final response = AppVersionResponse(null);
        
        expect(response.versionList, isNull);
      });

      test('creates instance with empty versionList', () {
        final response = AppVersionResponse([]);
        
        expect(response.versionList, isEmpty);
      });
    });

    group('fromJson', () {
      test('parses versionList correctly', () {
        final json = {
          'dt': [
            {'version': '1.0.0', 'isMajor': false, 'apkUrl': 'https://example.com/v1.apk'},
            {'version': '2.0.0', 'isMajor': true, 'apkUrl': 'https://example.com/v2.apk'},
          ],
        };

        final response = AppVersionResponse.fromJson(json);

        expect(response.versionList, isNotNull);
        expect(response.versionList?.length, 2);
        expect(response.versionList?[0].versionName, '1.0.0');
        expect(response.versionList?[1].versionName, '2.0.0');
      });

      test('handles null dt field', () {
        final json = <String, dynamic>{'dt': null};

        final response = AppVersionResponse.fromJson(json);

        expect(response.versionList, isNull);
      });

      test('handles missing dt field', () {
        final json = <String, dynamic>{};

        final response = AppVersionResponse.fromJson(json);

        expect(response.versionList, isNull);
      });

      test('parses empty versionList', () {
        final json = {'dt': <Map<String, dynamic>>[]};

        final response = AppVersionResponse.fromJson(json);

        expect(response.versionList, isEmpty);
      });
    });

    group('toJson', () {
      test('serializes versionList correctly', () {
        final versionData = AppVersionData('1.0.0', true);
        versionData.apkUrl = 'https://example.com/app.apk';
        final response = AppVersionResponse([versionData]);

        final json = response.toJson();

        expect(json['dt'], isA<List>());
        expect((json['dt'] as List).length, 1);
      });

      test('serializes null versionList', () {
        final response = AppVersionResponse(null);

        final json = response.toJson();

        expect(json['dt'], isNull);
      });
    });
  });

  group('AppVersionData', () {
    group('constructor', () {
      test('creates instance with versionName and isMajorUpdate', () {
        final data = AppVersionData('2.0.0', true);
        
        expect(data.versionName, '2.0.0');
        expect(data.isMajorUpdate, true);
      });

      test('creates instance with null values', () {
        final data = AppVersionData(null, null);
        
        expect(data.versionName, isNull);
        expect(data.isMajorUpdate, isNull);
      });
    });

    group('fromJson', () {
      test('parses all fields correctly', () {
        final json = {
          'version': '3.1.0',
          'isMajor': true,
          'apkUrl': 'https://download.example.com/app-3.1.0.apk',
        };

        final data = AppVersionData.fromJson(json);

        expect(data.versionName, '3.1.0');
        expect(data.isMajorUpdate, true);
        expect(data.apkUrl, 'https://download.example.com/app-3.1.0.apk');
      });

      test('handles null fields', () {
        final json = <String, dynamic>{
          'version': null,
          'isMajor': null,
          'apkUrl': null,
        };

        final data = AppVersionData.fromJson(json);

        expect(data.versionName, isNull);
        expect(data.isMajorUpdate, isNull);
        expect(data.apkUrl, isNull);
      });

      test('handles missing fields', () {
        final json = <String, dynamic>{};

        final data = AppVersionData.fromJson(json);

        expect(data.versionName, isNull);
        expect(data.isMajorUpdate, isNull);
        expect(data.apkUrl, isNull);
      });

      test('parses isMajor as false', () {
        final json = {
          'version': '1.0.1',
          'isMajor': false,
        };

        final data = AppVersionData.fromJson(json);

        expect(data.isMajorUpdate, false);
      });
    });

    group('toJson', () {
      test('serializes all fields correctly', () {
        final data = AppVersionData('4.0.0', true);
        data.apkUrl = 'https://example.com/v4.apk';

        final json = data.toJson();

        expect(json['version'], '4.0.0');
        expect(json['isMajor'], true);
        expect(json['apkUrl'], 'https://example.com/v4.apk');
      });

      test('serializes null values', () {
        final data = AppVersionData(null, null);

        final json = data.toJson();

        expect(json['version'], isNull);
        expect(json['isMajor'], isNull);
        expect(json['apkUrl'], isNull);
      });
    });

    group('property assignments', () {
      test('can update apkUrl', () {
        final data = AppVersionData('1.0.0', false);
        data.apkUrl = 'https://new-url.com/app.apk';

        expect(data.apkUrl, 'https://new-url.com/app.apk');
      });

      test('can update versionName', () {
        final data = AppVersionData('1.0.0', false);
        data.versionName = '1.0.1';

        expect(data.versionName, '1.0.1');
      });

      test('can update isMajorUpdate', () {
        final data = AppVersionData('1.0.0', false);
        data.isMajorUpdate = true;

        expect(data.isMajorUpdate, true);
      });
    });
  });
}
