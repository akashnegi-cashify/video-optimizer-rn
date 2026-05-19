import 'dart:async';

import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:csh_gallery_view/gallery/types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Widget imports
import 'package:flutter_trc/src/modules/engineer/widgets/device_report_widget.dart';
import 'package:flutter_trc/src/modules/engineer/providers/device_report_provider.dart';
import 'package:flutter_trc/src/modules/engineer/models/device_report_response.dart';

/// Mock for DeviceReportProvider
class MockDeviceReportProvider extends Mock implements DeviceReportProvider {
  final DeviceReportData? mockReportData;
  final String? mockError;
  final List<List<ImageData>>? mockMediaList;

  MockDeviceReportProvider({
    this.mockReportData,
    this.mockError,
    this.mockMediaList,
  });

  @override
  Future<DeviceReportData> getDeviceReport() {
    if (mockError != null) {
      return Future.error(mockError!);
    }
    return Future.value(mockReportData ?? DeviceReportData([], null));
  }

  @override
  Future<List<List<ImageData>>> getDeviceMedia() {
    if (mockMediaList != null) {
      return Future.value(mockMediaList!);
    }
    return Future.error('No Media Found');
  }
}

void main() {
  group('DeviceReportWidget', () {
    group('unit tests', () {
      test('DeviceReportWidget is a StatelessWidget', () {
        const widget = DeviceReportWidget();
        expect(widget, isA<StatelessWidget>());
      });

      test('DeviceReportWidget can be instantiated with default constructor', () {
        const widget = DeviceReportWidget();
        expect(widget, isNotNull);
        expect(widget.key, isNull);
      });

      test('DeviceReportWidget can be instantiated with a key', () {
        const key = Key('device_report_widget_key');
        const widget = DeviceReportWidget(key: key);
        expect(widget.key, equals(key));
      });

      test('multiple instances can be created independently', () {
        const widget1 = DeviceReportWidget(key: Key('widget1'));
        const widget2 = DeviceReportWidget(key: Key('widget2'));
        expect(widget1.key, isNot(equals(widget2.key)));
      });
    });
  });

  group('MockDeviceReportProvider', () {
    test('returns mock report data on success', () async {
      final mockData = DeviceReportData([], 'Test remarks');
      final provider = MockDeviceReportProvider(mockReportData: mockData);
      
      final result = await provider.getDeviceReport();
      expect(result.testingRemarks, 'Test remarks');
    });

    test('returns error when mockError is set', () async {
      final provider = MockDeviceReportProvider(mockError: 'Test error');
      
      expect(
        () => provider.getDeviceReport(),
        throwsA(equals('Test error')),
      );
    });

    test('returns mock media list when set', () async {
      final mockMedia = [
        [ImageData(1, 'http://image1.url')],
        [ImageData(2, 'http://image2.url')],
      ];
      final provider = MockDeviceReportProvider(mockMediaList: mockMedia);
      
      final result = await provider.getDeviceMedia();
      expect(result.length, 2);
    });

    test('returns error for media when mockMediaList is null', () async {
      final provider = MockDeviceReportProvider();
      
      expect(
        () => provider.getDeviceMedia(),
        throwsA(equals('No Media Found')),
      );
    });
  });

  group('DeviceReportData model', () {
    test('DeviceReportData can be instantiated with positional args', () {
      final data = DeviceReportData([], null);
      expect(data, isNotNull);
    });

    test('DeviceReportData can be instantiated with testing remarks', () {
      final data = DeviceReportData(null, 'Test remarks');
      expect(data.testingRemarks, 'Test remarks');
    });

    test('DeviceReportData can have device report list', () {
      final reportList = [DeviceReport('Screen', 'Cracked', 1, false)];
      final data = DeviceReportData(reportList, 'Test remarks');
      expect(data.deviceReportList?.length, 1);
      expect(data.deviceReportList?.first.partName, 'Screen');
    });

    test('DeviceReportData handles null values', () {
      final data = DeviceReportData(null, null);
      expect(data.testingRemarks, isNull);
      expect(data.deviceReportList, isNull);
    });

    test('DeviceReportData can have empty device report list', () {
      final data = DeviceReportData([], 'Test remarks');
      expect(data.deviceReportList, isEmpty);
    });

    test('DeviceReportData fromJson works correctly', () {
      final json = {
        'dr': [
          {'pn': 'Screen', 'vn': 'Cracked', 'id': 1, 'isFail': false}
        ],
        'tr': 'Testing remarks',
      };
      final data = DeviceReportData.fromJson(json);
      expect(data.testingRemarks, 'Testing remarks');
      expect(data.deviceReportList?.length, 1);
    });
  });

  group('DeviceReport model', () {
    test('DeviceReport can be instantiated with all parameters', () {
      final report = DeviceReport('Screen Quality', 'Poor', 1, true);
      expect(report.partName, 'Screen Quality');
      expect(report.variationName, 'Poor');
      expect(report.id, 1);
      expect(report.isFail, true);
    });

    test('DeviceReport handles null part name', () {
      final report = DeviceReport(null, 'Poor', 1, false);
      expect(report.partName, isNull);
    });

    test('DeviceReport handles null variation name', () {
      final report = DeviceReport('Screen', null, 1, false);
      expect(report.variationName, isNull);
    });

    test('DeviceReport fromJson works correctly', () {
      final json = {
        'pn': 'Battery',
        'vn': 'Good',
        'id': 2,
        'isFail': false,
      };
      final report = DeviceReport.fromJson(json);
      expect(report.partName, 'Battery');
      expect(report.variationName, 'Good');
      expect(report.id, 2);
      expect(report.isFail, false);
    });
  });
}
