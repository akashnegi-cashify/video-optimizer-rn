import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/engineer/models/reason_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/models/category_code_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/models/retrieved_part_list_response.dart';

/// Tests for additional Engineer module models.
/// Focus: Testing fromJson/toJson serialization and model properties.
void main() {
  group('ReasonListResponse', () {
    group('fromJson', () {
      test('should parse complete response correctly', () {
        final json = {
          'dt': {
            'category1': [
              {
                'rrid': 1,
                'reason': 'Reason 1',
                'imr': true,
              },
              {
                'rrid': 2,
                'reason': 'Reason 2',
                'imr': false,
              },
            ],
            'category2': [
              {
                'rrid': 3,
                'reason': 'Reason 3',
                'imr': true,
              },
            ],
          },
        };

        final result = ReasonListResponse.fromJson(json);

        expect(result.reasonsMap, isNotNull);
        expect(result.reasonsMap?.keys.length, 2);
        expect(result.reasonsMap?['category1']?.length, 2);
        expect(result.reasonsMap?['category2']?.length, 1);
      });

      test('should handle empty reasons map', () {
        final json = {
          'dt': <String, List<Map<String, dynamic>>>{},
        };

        final result = ReasonListResponse.fromJson(json);

        expect(result.reasonsMap, isEmpty);
      });

      test('should handle null reasons map', () {
        final json = {
          'dt': null,
        };

        final result = ReasonListResponse.fromJson(json);

        expect(result.reasonsMap, isNull);
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = ReasonListResponse.fromJson({
          'dt': {
            'test': [
              {'rrid': 1, 'reason': 'Test', 'imr': true},
            ],
          },
        });

        final json = response.toJson();

        expect(json['dt'], isA<Map>());
      });
    });
  });

  group('ReasonListData', () {
    group('fromJson', () {
      test('should parse complete reason data correctly', () {
        final json = {
          'rrid': 123,
          'reason': 'Screen crack',
          'imr': true,
        };

        final result = ReasonListData.fromJson(json);

        expect(result.reasonId, 123);
        expect(result.reason, 'Screen crack');
        expect(result.isImageRequired, true);
      });

      test('should handle null fields', () {
        final json = <String, dynamic>{};

        final result = ReasonListData.fromJson(json);

        expect(result.reasonId, isNull);
        expect(result.reason, isNull);
        expect(result.isImageRequired, isNull);
      });

      test('should parse reason without image requirement', () {
        final json = {
          'rrid': 456,
          'reason': 'Battery issue',
          'imr': false,
        };

        final result = ReasonListData.fromJson(json);

        expect(result.reasonId, 456);
        expect(result.isImageRequired, false);
      });
    });

    group('toJson', () {
      test('should serialize reason data to JSON correctly', () {
        final reason = ReasonListData.fromJson({
          'rrid': 789,
          'reason': 'Camera malfunction',
          'imr': true,
        });

        final json = reason.toJson();

        expect(json['rrid'], 789);
        expect(json['reason'], 'Camera malfunction');
        expect(json['imr'], true);
      });
    });
  });

  group('CategoryCodeListResponse', () {
    group('fromJson', () {
      test('should parse complete response correctly', () {
        final json = {
          'dt': ['CAT001', 'CAT002', 'CAT003'],
        };

        final result = CategoryCodeListResponse.fromJson(json);

        expect(result.categoryCodeList, isNotNull);
        expect(result.categoryCodeList?.length, 3);
        expect(result.categoryCodeList, contains('CAT001'));
        expect(result.categoryCodeList, contains('CAT002'));
        expect(result.categoryCodeList, contains('CAT003'));
      });

      test('should handle empty list', () {
        final json = {
          'dt': <String>[],
        };

        final result = CategoryCodeListResponse.fromJson(json);

        expect(result.categoryCodeList, isEmpty);
      });

      test('should handle null list', () {
        final json = {
          'dt': null,
        };

        final result = CategoryCodeListResponse.fromJson(json);

        expect(result.categoryCodeList, isNull);
      });

      test('should handle single category', () {
        final json = {
          'dt': ['SINGLE_CAT'],
        };

        final result = CategoryCodeListResponse.fromJson(json);

        expect(result.categoryCodeList?.length, 1);
        expect(result.categoryCodeList?.first, 'SINGLE_CAT');
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = CategoryCodeListResponse.fromJson({
          'dt': ['CAT_A', 'CAT_B'],
        });

        final json = response.toJson();

        expect(json['dt'], isA<List>());
        expect((json['dt'] as List).length, 2);
      });
    });
  });

  group('RetrievedPartListResponse', () {
    group('fromJson', () {
      test('should parse complete response correctly', () {
        final json = {
          'dt': {
            'dl': [
              {
                'partId': 1,
                'sku': 'SKU001',
                'partName': 'Screen',
                'deviceBarcode': 'DEV001',
                'retrievedPartBarcode': 'RET001',
                'reason': 'Damaged',
                'remark': 'Needs replacement',
                'images': ['url1', 'url2'],
              },
            ],
          },
        };

        final result = RetrievedPartListResponse.fromJson(json);

        expect(result.retrievedPartListResponse, isNotNull);
        expect(result.retrievedPartListResponse?.retrievedPartList?.length, 1);
      });

      test('should handle empty part list', () {
        final json = {
          'dt': {
            'dl': <Map<String, dynamic>>[],
          },
        };

        final result = RetrievedPartListResponse.fromJson(json);

        expect(result.retrievedPartListResponse?.retrievedPartList, isEmpty);
      });

      test('should handle null data', () {
        final json = {
          'dt': null,
        };

        final result = RetrievedPartListResponse.fromJson(json);

        expect(result.retrievedPartListResponse, isNull);
      });
    });

    group('toJson', () {
      test('should serialize response to JSON correctly', () {
        final response = RetrievedPartListResponse.fromJson({
          'dt': {
            'dl': [],
          },
        });

        final json = response.toJson();

        expect(json['dt'], isNotNull);
      });
    });
  });

  group('RetrievedPartList', () {
    group('fromJson', () {
      test('should parse complete list correctly', () {
        final json = {
          'dl': [
            {
              'partId': 123,
              'sku': 'SKU123',
              'partName': 'Battery',
            },
            {
              'partId': 456,
              'sku': 'SKU456',
              'partName': 'Camera',
            },
          ],
        };

        final result = RetrievedPartList.fromJson(json);

        expect(result.retrievedPartList?.length, 2);
        expect(result.retrievedPartList?[0].partId, 123);
        expect(result.retrievedPartList?[1].partId, 456);
      });

      test('should handle null list', () {
        final json = {
          'dl': null,
        };

        final result = RetrievedPartList.fromJson(json);

        expect(result.retrievedPartList, isNull);
      });
    });

    group('toJson', () {
      test('should serialize list to JSON correctly', () {
        final list = RetrievedPartList.fromJson({
          'dl': [
            {'partId': 1, 'sku': 'TEST'},
          ],
        });

        final json = list.toJson();

        expect(json['dl'], isA<List>());
      });
    });
  });

  group('RetrievedPartListData', () {
    group('fromJson', () {
      test('should parse complete part data correctly', () {
        final json = {
          'partId': 789,
          'sku': 'SKU-TEST-789',
          'partName': 'LCD Screen',
          'partVariationName': 'Original OEM',
          'deviceBarcode': 'DEV789',
          'retrievedPartBarcode': 'RET789',
          'reason': 'Quality Issue',
          'remark': 'Minor scratch',
          'images': ['img1.jpg', 'img2.jpg'],
        };

        final result = RetrievedPartListData.fromJson(json);

        expect(result.partId, 789);
        expect(result.sku, 'SKU-TEST-789');
        expect(result.partName, 'LCD Screen');
        expect(result.partVariationName, 'Original OEM');
        expect(result.deviceBarcode, 'DEV789');
        expect(result.retrievedPartBarcode, 'RET789');
        expect(result.reason, 'Quality Issue');
        expect(result.remark, 'Minor scratch');
        expect(result.imageUrls?.length, 2);
      });

      test('should handle null fields', () {
        final json = <String, dynamic>{};

        final result = RetrievedPartListData.fromJson(json);

        expect(result.partId, isNull);
        expect(result.sku, isNull);
        expect(result.partName, isNull);
        expect(result.imageUrls, isNull);
      });

      test('should handle empty images list', () {
        final json = {
          'partId': 100,
          'images': <String>[],
        };

        final result = RetrievedPartListData.fromJson(json);

        expect(result.partId, 100);
        expect(result.imageUrls, isEmpty);
      });
    });

    group('toJson', () {
      test('should serialize part data to JSON correctly', () {
        final part = RetrievedPartListData.fromJson({
          'partId': 500,
          'sku': 'SKU500',
          'partName': 'Charger',
          'reason': 'Defective',
          'images': ['url'],
        });

        final json = part.toJson();

        expect(json['partId'], 500);
        expect(json['sku'], 'SKU500');
        expect(json['partName'], 'Charger');
        expect(json['reason'], 'Defective');
        expect(json['images'], ['url']);
      });
    });
  });
}
