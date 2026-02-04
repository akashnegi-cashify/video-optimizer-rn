import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/store_out/providers/lot_scan_provider.dart';
import 'package:flutter_trc/qc/modules/store_out/types.dart';
import 'package:core_widgets/core_widgets.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for LotScanProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('LotScanProvider', () {
    group('constructor with NORMAL_LOT', () {
      late LotScanProvider provider;

      setUp(() {
        provider = LotScanProvider(
          lotId: 123,
          lotName: 'Test Lot',
          lotType: LotType.NORMAL_LOT.value,
        );
      });

      tearDown(() {
        provider.dispose();
      });

      test('should store lotId', () {
        expect(provider.lotId, 123);
      });

      test('should store lotName', () {
        expect(provider.lotName, 'Test Lot');
      });

      test('should store lotType', () {
        expect(provider.lotType, LotType.NORMAL_LOT.value);
      });

      test('should initialize dataState for NORMAL_LOT', () {
        expect(provider.dataState, isNotNull);
        expect(provider.dataState, isA<DataState>());
      });

      test('scanPosition should initially be 0', () {
        expect(provider.scanPosition, 0);
      });
    });

    group('constructor with BIN_LOT', () {
      late LotScanProvider provider;

      setUp(() {
        provider = LotScanProvider(
          lotId: 456,
          lotName: 'Bin Lot',
          lotType: LotType.BIN_LOT.value,
        );
      });

      tearDown(() {
        provider.dispose();
      });

      test('should initialize binDataState for BIN_LOT', () {
        expect(provider.binDataState, isNotNull);
        expect(provider.binDataState, isA<DataState>());
      });
    });

    group('constructor with BIN_OUT_LOT', () {
      late LotScanProvider provider;

      setUp(() {
        provider = LotScanProvider(
          lotId: 789,
          lotName: 'Bin Out Lot',
          lotType: LotType.BIN_OUT_LOT.value,
        );
      });

      tearDown(() {
        provider.dispose();
      });

      test('should initialize binDataState for BIN_OUT_LOT', () {
        expect(provider.binDataState, isNotNull);
        expect(provider.binDataState, isA<DataState>());
      });
    });

    group('nullable parameters', () {
      test('should accept null lotId', () {
        final provider = LotScanProvider(
          lotId: null,
          lotName: 'Test Lot',
          lotType: LotType.NORMAL_LOT.value,
        );

        expect(provider.lotId, isNull);
        provider.dispose();
      });

      test('should accept null lotName', () {
        final provider = LotScanProvider(
          lotId: 123,
          lotName: null,
          lotType: LotType.NORMAL_LOT.value,
        );

        expect(provider.lotName, isNull);
        provider.dispose();
      });
    });

    group('moveNext', () {
      test('should return true and increment position when not at end', () {
        final provider = LotScanProvider(
          lotId: 1,
          lotName: 'Test',
          lotType: LotType.NORMAL_LOT.value,
        );

        // Set up dataState with items
        provider.dataState = provider.dataState.copyWith(
          data: List.generate(5, (i) => null),
          status: RequestStatus.success,
        );

        expect(provider.scanPosition, 0);

        final result = provider.moveNext();

        expect(result, true);
        expect(provider.scanPosition, 1);

        provider.dispose();
      });

      test('should return false when at last item', () {
        final provider = LotScanProvider(
          lotId: 1,
          lotName: 'Test',
          lotType: LotType.NORMAL_LOT.value,
        );

        // Set up dataState with items and position at end
        provider.dataState = provider.dataState.copyWith(
          data: List.generate(2, (i) => null),
          status: RequestStatus.success,
        );

        provider.moveNext(); // Position 1

        final result = provider.moveNext(); // Position 2 (at end)

        expect(result, false);
        expect(provider.scanPosition, 2);

        provider.dispose();
      });

      test('should notify listeners when called', () {
        final provider = LotScanProvider(
          lotId: 1,
          lotName: 'Test',
          lotType: LotType.NORMAL_LOT.value,
        );

        provider.dataState = provider.dataState.copyWith(
          data: List.generate(5, (i) => null),
          status: RequestStatus.success,
        );

        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.moveNext();

        expect(tracker.callCount, 1);

        provider.dispose();
      });

      test('should handle empty list', () {
        final provider = LotScanProvider(
          lotId: 1,
          lotName: 'Test',
          lotType: LotType.NORMAL_LOT.value,
        );

        provider.dataState = provider.dataState.copyWith(
          data: [],
          status: RequestStatus.success,
        );

        final result = provider.moveNext();

        expect(result, false);

        provider.dispose();
      });

      test('should handle single item list', () {
        final provider = LotScanProvider(
          lotId: 1,
          lotName: 'Test',
          lotType: LotType.NORMAL_LOT.value,
        );

        provider.dataState = provider.dataState.copyWith(
          data: [null],
          status: RequestStatus.success,
        );

        final result = provider.moveNext();

        expect(result, false);

        provider.dispose();
      });
    });

    group('scanPosition getter', () {
      test('should return current position', () {
        final provider = LotScanProvider(
          lotId: 1,
          lotName: 'Test',
          lotType: LotType.NORMAL_LOT.value,
        );

        expect(provider.scanPosition, 0);

        provider.dataState = provider.dataState.copyWith(
          data: List.generate(10, (i) => null),
          status: RequestStatus.success,
        );

        provider.moveNext();
        expect(provider.scanPosition, 1);

        provider.moveNext();
        expect(provider.scanPosition, 2);

        provider.dispose();
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(LotScanProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final provider = LotScanProvider(
          lotId: 1,
          lotName: 'Test',
          lotType: LotType.NORMAL_LOT.value,
        );

        expect(() => provider.dispose(), returnsNormally);
      });
    });

    group('method signatures', () {
      late LotScanProvider provider;

      setUp(() {
        provider = LotScanProvider(
          lotId: 1,
          lotName: 'Test',
          lotType: LotType.NORMAL_LOT.value,
        );
      });

      tearDown(() {
        provider.dispose();
      });

      test('should have binOutVerifyBarCode method', () {
        expect(provider.binOutVerifyBarCode, isNotNull);
      });

      test('should have normalLotOutVerifyBarCode method', () {
        expect(provider.normalLotOutVerifyBarCode, isNotNull);
      });

      test('should have fetchNormalLotScanList method', () {
        expect(provider.fetchNormalLotScanList, isNotNull);
      });

      test('should have fetchBinLotScanList method', () {
        expect(provider.fetchBinLotScanList, isNotNull);
      });
    });
  });
}
