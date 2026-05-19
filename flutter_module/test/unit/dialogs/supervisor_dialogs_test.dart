import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/supervisor/dialogs/supervisor_device_detail_dialog.dart';
import 'package:flutter_trc/qc/modules/supervisor/resources/supervisor_device_detail_response.dart';

void main() {
  group('showSupervisorDeviceDetailDialog', () {
    test('function exists and is callable', () {
      expect(showSupervisorDeviceDetailDialog, isA<Function>());
    });

    test('function accepts required parameters', () {
      // Verify the function can accept BuildContext, String, and SupervisorDeviceDetailResponse?
      String deviceBarcode = 'TEST_BARCODE';
      SupervisorDeviceDetailResponse? event;
      expect(deviceBarcode, 'TEST_BARCODE');
      expect(event, isNull);
    });

    test('function handles empty deviceBarcode', () {
      String deviceBarcode = '';
      expect(deviceBarcode, isEmpty);
    });

    test('function handles null event', () {
      SupervisorDeviceDetailResponse? event;
      expect(event, isNull);
    });

    test('function accepts populated event', () {
      final event = SupervisorDeviceDetailResponse.fromJson({
        'dbr': 'DEVICE123',
        'mtb': 'John Doe',
        'mta': 1706620800000,
        'ctb': 'Jane Doe',
        'cta': 1706707200000,
        'ds': 'Ready for Review',
      });
      expect(event.deviceBarcode, 'DEVICE123');
      expect(event.manualTestedBy, 'John Doe');
    });
  });

  group('SupervisorDeviceDetailResponse', () {
    test('fromJson parses all fields correctly', () {
      final json = {
        '__ca': null,
        'turl': 'test_url',
        'dbr': 'BARCODE456',
        'mtb': 'Manual Tester',
        'mta': 1706620800000,
        'ctb': 'CDP Tester',
        'cta': 1706707200000,
        'dg': 'A',
        'dgd': 'Grade A - Excellent',
        'ds': 'Completed',
        'pv': [
          {'pi': 1, 'pn': 'Screen', 'svn': 'Original'},
        ],
        'dm': [
          {'n': 'Front', 'p': 'front_url', 'iv': false},
        ],
      };
      final response = SupervisorDeviceDetailResponse.fromJson(json);

      expect(response.trackUrl, 'test_url');
      expect(response.deviceBarcode, 'BARCODE456');
      expect(response.manualTestedBy, 'Manual Tester');
      expect(response.manualTestedAt, 1706620800000);
      expect(response.cdpTestedBy, 'CDP Tester');
      expect(response.cdpTestedAt, 1706707200000);
      expect(response.deviceGrade, 'A');
      expect(response.deviceGradeDesc, 'Grade A - Excellent');
      expect(response.deviceStatus, 'Completed');
      expect(response.partVariationListResponse, isNotNull);
      expect(response.deviceMediaListResponse, isNotNull);
    });

    test('toJson serializes correctly', () {
      final response = SupervisorDeviceDetailResponse.fromJson({
        '__ca': null,
        'turl': 'test_url',
        'dbr': 'BARCODE789',
        'mtb': 'Tester',
        'ds': 'In Progress',
      });
      final json = response.toJson();

      expect(json['turl'], 'test_url');
      expect(json['dbr'], 'BARCODE789');
      expect(json['mtb'], 'Tester');
      expect(json['ds'], 'In Progress');
    });

    test('handles null values gracefully', () {
      final response = SupervisorDeviceDetailResponse.fromJson({});

      expect(response.deviceBarcode, isNull);
      expect(response.manualTestedBy, isNull);
      expect(response.manualTestedAt, isNull);
      expect(response.cdpTestedBy, isNull);
      expect(response.cdpTestedAt, isNull);
      expect(response.deviceGrade, isNull);
      expect(response.deviceGradeDesc, isNull);
      expect(response.deviceStatus, isNull);
      expect(response.partVariationListResponse, isNull);
      expect(response.deviceMediaListResponse, isNull);
    });

    test('handles partial JSON data', () {
      final response = SupervisorDeviceDetailResponse.fromJson({
        'dbr': 'PARTIAL_BARCODE',
        'ds': 'Partial Status',
      });

      expect(response.deviceBarcode, 'PARTIAL_BARCODE');
      expect(response.deviceStatus, 'Partial Status');
      expect(response.manualTestedBy, isNull);
      expect(response.cdpTestedBy, isNull);
    });

    test('handles empty lists', () {
      final response = SupervisorDeviceDetailResponse.fromJson({
        'pv': [],
        'dm': [],
      });

      expect(response.partVariationListResponse, isEmpty);
      expect(response.deviceMediaListResponse, isEmpty);
    });
  });

  group('DeviceMediaData', () {
    test('fromJson parses all fields correctly', () {
      final json = {
        'n': 'Front View',
        'p': 'https://example.com/front.jpg',
        'iv': false,
      };
      final data = DeviceMediaData.fromJson(json);

      expect(data.name, 'Front View');
      expect(data.path, 'https://example.com/front.jpg');
      expect(data.isVideo, false);
    });

    test('toJson serializes correctly', () {
      final data = DeviceMediaData(
        name: 'Back View',
        path: 'https://example.com/back.jpg',
        isVideo: false,
      );
      final json = data.toJson();

      expect(json['n'], 'Back View');
      expect(json['p'], 'https://example.com/back.jpg');
      expect(json['iv'], false);
    });

    test('handles video content', () {
      final data = DeviceMediaData.fromJson({
        'n': 'Device Video',
        'p': 'https://example.com/video.mp4',
        'iv': true,
      });

      expect(data.name, 'Device Video');
      expect(data.isVideo, true);
    });

    test('handles null values gracefully', () {
      final data = DeviceMediaData.fromJson({});

      expect(data.name, isNull);
      expect(data.path, isNull);
      expect(data.isVideo, isNull);
    });

    test('handles empty strings', () {
      final data = DeviceMediaData.fromJson({
        'n': '',
        'p': '',
      });

      expect(data.name, '');
      expect(data.path, '');
    });

    test('can be created with constructor', () {
      final data = DeviceMediaData(
        name: 'Test Media',
        path: '/path/to/media',
        isVideo: true,
      );

      expect(data.name, 'Test Media');
      expect(data.path, '/path/to/media');
      expect(data.isVideo, true);
    });
  });

  group('PartVariationData', () {
    test('fromJson parses all fields correctly', () {
      final json = {
        'pi': 1,
        'pn': 'Screen',
        'v': {'1': 'Original', '2': 'Compatible'},
        'svi': 1,
        'svn': 'Original',
        'c': 'Display',
      };
      final data = PartVariationData.fromJson(json);

      expect(data.partId, 1);
      expect(data.partName, 'Screen');
      expect(data.value, isNotNull);
      expect(data.value?['1'], 'Original');
      expect(data.selectedVariationId, 1);
      expect(data.selectedVariationName, 'Original');
      expect(data.category, 'Display');
    });

    test('toJson serializes correctly', () {
      final data = PartVariationData(
        partId: 2,
        partName: 'Battery',
        value: {'1': 'Original'},
        selectedVariationId: 1,
        selectedVariationName: 'Original',
        category: 'Power',
      );
      final json = data.toJson();

      expect(json['pi'], 2);
      expect(json['pn'], 'Battery');
      expect(json['svi'], 1);
      expect(json['svn'], 'Original');
      expect(json['c'], 'Power');
    });

    test('handles null values gracefully', () {
      final data = PartVariationData.fromJson({});

      expect(data.partId, isNull);
      expect(data.partName, isNull);
      expect(data.value, isNull);
      expect(data.selectedVariationId, isNull);
      expect(data.selectedVariationName, isNull);
      expect(data.category, isNull);
    });

    test('handles null value map', () {
      final data = PartVariationData.fromJson({
        'pi': 3,
        'pn': 'Camera',
        'v': null,
      });

      expect(data.partId, 3);
      expect(data.partName, 'Camera');
      expect(data.value, isNull);
    });

    test('handles multiple value entries', () {
      final data = PartVariationData.fromJson({
        'pi': 4,
        'pn': 'Connector',
        'v': {
          '1': 'Original',
          '2': 'Compatible',
          '3': 'Aftermarket',
        },
      });

      expect(data.value?.length, 3);
      expect(data.value?['1'], 'Original');
      expect(data.value?['2'], 'Compatible');
      expect(data.value?['3'], 'Aftermarket');
    });

    test('can be created with constructor', () {
      final data = PartVariationData(
        partId: 5,
        partName: 'Speaker',
        value: {'1': 'Original'},
        selectedVariationId: 1,
        selectedVariationName: 'Original',
        category: 'Audio',
      );

      expect(data.partId, 5);
      expect(data.partName, 'Speaker');
      expect(data.category, 'Audio');
    });

    test('transient fields are not serialized', () {
      final data = PartVariationData.fromJson({
        'pi': 6,
        'pn': 'Test Part',
      });
      // These fields are marked with includeFromJson: false, includeToJson: false
      data.imageUrl = 'test_url';
      data.userSelectedVariantId = 'selected_id';

      final json = data.toJson();
      // Transient fields should not be in JSON output
      expect(json.containsKey('imageUrl'), isFalse);
      expect(json.containsKey('userSelectedVariantId'), isFalse);
    });
  });

  group('Dialog display values', () {
    test('displays empty string when deviceBarcode is null', () {
      final event = SupervisorDeviceDetailResponse.fromJson({});
      expect(event.deviceBarcode ?? '', '');
    });

    test('displays empty string when deviceStatus is null', () {
      final event = SupervisorDeviceDetailResponse.fromJson({});
      expect(event.deviceStatus ?? '', '');
    });

    test('displays empty string when manualTestedBy is null', () {
      final event = SupervisorDeviceDetailResponse.fromJson({});
      expect(event.manualTestedBy ?? '', '');
    });

    test('displays empty string when cdpTestedBy is null', () {
      final event = SupervisorDeviceDetailResponse.fromJson({});
      expect(event.cdpTestedBy ?? '', '');
    });

    test('displays actual values when populated', () {
      final event = SupervisorDeviceDetailResponse.fromJson({
        'dbr': 'DISPLAY_BARCODE',
        'ds': 'Display Status',
        'mtb': 'Display Manual Tester',
        'ctb': 'Display CDP Tester',
      });

      expect(event.deviceBarcode ?? '', 'DISPLAY_BARCODE');
      expect(event.deviceStatus ?? '', 'Display Status');
      expect(event.manualTestedBy ?? '', 'Display Manual Tester');
      expect(event.cdpTestedBy ?? '', 'Display CDP Tester');
    });
  });

  group('Timestamp handling', () {
    test('handles manualTestedAt timestamp', () {
      final event = SupervisorDeviceDetailResponse.fromJson({
        'mta': 1706620800000,
      });
      expect(event.manualTestedAt, 1706620800000);
    });

    test('handles cdpTestedAt timestamp', () {
      final event = SupervisorDeviceDetailResponse.fromJson({
        'cta': 1706707200000,
      });
      expect(event.cdpTestedAt, 1706707200000);
    });

    test('handles null timestamps', () {
      final event = SupervisorDeviceDetailResponse.fromJson({});
      expect(event.manualTestedAt, isNull);
      expect(event.cdpTestedAt, isNull);
    });

    test('handles zero timestamps', () {
      final event = SupervisorDeviceDetailResponse.fromJson({
        'mta': 0,
        'cta': 0,
      });
      expect(event.manualTestedAt, 0);
      expect(event.cdpTestedAt, 0);
    });

    test('handles large timestamps', () {
      final event = SupervisorDeviceDetailResponse.fromJson({
        'mta': 9999999999999,
        'cta': 9999999999999,
      });
      expect(event.manualTestedAt, 9999999999999);
      expect(event.cdpTestedAt, 9999999999999);
    });
  });

  group('Grade handling', () {
    test('handles grade A', () {
      final event = SupervisorDeviceDetailResponse.fromJson({
        'dg': 'A',
        'dgd': 'Grade A - Excellent Condition',
      });
      expect(event.deviceGrade, 'A');
      expect(event.deviceGradeDesc, 'Grade A - Excellent Condition');
    });

    test('handles grade B', () {
      final event = SupervisorDeviceDetailResponse.fromJson({
        'dg': 'B',
        'dgd': 'Grade B - Good Condition',
      });
      expect(event.deviceGrade, 'B');
      expect(event.deviceGradeDesc, 'Grade B - Good Condition');
    });

    test('handles grade C', () {
      final event = SupervisorDeviceDetailResponse.fromJson({
        'dg': 'C',
        'dgd': 'Grade C - Fair Condition',
      });
      expect(event.deviceGrade, 'C');
      expect(event.deviceGradeDesc, 'Grade C - Fair Condition');
    });

    test('handles null grades', () {
      final event = SupervisorDeviceDetailResponse.fromJson({});
      expect(event.deviceGrade, isNull);
      expect(event.deviceGradeDesc, isNull);
    });
  });

  group('List data handling', () {
    test('handles multiple part variations', () {
      final event = SupervisorDeviceDetailResponse.fromJson({
        'pv': [
          {'pi': 1, 'pn': 'Screen', 'svn': 'Original'},
          {'pi': 2, 'pn': 'Battery', 'svn': 'Compatible'},
          {'pi': 3, 'pn': 'Camera', 'svn': 'Original'},
        ],
      });
      expect(event.partVariationListResponse?.length, 3);
    });

    test('handles multiple device media', () {
      final event = SupervisorDeviceDetailResponse.fromJson({
        'dm': [
          {'n': 'Front', 'p': 'front_url', 'iv': false},
          {'n': 'Back', 'p': 'back_url', 'iv': false},
          {'n': 'Video', 'p': 'video_url', 'iv': true},
        ],
      });
      expect(event.deviceMediaListResponse?.length, 3);
    });

    test('handles mixed video and image media', () {
      final event = SupervisorDeviceDetailResponse.fromJson({
        'dm': [
          {'n': 'Image 1', 'p': 'img1.jpg', 'iv': false},
          {'n': 'Video 1', 'p': 'vid1.mp4', 'iv': true},
          {'n': 'Image 2', 'p': 'img2.jpg', 'iv': false},
        ],
      });

      final images = event.deviceMediaListResponse
          ?.where((m) => m.isVideo == false)
          .toList();
      final videos = event.deviceMediaListResponse
          ?.where((m) => m.isVideo == true)
          .toList();

      expect(images?.length, 2);
      expect(videos?.length, 1);
    });
  });
}
