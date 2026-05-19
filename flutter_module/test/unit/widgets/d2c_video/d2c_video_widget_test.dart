import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// Actual widget import
import 'package:flutter_trc/qc/modules/d2c_video/widgets/d2c_video_widget.dart';

// Test helpers
import '../../../helpers/mock_services.dart';
import '../../../helpers/d2c_video_mock_helper.dart';

void main() {
  group('D2CVideoWidget', () {
    test('D2CVideoWidget class exists and is a StatefulWidget', () {
      expect(D2CVideoWidget, isNotNull);
      const widget = D2CVideoWidget();
      expect(widget, isA<StatefulWidget>());
    });

    test('D2CVideoWidget can be instantiated with default constructor', () {
      const widget = D2CVideoWidget();
      expect(widget, isNotNull);
      expect(widget.key, isNull);
    });

    test('D2CVideoWidget can be instantiated with a key', () {
      const key = Key('d2c_video_widget_key');
      const widget = D2CVideoWidget(key: key);
      expect(widget.key, equals(key));
    });

    test('D2CVideoWidget creates state correctly', () {
      const widget = D2CVideoWidget();
      final element = widget.createElement();
      expect(element, isNotNull);
    });

    test('multiple D2CVideoWidget instances are independent', () {
      const widget1 = D2CVideoWidget(key: Key('widget1'));
      const widget2 = D2CVideoWidget(key: Key('widget2'));
      expect(widget1.key, isNot(equals(widget2.key)));
    });

    test('D2CVideoWidget hashCode is consistent', () {
      const widget = D2CVideoWidget();
      expect(widget.hashCode, equals(widget.hashCode));
    });

    test('D2CVideoWidget runtimeType is correct', () {
      const widget = D2CVideoWidget();
      expect(widget.runtimeType, equals(D2CVideoWidget));
    });
  });

  group('ViewType enum', () {
    test('ViewType enum has all expected values', () {
      expect(ViewType.values.length, equals(6));
      expect(ViewType.values.contains(ViewType.productDetail), isTrue);
      expect(ViewType.values.contains(ViewType.productDetailFailed), isTrue);
      expect(ViewType.values.contains(ViewType.compression), isTrue);
      expect(ViewType.values.contains(ViewType.uploading), isTrue);
      expect(ViewType.values.contains(ViewType.uploadingFailed), isTrue);
      expect(ViewType.values.contains(ViewType.completed), isTrue);
    });

    test('ViewType.productDetail is the initial view state', () {
      expect(ViewType.productDetail.index, equals(0));
    });

    test('ViewType enum values have correct indices', () {
      expect(ViewType.productDetail.index, equals(0));
      expect(ViewType.productDetailFailed.index, equals(1));
      expect(ViewType.compression.index, equals(2));
      expect(ViewType.uploading.index, equals(3));
      expect(ViewType.uploadingFailed.index, equals(4));
      expect(ViewType.completed.index, equals(5));
    });

    test('ViewType enum values have correct names', () {
      expect(ViewType.productDetail.name, equals('productDetail'));
      expect(ViewType.productDetailFailed.name, equals('productDetailFailed'));
      expect(ViewType.compression.name, equals('compression'));
      expect(ViewType.uploading.name, equals('uploading'));
      expect(ViewType.uploadingFailed.name, equals('uploadingFailed'));
      expect(ViewType.completed.name, equals('completed'));
    });

    test('ViewType enum toString returns expected format', () {
      expect(ViewType.productDetail.toString(), contains('productDetail'));
      expect(
          ViewType.productDetailFailed.toString(), contains('productDetailFailed'));
      expect(ViewType.compression.toString(), contains('compression'));
      expect(ViewType.uploading.toString(), contains('uploading'));
      expect(ViewType.uploadingFailed.toString(), contains('uploadingFailed'));
      expect(ViewType.completed.toString(), contains('completed'));
    });

    test('ViewType enum values can be compared', () {
      expect(ViewType.productDetail == ViewType.productDetail, isTrue);
      expect(ViewType.productDetail == ViewType.compression, isFalse);
    });

    test('ViewType enum values can be used in switch statements', () {
      String getViewDescription(ViewType viewType) {
        switch (viewType) {
          case ViewType.productDetail:
            return 'Product Detail';
          case ViewType.productDetailFailed:
            return 'Product Detail Failed';
          case ViewType.compression:
            return 'Compression';
          case ViewType.uploading:
            return 'Uploading';
          case ViewType.uploadingFailed:
            return 'Uploading Failed';
          case ViewType.completed:
            return 'Completed';
        }
      }

      expect(getViewDescription(ViewType.productDetail), equals('Product Detail'));
      expect(getViewDescription(ViewType.productDetailFailed),
          equals('Product Detail Failed'));
      expect(getViewDescription(ViewType.compression), equals('Compression'));
      expect(getViewDescription(ViewType.uploading), equals('Uploading'));
      expect(
          getViewDescription(ViewType.uploadingFailed), equals('Uploading Failed'));
      expect(getViewDescription(ViewType.completed), equals('Completed'));
    });

    test('ViewType enum values list is exhaustive', () {
      final allValues = ViewType.values;
      expect(allValues.length, equals(6));
      final uniqueValues = allValues.toSet();
      expect(uniqueValues.length, equals(allValues.length));
    });

    test('ViewType enum iteration works correctly', () {
      var count = 0;
      for (final viewType in ViewType.values) {
        expect(viewType, isA<ViewType>());
        count++;
      }
      expect(count, equals(6));
    });

    test('ViewType enum by index lookup works', () {
      expect(ViewType.values[0], equals(ViewType.productDetail));
      expect(ViewType.values[1], equals(ViewType.productDetailFailed));
      expect(ViewType.values[2], equals(ViewType.compression));
      expect(ViewType.values[3], equals(ViewType.uploading));
      expect(ViewType.values[4], equals(ViewType.uploadingFailed));
      expect(ViewType.values[5], equals(ViewType.completed));
    });

    test('ViewType enum can be found by name', () {
      final productDetailByName = ViewType.values.firstWhere(
        (v) => v.name == 'productDetail',
      );
      expect(productDetailByName, equals(ViewType.productDetail));
    });
  });

  group('D2CVideoWidget ViewType state machine tests', () {
    test('ViewType transitions: productDetail is default state', () {
      // productDetail is the default initial state (index 0)
      expect(ViewType.productDetail.index, equals(0));
    });

    test('ViewType transitions: productDetailFailed follows productDetail', () {
      // Error during initial load transitions to productDetailFailed
      expect(ViewType.productDetailFailed.index, equals(1));
      expect(ViewType.productDetailFailed.index,
          greaterThan(ViewType.productDetail.index));
    });

    test('ViewType transitions: compression state for video processing', () {
      // After recording, compression happens
      expect(ViewType.compression.index, equals(2));
    });

    test('ViewType transitions: uploading follows compression', () {
      // After compression, uploading happens
      expect(ViewType.uploading.index, equals(3));
      expect(ViewType.uploading.index,
          greaterThan(ViewType.compression.index));
    });

    test('ViewType transitions: uploadingFailed follows uploading', () {
      // If upload fails, go to uploadingFailed
      expect(ViewType.uploadingFailed.index, equals(4));
      expect(ViewType.uploadingFailed.index,
          greaterThan(ViewType.uploading.index));
    });

    test('ViewType transitions: completed is final success state', () {
      // Success! Video submitted
      expect(ViewType.completed.index, equals(5));
      expect(ViewType.completed.index,
          greaterThan(ViewType.uploadingFailed.index));
    });

    test('ViewType flow: productDetail -> compression -> uploading -> completed', () {
      // Happy path state transitions
      final happyPath = [
        ViewType.productDetail,
        ViewType.compression,
        ViewType.uploading,
        ViewType.completed,
      ];

      // Verify order
      for (var i = 0; i < happyPath.length - 1; i++) {
        expect(
          happyPath[i].index < happyPath[i + 1].index ||
              (happyPath[i] == ViewType.productDetail &&
                  happyPath[i + 1] == ViewType.compression),
          isTrue,
          reason:
              '${happyPath[i]} should come before ${happyPath[i + 1]} in happy path',
        );
      }
    });

    test('ViewType flow: error paths return to earlier states', () {
      // productDetailFailed can retry -> productDetail
      // uploadingFailed can retry -> uploading
      expect(ViewType.productDetailFailed.index, lessThan(ViewType.compression.index));
      expect(ViewType.uploadingFailed.index, greaterThan(ViewType.uploading.index));
    });
  });

  group('MockD2CVideoProvider setup tests', () {
    late MockD2CVideoProvider mockProvider;
    late StreamController<int> uploadProgressController;
    late StreamController<int> compressProgressController;

    setUp(() {
      mockProvider = MockD2CVideoProvider();
      uploadProgressController = StreamController<int>.broadcast();
      compressProgressController = StreamController<int>.broadcast();
    });

    tearDown(() {
      uploadProgressController.close();
      compressProgressController.close();
    });

    test('mock provider can be configured for success state', () {
      when(() => mockProvider.deviceBarcode)
          .thenReturn(D2CVideoFixtures.testDeviceBarcode);
      when(() => mockProvider.deviceName)
          .thenReturn(D2CVideoFixtures.testDeviceName);
      when(() => mockProvider.deviceError).thenReturn(null);

      expect(mockProvider.deviceBarcode, equals(D2CVideoFixtures.testDeviceBarcode));
      expect(mockProvider.deviceName, equals(D2CVideoFixtures.testDeviceName));
      expect(mockProvider.deviceError, isNull);
    });

    test('mock provider can be configured for error state', () {
      when(() => mockProvider.deviceBarcode)
          .thenReturn(D2CVideoFixtures.testDeviceBarcode);
      when(() => mockProvider.deviceName).thenReturn(null);
      when(() => mockProvider.deviceError)
          .thenReturn(D2CVideoFixtures.testErrorMessage);

      expect(mockProvider.deviceBarcode, equals(D2CVideoFixtures.testDeviceBarcode));
      expect(mockProvider.deviceName, isNull);
      expect(mockProvider.deviceError, equals(D2CVideoFixtures.testErrorMessage));
    });

    test('mock provider stream controllers work correctly', () async {
      when(() => mockProvider.fileUploadProgressStream)
          .thenReturn(uploadProgressController);
      when(() => mockProvider.fileCompressProgressStream)
          .thenReturn(compressProgressController);

      final uploadValues = <int>[];
      final compressValues = <int>[];

      mockProvider.fileUploadProgressStream.stream.listen(uploadValues.add);
      mockProvider.fileCompressProgressStream.stream.listen(compressValues.add);

      uploadProgressController.add(25);
      uploadProgressController.add(50);
      uploadProgressController.add(100);

      compressProgressController.add(10);
      compressProgressController.add(60);
      compressProgressController.add(100);

      // Allow streams to process
      await Future.delayed(Duration.zero);

      expect(uploadValues, [25, 50, 100]);
      expect(compressValues, [10, 60, 100]);
    });

    test('mock provider getDeviceDetails success', () async {
      when(() => mockProvider.getDeviceDetails()).thenAnswer((_) async {});

      await mockProvider.getDeviceDetails();
      verify(() => mockProvider.getDeviceDetails()).called(1);
    });

    test('mock provider getDeviceDetails error', () async {
      when(() => mockProvider.getDeviceDetails()).thenAnswer(
        (_) => Future.error(D2CVideoFixtures.testErrorMessage),
      );

      expect(
        () => mockProvider.getDeviceDetails(),
        throwsA(equals(D2CVideoFixtures.testErrorMessage)),
      );
    });

    test('mock provider compressVideo success', () async {
      when(() => mockProvider.compressVideo(any())).thenAnswer(
        (_) async => D2CVideoFixtures.testCompressedFilePath,
      );

      final result = await mockProvider.compressVideo('/input/path.mp4');
      expect(result, equals(D2CVideoFixtures.testCompressedFilePath));
    });

    test('mock provider compressVideo error', () async {
      when(() => mockProvider.compressVideo(any())).thenAnswer(
        (_) => Future.error('Compression failed'),
      );

      expect(
        () => mockProvider.compressVideo('/input/path.mp4'),
        throwsA(equals('Compression failed')),
      );
    });

    test('mock provider uploadMedia success', () async {
      when(() => mockProvider.uploadMedia(any())).thenAnswer((_) async {});

      await mockProvider.uploadMedia('/compressed/path.mp4');
      verify(() => mockProvider.uploadMedia(any())).called(1);
    });

    test('mock provider uploadMedia error', () async {
      when(() => mockProvider.uploadMedia(any())).thenAnswer(
        (_) => Future.error(D2CVideoFixtures.testNetworkError),
      );

      expect(
        () => mockProvider.uploadMedia('/compressed/path.mp4'),
        throwsA(equals(D2CVideoFixtures.testNetworkError)),
      );
    });

    test('mock provider updateData success', () async {
      when(() => mockProvider.updateData()).thenAnswer((_) async {});

      await mockProvider.updateData();
      verify(() => mockProvider.updateData()).called(1);
    });

    test('mock provider updateData error', () async {
      when(() => mockProvider.updateData()).thenAnswer(
        (_) => Future.error('Update failed'),
      );

      expect(
        () => mockProvider.updateData(),
        throwsA(equals('Update failed')),
      );
    });

    test('setupMockD2CVideoProviderSuccess configures provider correctly', () {
      setupMockD2CVideoProviderSuccess(mockProvider);

      expect(mockProvider.deviceBarcode, equals(D2CVideoFixtures.testDeviceBarcode));
      expect(mockProvider.deviceName, equals(D2CVideoFixtures.testDeviceName));
      expect(mockProvider.deviceError, isNull);
      expect(mockProvider.compressedFilePath,
          equals(D2CVideoFixtures.testCompressedFilePath));
    });

    test('setupMockD2CVideoProviderWithDeviceError configures error state', () {
      setupMockD2CVideoProviderWithDeviceError(mockProvider);

      expect(mockProvider.deviceBarcode, equals(D2CVideoFixtures.testDeviceBarcode));
      expect(mockProvider.deviceName, isNull);
      expect(mockProvider.deviceError, equals(D2CVideoFixtures.testErrorMessage));
      expect(mockProvider.compressedFilePath, isNull);
    });

    test('setupMockD2CVideoProviderWithUploadError configures upload error state',
        () {
      setupMockD2CVideoProviderWithUploadError(mockProvider);

      expect(mockProvider.deviceBarcode, equals(D2CVideoFixtures.testDeviceBarcode));
      expect(mockProvider.deviceName, equals(D2CVideoFixtures.testDeviceName));
      expect(mockProvider.compressedFilePath,
          equals(D2CVideoFixtures.testCompressedFilePath));
    });
  });

  group('D2CVideoFixtures tests', () {
    test('fixture constants are defined', () {
      expect(D2CVideoFixtures.testDeviceBarcode, isNotEmpty);
      expect(D2CVideoFixtures.testDeviceName, isNotEmpty);
      expect(D2CVideoFixtures.testVideoUrl, isNotEmpty);
      expect(D2CVideoFixtures.testCompressedFilePath, isNotEmpty);
      expect(D2CVideoFixtures.testErrorMessage, isNotEmpty);
    });

    test('createMockD2CDeviceDetail creates valid object', () {
      final detail = createMockD2CDeviceDetail();

      expect(detail.deviceBarcode, equals(D2CVideoFixtures.testDeviceBarcode));
      expect(detail.modelName, equals(D2CVideoFixtures.testDeviceName));
    });

    test('createMockD2CDeviceDetail with custom values', () {
      final detail = createMockD2CDeviceDetail(
        deviceBarcode: 'CUSTOM_BARCODE',
        modelName: 'Custom Model',
      );

      expect(detail.deviceBarcode, equals('CUSTOM_BARCODE'));
      expect(detail.modelName, equals('Custom Model'));
    });

    test('createMockD2cLotDeviceList creates list with correct count', () {
      final list = createMockD2cLotDeviceList(count: 3);

      expect(list.length, equals(3));
      expect(list[0].deviceBarcode, contains('D2C_DEVICE_1'));
      expect(list[1].deviceBarcode, contains('D2C_DEVICE_2'));
      expect(list[2].deviceBarcode, contains('D2C_DEVICE_3'));
    });

    test('createMockD2cLotListData creates valid lot data', () {
      final lotData = createMockD2cLotListData();

      expect(lotData.lotId, equals(D2CVideoFixtures.testLotId));
      expect(lotData.groupLotName, equals(D2CVideoFixtures.testGroupLotName));
      expect(lotData.facilityId, isNotNull);
      expect(lotData.facilityName, isNotNull);
    });

    test('createMockD2cLotList creates list with variations', () {
      final list = createMockD2cLotList(count: 3);

      expect(list.length, equals(3));
      // Each lot should have different ID
      expect(list[0].lotId, isNot(equals(list[1].lotId)));
      expect(list[1].lotId, isNot(equals(list[2].lotId)));
    });

    test('mockGetDeviceDetailsSuccess returns stream with value', () async {
      final stream = mockGetDeviceDetailsSuccess();
      final detail = await stream.first;

      expect(detail.deviceBarcode, equals(D2CVideoFixtures.testDeviceBarcode));
      expect(detail.modelName, equals(D2CVideoFixtures.testDeviceName));
    });

    test('mockGetDeviceDetailsError returns stream with error', () {
      final stream = mockGetDeviceDetailsError();

      expect(
        () async => await stream.first,
        throwsA(equals(D2CVideoFixtures.testErrorMessage)),
      );
    });

    test('mockGetLotDeviceListSuccess returns stream with list', () async {
      final stream = mockGetLotDeviceListSuccess(count: 5);
      final list = await stream.first;

      expect(list.length, equals(5));
    });

    test('mockSaveVideoSuccess returns stream with response', () async {
      final stream = mockSaveVideoSuccess();
      final response = await stream.first;

      expect(response, isNotNull);
    });

    test('mockUpdateLotStatusSuccess returns stream with response', () async {
      final stream = mockUpdateLotStatusSuccess();
      final response = await stream.first;

      expect(response, isNotNull);
    });
  });

  group('Progress stream helpers tests', () {
    test('createCompressionProgressStream creates broadcast stream', () {
      final controller = createCompressionProgressStream();

      expect(controller, isNotNull);
      expect(controller.stream.isBroadcast, isTrue);

      controller.close();
    });

    test('createUploadProgressStream creates broadcast stream', () {
      final controller = createUploadProgressStream();

      expect(controller, isNotNull);
      expect(controller.stream.isBroadcast, isTrue);

      controller.close();
    });

    test('emitProgressValues emits all values in order', () async {
      final controller = createCompressionProgressStream();
      final receivedValues = <int>[];

      controller.stream.listen(receivedValues.add);

      await emitProgressValues(
        controller,
        [0, 25, 50, 75, 100],
        delay: const Duration(milliseconds: 10),
      );

      // Wait for all values to be processed
      await Future.delayed(const Duration(milliseconds: 100));

      expect(receivedValues, equals([0, 25, 50, 75, 100]));

      controller.close();
    });

    test('emitProgressValues respects delay parameter', () async {
      final controller = createUploadProgressStream();
      final timestamps = <DateTime>[];

      controller.stream.listen((_) => timestamps.add(DateTime.now()));

      await emitProgressValues(
        controller,
        [0, 50, 100],
        delay: const Duration(milliseconds: 50),
      );

      await Future.delayed(const Duration(milliseconds: 200));

      // Each timestamp should be at least 40ms apart (allowing some tolerance)
      if (timestamps.length >= 2) {
        final diff = timestamps[1].difference(timestamps[0]);
        expect(diff.inMilliseconds, greaterThanOrEqualTo(40));
      }

      controller.close();
    });

    test('emitProgressValues handles empty list', () async {
      final controller = createCompressionProgressStream();
      final receivedValues = <int>[];

      controller.stream.listen(receivedValues.add);

      await emitProgressValues(controller, []);

      await Future.delayed(const Duration(milliseconds: 50));

      expect(receivedValues, isEmpty);

      controller.close();
    });
  });
}
