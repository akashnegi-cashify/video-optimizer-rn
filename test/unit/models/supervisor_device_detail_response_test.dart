import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/supervisor/resources/supervisor_device_detail_response.dart';

void main() {
  group('SupervisorDeviceDetailResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'dbr': 'DEV-12345678',
          'mtb': 'John Doe',
          'mta': 1706512000,
          'ctb': 'Jane Smith',
          'cta': 1706598400,
          'pv': [
            {
              'pi': 1,
              'pn': 'Battery',
              'v': {'original': 'Yes', 'replacement': 'No'},
              'svi': 101,
              'svn': 'Original Battery',
              'c': 'Internal Parts',
            },
          ],
          'dm': [
            {
              'n': 'front_image',
              'p': 'https://example.com/front.jpg',
              'iv': false,
            },
          ],
          'dg': 'A',
          'dgd': 'Excellent condition',
          'ds': 'QC_PASSED',
          '__ca': null,
          'turl': 'https://track.example.com',
        };

        // Act
        final response = SupervisorDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.deviceBarcode, 'DEV-12345678');
        expect(response.manualTestedBy, 'John Doe');
        expect(response.manualTestedAt, 1706512000);
        expect(response.cdpTestedBy, 'Jane Smith');
        expect(response.cdpTestedAt, 1706598400);
        expect(response.deviceGrade, 'A');
        expect(response.deviceGradeDesc, 'Excellent condition');
        expect(response.deviceStatus, 'QC_PASSED');
        expect(response.partVariationListResponse, isNotNull);
        expect(response.partVariationListResponse!.length, 1);
        expect(response.deviceMediaListResponse, isNotNull);
        expect(response.deviceMediaListResponse!.length, 1);
        expect(response.trackUrl, 'https://track.example.com');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = SupervisorDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.deviceBarcode, isNull);
        expect(response.manualTestedBy, isNull);
        expect(response.manualTestedAt, isNull);
        expect(response.cdpTestedBy, isNull);
        expect(response.cdpTestedAt, isNull);
        expect(response.partVariationListResponse, isNull);
        expect(response.deviceMediaListResponse, isNull);
        expect(response.deviceGrade, isNull);
        expect(response.deviceGradeDesc, isNull);
        expect(response.deviceStatus, isNull);
      });

      test('should handle partial fields', () {
        // Arrange
        final json = {
          'dbr': 'DEV-PARTIAL',
          'dg': 'B',
          'ds': 'PENDING',
        };

        // Act
        final response = SupervisorDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.deviceBarcode, 'DEV-PARTIAL');
        expect(response.deviceGrade, 'B');
        expect(response.deviceStatus, 'PENDING');
        expect(response.manualTestedBy, isNull);
        expect(response.cdpTestedBy, isNull);
        expect(response.partVariationListResponse, isNull);
      });

      test('should handle empty lists', () {
        // Arrange
        final json = {
          'pv': <Map<String, dynamic>>[],
          'dm': <Map<String, dynamic>>[],
        };

        // Act
        final response = SupervisorDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.partVariationListResponse, isNotNull);
        expect(response.partVariationListResponse!.isEmpty, true);
        expect(response.deviceMediaListResponse, isNotNull);
        expect(response.deviceMediaListResponse!.isEmpty, true);
      });

      test('should parse multiple part variations', () {
        // Arrange
        final json = {
          'pv': [
            {'pi': 1, 'pn': 'Battery'},
            {'pi': 2, 'pn': 'Screen'},
            {'pi': 3, 'pn': 'Camera'},
          ],
        };

        // Act
        final response = SupervisorDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.partVariationListResponse, isNotNull);
        expect(response.partVariationListResponse!.length, 3);
      });

      test('should parse multiple device media items', () {
        // Arrange
        final json = {
          'dm': [
            {'n': 'front', 'p': '/front.jpg', 'iv': false},
            {'n': 'back', 'p': '/back.jpg', 'iv': false},
            {'n': 'video', 'p': '/test.mp4', 'iv': true},
          ],
        };

        // Act
        final response = SupervisorDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.deviceMediaListResponse, isNotNull);
        expect(response.deviceMediaListResponse!.length, 3);
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Alert Title',
            'msg': 'Alert Message',
          },
          'turl': 'https://track.com',
        };

        // Act
        final response = SupervisorDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should handle zero timestamp values', () {
        // Arrange
        final json = {
          'mta': 0,
          'cta': 0,
        };

        // Act
        final response = SupervisorDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.manualTestedAt, 0);
        expect(response.cdpTestedAt, 0);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final partVariation = PartVariationData(
          partId: 1,
          partName: 'Battery',
          value: {'key': 'value'},
          selectedVariationId: 101,
          selectedVariationName: 'Original',
          category: 'Internal',
        );
        final deviceMedia = DeviceMediaData(
          name: 'front_image',
          path: '/front.jpg',
          isVideo: false,
        );
        final response = SupervisorDeviceDetailResponse(
          'DEV-123',
          'Tester A',
          1706512000,
          'Tester B',
          1706598400,
          [partVariation],
          [deviceMedia],
          'ACTIVE',
          null,
          'https://track.com',
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dbr'], 'DEV-123');
        expect(json['mtb'], 'Tester A');
        expect(json['mta'], 1706512000);
        expect(json['ctb'], 'Tester B');
        expect(json['cta'], 1706598400);
        expect(json['ds'], 'ACTIVE');
        expect(json['pv'], isNotNull);
        expect(json['dm'], isNotNull);
        expect(json['turl'], 'https://track.com');
      });

      test('should serialize null fields correctly', () {
        // Arrange
        final response = SupervisorDeviceDetailResponse(
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['dbr'], isNull);
        expect(json['mtb'], isNull);
        expect(json['mta'], isNull);
        expect(json['ctb'], isNull);
        expect(json['cta'], isNull);
        expect(json['pv'], isNull);
        expect(json['dm'], isNull);
        expect(json['ds'], isNull);
      });

      test('should serialize empty lists', () {
        // Arrange
        final response = SupervisorDeviceDetailResponse(
          'DEV-123',
          null,
          null,
          null,
          null,
          [],
          [],
          null,
          null,
          null,
        );

        // Act
        final json = response.toJson();

        // Assert
        expect(json['pv'], isNotNull);
        expect((json['pv'] as List).isEmpty, true);
        expect(json['dm'], isNotNull);
        expect((json['dm'] as List).isEmpty, true);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'dbr': 'DEV-ROUNDTRIP',
          'mtb': 'Manual Tester',
          'mta': 1706512000,
          'ctb': 'CDP Tester',
          'cta': 1706598400,
          'pv': [
            {
              'pi': 1,
              'pn': 'Battery',
              'v': {'k': 'v'},
              'svi': 101,
              'svn': 'Variant',
              'c': 'Category',
            },
          ],
          'dm': [
            {'n': 'image', 'p': '/path.jpg', 'iv': false},
          ],
          'dg': 'A',
          'dgd': 'Grade description',
          'ds': 'ACTIVE',
          'turl': 'https://track.com',
        };

        // Act
        final response = SupervisorDeviceDetailResponse.fromJson(originalJson);
        // Simulate actual JSON roundtrip by encoding to string and decoding back
        final jsonString = jsonEncode(response.toJson());
        final deserializedResponse =
            SupervisorDeviceDetailResponse.fromJson(jsonDecode(jsonString));

        // Assert
        expect(deserializedResponse.deviceBarcode, response.deviceBarcode);
        expect(deserializedResponse.manualTestedBy, response.manualTestedBy);
        expect(deserializedResponse.manualTestedAt, response.manualTestedAt);
        expect(deserializedResponse.cdpTestedBy, response.cdpTestedBy);
        expect(deserializedResponse.cdpTestedAt, response.cdpTestedAt);
        expect(deserializedResponse.deviceGrade, response.deviceGrade);
        expect(deserializedResponse.deviceGradeDesc, response.deviceGradeDesc);
        expect(deserializedResponse.deviceStatus, response.deviceStatus);
      });
    });

    group('edge cases', () {
      test('should handle very large timestamp values', () {
        // Arrange
        final json = {
          'mta': 9999999999,
          'cta': 9999999999,
        };

        // Act
        final response = SupervisorDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.manualTestedAt, 9999999999);
        expect(response.cdpTestedAt, 9999999999);
      });

      test('should handle special characters in strings', () {
        // Arrange
        final json = {
          'dbr': 'DEV-123!@#\$%',
          'mtb': 'Tester "Name"',
          'dgd': 'Grade<br/>Description',
        };

        // Act
        final response = SupervisorDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.deviceBarcode, 'DEV-123!@#\$%');
        expect(response.manualTestedBy, 'Tester "Name"');
        expect(response.deviceGradeDesc, 'Grade<br/>Description');
      });

      test('should handle empty string values', () {
        // Arrange
        final json = {
          'dbr': '',
          'mtb': '',
          'ctb': '',
          'dg': '',
          'dgd': '',
          'ds': '',
        };

        // Act
        final response = SupervisorDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.deviceBarcode, '');
        expect(response.manualTestedBy, '');
        expect(response.cdpTestedBy, '');
        expect(response.deviceGrade, '');
        expect(response.deviceGradeDesc, '');
        expect(response.deviceStatus, '');
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'dbr': '设备条码',
          'mtb': 'टेस्टर',
          'dgd': 'Описание оценки',
        };

        // Act
        final response = SupervisorDeviceDetailResponse.fromJson(json);

        // Assert
        expect(response.deviceBarcode, '设备条码');
        expect(response.manualTestedBy, 'टेस्टर');
        expect(response.deviceGradeDesc, 'Описание оценки');
      });
    });
  });

  group('DeviceMediaData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'n': 'front_image',
          'p': 'https://example.com/images/front.jpg',
          'iv': false,
        };

        // Act
        final data = DeviceMediaData.fromJson(json);

        // Assert
        expect(data.name, 'front_image');
        expect(data.path, 'https://example.com/images/front.jpg');
        expect(data.isVideo, false);
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = DeviceMediaData.fromJson(json);

        // Assert
        expect(data.name, isNull);
        expect(data.path, isNull);
        expect(data.isVideo, isNull);
      });

      test('should handle video media', () {
        // Arrange
        final json = {
          'n': 'test_video',
          'p': 'https://example.com/videos/test.mp4',
          'iv': true,
        };

        // Act
        final data = DeviceMediaData.fromJson(json);

        // Assert
        expect(data.name, 'test_video');
        expect(data.path, 'https://example.com/videos/test.mp4');
        expect(data.isVideo, true);
      });

      test('should handle partial fields', () {
        // Arrange
        final json = {
          'n': 'image_only',
        };

        // Act
        final data = DeviceMediaData.fromJson(json);

        // Assert
        expect(data.name, 'image_only');
        expect(data.path, isNull);
        expect(data.isVideo, isNull);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = DeviceMediaData(
          name: 'front_image',
          path: '/images/front.jpg',
          isVideo: false,
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json['n'], 'front_image');
        expect(json['p'], '/images/front.jpg');
        expect(json['iv'], false);
      });

      test('should serialize null fields correctly', () {
        // Arrange
        final data = DeviceMediaData();

        // Act
        final json = data.toJson();

        // Assert
        expect(json['n'], isNull);
        expect(json['p'], isNull);
        expect(json['iv'], isNull);
      });

      test('should serialize video media', () {
        // Arrange
        final data = DeviceMediaData(
          name: 'test_video',
          path: '/videos/test.mp4',
          isVideo: true,
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json['n'], 'test_video');
        expect(json['p'], '/videos/test.mp4');
        expect(json['iv'], true);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final data = DeviceMediaData(
          name: 'media_name',
          path: '/media/path.jpg',
          isVideo: false,
        );

        // Assert
        expect(data.name, 'media_name');
        expect(data.path, '/media/path.jpg');
        expect(data.isVideo, false);
      });

      test('should create instance with no parameters', () {
        // Act
        final data = DeviceMediaData();

        // Assert
        expect(data.name, isNull);
        expect(data.path, isNull);
        expect(data.isVideo, isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'n': 'roundtrip_media',
          'p': '/roundtrip/path.jpg',
          'iv': false,
        };

        // Act
        final data = DeviceMediaData.fromJson(originalJson);
        final serializedJson = data.toJson();
        final deserializedData = DeviceMediaData.fromJson(serializedJson);

        // Assert
        expect(deserializedData.name, data.name);
        expect(deserializedData.path, data.path);
        expect(deserializedData.isVideo, data.isVideo);
      });
    });

    group('edge cases', () {
      test('should handle long path values', () {
        // Arrange
        final longPath = 'https://cdn.example.com/media/images/' +
            List.generate(50, (i) => 'folder$i').join('/') +
            '/image.jpg';
        final json = {
          'n': 'long_path_image',
          'p': longPath,
          'iv': false,
        };

        // Act
        final data = DeviceMediaData.fromJson(json);

        // Assert
        expect(data.path, longPath);
      });

      test('should handle empty string values', () {
        // Arrange
        final json = {
          'n': '',
          'p': '',
        };

        // Act
        final data = DeviceMediaData.fromJson(json);

        // Assert
        expect(data.name, '');
        expect(data.path, '');
      });

      test('should handle special characters in name', () {
        // Arrange
        final json = {
          'n': 'image_@2x.png',
          'p': '/path/with spaces/image.jpg',
        };

        // Act
        final data = DeviceMediaData.fromJson(json);

        // Assert
        expect(data.name, 'image_@2x.png');
        expect(data.path, '/path/with spaces/image.jpg');
      });
    });
  });

  group('PartVariationData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'pi': 1,
          'pn': 'Battery',
          'v': {'original': 'Yes', 'replacement': 'No'},
          'svi': 101,
          'svn': 'Original Battery',
          'c': 'Internal Parts',
        };

        // Act
        final data = PartVariationData.fromJson(json);

        // Assert
        expect(data.partId, 1);
        expect(data.partName, 'Battery');
        expect(data.value, {'original': 'Yes', 'replacement': 'No'});
        expect(data.selectedVariationId, 101);
        expect(data.selectedVariationName, 'Original Battery');
        expect(data.category, 'Internal Parts');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = PartVariationData.fromJson(json);

        // Assert
        expect(data.partId, isNull);
        expect(data.partName, isNull);
        expect(data.value, isNull);
        expect(data.selectedVariationId, isNull);
        expect(data.selectedVariationName, isNull);
        expect(data.category, isNull);
      });

      test('should handle partial fields', () {
        // Arrange
        final json = {
          'pi': 5,
          'pn': 'Screen',
        };

        // Act
        final data = PartVariationData.fromJson(json);

        // Assert
        expect(data.partId, 5);
        expect(data.partName, 'Screen');
        expect(data.value, isNull);
        expect(data.selectedVariationId, isNull);
      });

      test('should not include imageUrl from json (excluded field)', () {
        // Arrange
        final json = {
          'pi': 1,
          'pn': 'Battery',
          'imageUrl': 'https://example.com/image.jpg',
        };

        // Act
        final data = PartVariationData.fromJson(json);

        // Assert
        expect(data.partId, 1);
        expect(data.partName, 'Battery');
        // imageUrl should be null as it's excluded from JSON
        expect(data.imageUrl, isNull);
      });

      test('should not include userSelectedVariantId from json (excluded field)',
          () {
        // Arrange
        final json = {
          'pi': 1,
          'userSelectedVariantId': '123',
        };

        // Act
        final data = PartVariationData.fromJson(json);

        // Assert
        expect(data.partId, 1);
        // userSelectedVariantId should be null as it's excluded from JSON
        expect(data.userSelectedVariantId, isNull);
      });

      test('should handle empty value map', () {
        // Arrange
        final json = {
          'pi': 1,
          'v': <String, String>{},
        };

        // Act
        final data = PartVariationData.fromJson(json);

        // Assert
        expect(data.value, isNotNull);
        expect(data.value!.isEmpty, true);
      });

      test('should handle value map with multiple entries', () {
        // Arrange
        final json = {
          'v': {
            'option1': 'value1',
            'option2': 'value2',
            'option3': 'value3',
          },
        };

        // Act
        final data = PartVariationData.fromJson(json);

        // Assert
        expect(data.value!.length, 3);
        expect(data.value!['option1'], 'value1');
        expect(data.value!['option2'], 'value2');
        expect(data.value!['option3'], 'value3');
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = PartVariationData(
          partId: 1,
          partName: 'Battery',
          value: {'key': 'value'},
          selectedVariationId: 101,
          selectedVariationName: 'Original',
          category: 'Internal',
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json['pi'], 1);
        expect(json['pn'], 'Battery');
        expect(json['v'], {'key': 'value'});
        expect(json['svi'], 101);
        expect(json['svn'], 'Original');
        expect(json['c'], 'Internal');
      });

      test('should serialize null fields correctly', () {
        // Arrange
        final data = PartVariationData();

        // Act
        final json = data.toJson();

        // Assert
        expect(json['pi'], isNull);
        expect(json['pn'], isNull);
        expect(json['v'], isNull);
        expect(json['svi'], isNull);
        expect(json['svn'], isNull);
        expect(json['c'], isNull);
      });

      test('should not include imageUrl in toJson (excluded field)', () {
        // Arrange
        final data = PartVariationData(
          partId: 1,
          partName: 'Battery',
        );
        data.imageUrl = 'https://example.com/image.jpg';

        // Act
        final json = data.toJson();

        // Assert
        expect(json.containsKey('imageUrl'), false);
      });

      test('should not include userSelectedVariantId in toJson (excluded field)',
          () {
        // Arrange
        final data = PartVariationData(
          partId: 1,
        );
        data.userSelectedVariantId = '123';

        // Act
        final json = data.toJson();

        // Assert
        expect(json.containsKey('userSelectedVariantId'), false);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final data = PartVariationData(
          partId: 1,
          partName: 'Battery',
          value: {'k': 'v'},
          selectedVariationId: 101,
          selectedVariationName: 'Original',
          category: 'Internal',
        );

        // Assert
        expect(data.partId, 1);
        expect(data.partName, 'Battery');
        expect(data.value, {'k': 'v'});
        expect(data.selectedVariationId, 101);
        expect(data.selectedVariationName, 'Original');
        expect(data.category, 'Internal');
      });

      test('should create instance with no parameters', () {
        // Act
        final data = PartVariationData();

        // Assert
        expect(data.partId, isNull);
        expect(data.partName, isNull);
        expect(data.value, isNull);
      });
    });

    group('roundtrip', () {
      test('should maintain data through fromJson/toJson cycle', () {
        // Arrange
        final originalJson = {
          'pi': 1,
          'pn': 'Battery',
          'v': {'original': 'Yes'},
          'svi': 101,
          'svn': 'Original',
          'c': 'Internal',
        };

        // Act
        final data = PartVariationData.fromJson(originalJson);
        final serializedJson = data.toJson();
        final deserializedData = PartVariationData.fromJson(serializedJson);

        // Assert
        expect(deserializedData.partId, data.partId);
        expect(deserializedData.partName, data.partName);
        expect(deserializedData.value, data.value);
        expect(deserializedData.selectedVariationId, data.selectedVariationId);
        expect(
            deserializedData.selectedVariationName, data.selectedVariationName);
        expect(deserializedData.category, data.category);
      });
    });

    group('edge cases', () {
      test('should handle large partId values', () {
        // Arrange
        final json = {
          'pi': 999999999,
          'svi': 888888888,
        };

        // Act
        final data = PartVariationData.fromJson(json);

        // Assert
        expect(data.partId, 999999999);
        expect(data.selectedVariationId, 888888888);
      });

      test('should handle empty string values', () {
        // Arrange
        final json = {
          'pn': '',
          'svn': '',
          'c': '',
        };

        // Act
        final data = PartVariationData.fromJson(json);

        // Assert
        expect(data.partName, '');
        expect(data.selectedVariationName, '');
        expect(data.category, '');
      });

      test('should handle special characters in strings', () {
        // Arrange
        final json = {
          'pn': 'Battery (Original)',
          'svn': 'Variant "A" - Premium',
          'c': 'Category<br/>with HTML',
        };

        // Act
        final data = PartVariationData.fromJson(json);

        // Assert
        expect(data.partName, 'Battery (Original)');
        expect(data.selectedVariationName, 'Variant "A" - Premium');
        expect(data.category, 'Category<br/>with HTML');
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          'pn': '电池',
          'svn': 'वैरिएंट',
          'c': 'Категория',
        };

        // Act
        final data = PartVariationData.fromJson(json);

        // Assert
        expect(data.partName, '电池');
        expect(data.selectedVariationName, 'वैरिएंट');
        expect(data.category, 'Категория');
      });

      test('should handle value map with special characters', () {
        // Arrange
        final json = {
          'v': {
            'key with spaces': 'value with spaces',
            'key-with-dashes': 'value-with-dashes',
            'key_with_underscores': 'value_with_underscores',
          },
        };

        // Act
        final data = PartVariationData.fromJson(json);

        // Assert
        expect(data.value!['key with spaces'], 'value with spaces');
        expect(data.value!['key-with-dashes'], 'value-with-dashes');
        expect(data.value!['key_with_underscores'], 'value_with_underscores');
      });
    });

    group('excluded fields behavior', () {
      test('should allow setting imageUrl directly on instance', () {
        // Arrange
        final data = PartVariationData(partId: 1);

        // Act
        data.imageUrl = 'https://example.com/image.jpg';

        // Assert
        expect(data.imageUrl, 'https://example.com/image.jpg');
      });

      test('should allow setting userSelectedVariantId directly on instance',
          () {
        // Arrange
        final data = PartVariationData(partId: 1);

        // Act
        data.userSelectedVariantId = 'selected-123';

        // Assert
        expect(data.userSelectedVariantId, 'selected-123');
      });
    });
  });
}
