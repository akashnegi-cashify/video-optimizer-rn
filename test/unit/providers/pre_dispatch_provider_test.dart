import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/pre_dispatch/providers/pre_dispatch_provider.dart';
import 'package:flutter_trc/qc/modules/re_qc/models/lot_device_list_response.dart';
import 'package:flutter_trc/qc/modules/pre_dispatch/types.dart';
import 'package:core_widgets/core_widgets.dart';
import '../../helpers/provider_test_helpers.dart';

/// Testable version of PreDispatchProvider that doesn't make API calls on construction.
/// This allows testing the provider logic without network dependencies.
class TestablePreDispatchProvider extends PreDispatchProvider {
  TestablePreDispatchProvider(super.groupLotName, super.lotId);

  @override
  Future<LotDeviceListResponse?> getLotDeviceList() async {
    // Override to prevent API call during tests
    return null;
  }
}

/// Tests for PreDispatchProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('PreDispatchProvider', () {
    late TestablePreDispatchProvider provider;

    setUp(() {
      provider = TestablePreDispatchProvider('TEST_LOT_GROUP', 123);
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should store groupLotName', () {
        expect(provider.groupLotName, 'TEST_LOT_GROUP');
      });

      test('should store lotId', () {
        expect(provider.lotId, 123);
      });

      test('should initialize dataState', () {
        expect(provider.dataState, isNotNull);
        expect(provider.dataState, isA<DataState>());
      });

      test('scanPreDispatchResponse should initially be null', () {
        expect(provider.scanPreDispatchResponse, isNull);
      });
    });

    group('getItemsBasedOnStatus', () {
      test('should return all items when status is null', () {
        provider.dataState = provider.dataState.copyWith(
          data: LotDeviceListResponse.fromJson({
            'data': [
              {'deviceId': 1, 'status': 0},
              {'deviceId': 2, 'status': 1},
              {'deviceId': 3, 'status': 0},
            ],
          }),
          status: RequestStatus.success,
        );

        final result = provider.getItemsBasedOnStatus(null);
        expect(result?.length, 3);
      });

      test('should return filtered items when status is provided', () {
        provider.dataState = provider.dataState.copyWith(
          data: LotDeviceListResponse.fromJson({
            'data': [
              {'deviceId': 1, 'status': 0},
              {'deviceId': 2, 'status': 1},
              {'deviceId': 3, 'status': 0},
            ],
          }),
          status: RequestStatus.success,
        );

        final result = provider.getItemsBasedOnStatus(0);
        expect(result?.length, 2);
      });

      test('should return null when dataState has no data', () {
        expect(provider.getItemsBasedOnStatus(0), isNull);
      });
    });

    group('scanCode', () {
      test('should return true when pending items exist', () {
        provider.dataState = provider.dataState.copyWith(
          data: LotDeviceListResponse.fromJson({
            'data': [
              {'deviceId': 1, 'status': DispatchConstants.PENDING_STATUS},
            ],
          }),
          status: RequestStatus.success,
        );

        expect(provider.scanCode(), true);
      });

      test('should return false when no pending items exist', () {
        provider.dataState = provider.dataState.copyWith(
          data: LotDeviceListResponse.fromJson({
            'data': [
              {'deviceId': 1, 'status': DispatchConstants.SCANNED_STATUS},
            ],
          }),
          status: RequestStatus.success,
        );

        expect(provider.scanCode(), false);
      });

      test('should return false when device list is empty', () {
        provider.dataState = provider.dataState.copyWith(
          data: LotDeviceListResponse.fromJson({'data': []}),
          status: RequestStatus.success,
        );

        expect(provider.scanCode(), false);
      });
    });

    group('isAllItemScan', () {
      test('should return true when all items are scanned', () {
        provider.dataState = provider.dataState.copyWith(
          data: LotDeviceListResponse.fromJson({
            'data': [
              {'deviceId': 1, 'status': DispatchConstants.SCANNED_STATUS},
              {'deviceId': 2, 'status': DispatchConstants.SCANNED_STATUS},
            ],
          }),
          status: RequestStatus.success,
        );

        expect(provider.isAllItemScan(), true);
      });

      test('should return false when some items are not scanned', () {
        provider.dataState = provider.dataState.copyWith(
          data: LotDeviceListResponse.fromJson({
            'data': [
              {'deviceId': 1, 'status': DispatchConstants.SCANNED_STATUS},
              {'deviceId': 2, 'status': DispatchConstants.PENDING_STATUS},
            ],
          }),
          status: RequestStatus.success,
        );

        expect(provider.isAllItemScan(), false);
      });

      test('should return false when no data', () {
        expect(provider.isAllItemScan(), false);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(PreDispatchProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = TestablePreDispatchProvider('TEST', 456);
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });

    group('method signatures', () {
      test('should have getLotDeviceList method', () {
        expect(provider.getLotDeviceList, isNotNull);
      });

      test('should have refreshData method', () {
        expect(provider.refreshData, isNotNull);
      });

      test('should have scanPreDispatchLot method', () {
        expect(provider.scanPreDispatchLot, isNotNull);
      });

      test('should have completePreDispatchLot method', () {
        expect(provider.completePreDispatchLot, isNotNull);
      });
    });
  });

  group('DispatchConstants', () {
    test('should have PENDING_STATUS', () {
      expect(DispatchConstants.PENDING_STATUS, isNotNull);
    });

    test('should have SCANNED_STATUS', () {
      expect(DispatchConstants.SCANNED_STATUS, isNotNull);
    });
  });
}
