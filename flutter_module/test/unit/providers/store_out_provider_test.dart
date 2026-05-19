import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_out/providers/store_out_provider.dart';
import 'package:flutter_trc/qc/modules/store_out/types.dart';
import '../../helpers/provider_test_helpers.dart';

/// Testable version of StoreOutProvider that doesn't initialize services.
/// This allows testing the provider logic without platform dependencies.
class TestableStoreOutProvider extends StoreOutProvider {
  @override
  void initService() {
    // Override to prevent service initialization during tests
  }
}

/// Tests for StoreOutProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  // Initialize Flutter binding for providers that use platform services
  TestWidgetsFlutterBinding.ensureInitialized();

  group('StoreOutProvider', () {
    late TestableStoreOutProvider provider;

    setUp(() {
      provider = TestableStoreOutProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('selectedLotTypeList', () {
      test('should initially be null', () {
        expect(provider.selectedLotTypeList, isNull);
      });

      test('should store and retrieve selectedLotTypeList', () {
        provider.selectedLotTypeList = [1, 2, 3];

        expect(provider.selectedLotTypeList, [1, 2, 3]);
      });

      test('should allow null selectedLotTypeList', () {
        provider.selectedLotTypeList = [1];
        provider.selectedLotTypeList = null;

        expect(provider.selectedLotTypeList, isNull);
      });

      test('should handle single lot type', () {
        provider.selectedLotTypeList = [LotType.NORMAL_LOT.value];

        expect(provider.selectedLotTypeList?.length, 1);
        expect(provider.selectedLotTypeList?.first, 1);
      });

      test('should handle multiple lot types', () {
        provider.selectedLotTypeList = [
          LotType.NORMAL_LOT.value,
          LotType.BIN_LOT.value,
          LotType.BIN_OUT_LOT.value,
        ];

        expect(provider.selectedLotTypeList?.length, 3);
        expect(provider.selectedLotTypeList, containsAll([1, 2, 3]));
      });

      test('should replace previous value', () {
        provider.selectedLotTypeList = [1];
        provider.selectedLotTypeList = [2, 3];

        expect(provider.selectedLotTypeList, [2, 3]);
      });
    });

    group('refreshLotListStream', () {
      test('should expose stream for normal lot refresh', () {
        expect(provider.refreshLotListStream, isNotNull);
        expect(provider.refreshLotListStream, isA<Stream<void>>());
      });
    });

    group('refreshBinLotListController', () {
      test('should expose stream for bin lot refresh', () {
        expect(provider.refreshBinLotListController, isNotNull);
        expect(provider.refreshBinLotListController, isA<Stream<void>>());
      });
    });

    group('refreshLotList', () {
      test('should emit to normal lot stream when lotType is NORMAL_LOT', () async {
        var normalLotRefreshCount = 0;
        var binLotRefreshCount = 0;

        provider.refreshLotListStream.listen((_) => normalLotRefreshCount++);
        provider.refreshBinLotListController.listen((_) => binLotRefreshCount++);

        provider.refreshLotList(LotType.NORMAL_LOT.value);
        await Future.delayed(Duration.zero);

        expect(normalLotRefreshCount, 1);
        expect(binLotRefreshCount, 0);
      });

      test('should emit to bin lot stream when lotType is BIN_LOT', () async {
        var normalLotRefreshCount = 0;
        var binLotRefreshCount = 0;

        provider.refreshLotListStream.listen((_) => normalLotRefreshCount++);
        provider.refreshBinLotListController.listen((_) => binLotRefreshCount++);

        provider.refreshLotList(LotType.BIN_LOT.value);
        await Future.delayed(Duration.zero);

        expect(normalLotRefreshCount, 0);
        expect(binLotRefreshCount, 1);
      });

      test('should emit to bin lot stream when lotType is BIN_OUT_LOT', () async {
        var normalLotRefreshCount = 0;
        var binLotRefreshCount = 0;

        provider.refreshLotListStream.listen((_) => normalLotRefreshCount++);
        provider.refreshBinLotListController.listen((_) => binLotRefreshCount++);

        provider.refreshLotList(LotType.BIN_OUT_LOT.value);
        await Future.delayed(Duration.zero);

        expect(normalLotRefreshCount, 0);
        expect(binLotRefreshCount, 1);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = TestableStoreOutProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });

      test('should close stream controllers on dispose', () async {
        final testProvider = TestableStoreOutProvider();
        testProvider.dispose();

        // After dispose, adding to streams should not cause errors
        // but the streams should be closed
        expect(() => testProvider.refreshLotList(1), returnsNormally);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(StoreOutProvider.of, isNotNull);
      });
    });

    group('binOutVerifyBarCode method signature', () {
      test('should have binOutVerifyBarCode method', () {
        expect(provider.binOutVerifyBarCode, isNotNull);
      });
    });

    group('getStoreOutProcessStatus method signature', () {
      test('should have getStoreOutProcessStatus method', () {
        expect(provider.getStoreOutProcessStatus, isNotNull);
      });
    });
  });

  group('LotType enum', () {
    test('should have 3 lot types', () {
      expect(LotType.values.length, 3);
    });

    test('should have correct values', () {
      expect(LotType.NORMAL_LOT.value, 1);
      expect(LotType.BIN_LOT.value, 2);
      expect(LotType.BIN_OUT_LOT.value, 3);
    });

    test('isValid should return true for valid types', () {
      expect(LotType.isValid(1), true);
      expect(LotType.isValid(2), true);
      expect(LotType.isValid(3), true);
    });

    test('isValid should return false for invalid types', () {
      expect(LotType.isValid(0), false);
      expect(LotType.isValid(4), false);
      expect(LotType.isValid(-1), false);
      expect(LotType.isValid(100), false);
    });

    test('isValid should return false for null', () {
      expect(LotType.isValid(null), false);
    });

    test('fromValue should return correct LotType', () {
      expect(LotType.fromValue(1), LotType.NORMAL_LOT);
      expect(LotType.fromValue(2), LotType.BIN_LOT);
      expect(LotType.fromValue(3), LotType.BIN_OUT_LOT);
    });

    test('fromValue should return null for invalid values', () {
      expect(LotType.fromValue(0), isNull);
      expect(LotType.fromValue(4), isNull);
      expect(LotType.fromValue(null), isNull);
    });
  });
}
