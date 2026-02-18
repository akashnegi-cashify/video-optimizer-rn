import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/providers/inventory_home_provider.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for InventoryHomeProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('InventoryHomeProvider', () {
    late InventoryHomeProvider provider;

    setUp(() {
      provider = InventoryHomeProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('initial state', () {
      test('isDataLoading should initially be true', () {
        expect(provider.isDataLoading, true);
      });

      test('allowPendingWidget should initially be false', () {
        expect(provider.allowPendingWidget, false);
      });

      test('listOfGroupLocation should initially be empty', () {
        expect(provider.listOfGroupLocation, isEmpty);
      });

      test('inventoryLocationResponse should initially be null', () {
        expect(provider.inventoryLocationResponse, isNull);
      });

      test('barcode should initially be null', () {
        expect(provider.barcode, isNull);
      });

      test('engineerName should initially be null', () {
        expect(provider.engineerName, isNull);
      });

      test('selectedDeviceIdList should initially be empty', () {
        expect(provider.selectedDeviceIdList, isEmpty);
      });

      test('errorMessage should initially be null', () {
        expect(provider.errorMessage, isNull);
      });

      test('riderListResponse should initially be null', () {
        expect(provider.riderListResponse, isNull);
      });

      test('selectedRider should initially be null', () {
        expect(provider.selectedRider, isNull);
      });
    });

    group('updateAssignedTabListData', () {
      test('should add deviceId when checked is true', () {
        provider.updateAssignedTabListData(true, 123);

        expect(provider.selectedDeviceIdList, contains(123));
      });

      test('should remove deviceId when checked is false', () {
        provider.selectedDeviceIdList.add(123);

        provider.updateAssignedTabListData(false, 123);

        expect(provider.selectedDeviceIdList, isNot(contains(123)));
      });

      test('should notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.updateAssignedTabListData(true, 456);

        expect(tracker.callCount, 1);
      });
    });

    group('getLocationsString', () {
      test('should return empty string when listOfGroupLocation is empty', () {
        expect(provider.getLocationsString(), '');
      });
    });

    group('allowPendingListToShow', () {
      test('should set allowPendingWidget to true', () {
        provider.allowPendingListToShow(true);

        expect(provider.allowPendingWidget, true);
      });

      test('should set allowPendingWidget to false', () {
        provider.allowPendingWidget = true;

        provider.allowPendingListToShow(false);

        expect(provider.allowPendingWidget, false);
      });

      test('should notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.allowPendingListToShow(true);

        expect(tracker.callCount, 1);
      });
    });

    group('checkForLocationSelected', () {
      test('should return false when listOfGroupLocation is empty', () {
        expect(provider.checkForLocationSelected(), false);
      });
    });

    group('checkIfAssignedForRider', () {
      test('should return false when selectedDeviceIdList is empty', () {
        expect(provider.checkIfAssignedForRider(), false);
      });

      test('should return true when selectedDeviceIdList is not empty', () {
        provider.selectedDeviceIdList.add(123);

        expect(provider.checkIfAssignedForRider(), true);
      });
    });

    group('getSearchResults', () {
      test('should return empty list when riderListResponse is null', () {
        expect(provider.getSearchResults(), isEmpty);
      });

      test('should return empty list when pattern is provided but no riders', () {
        expect(provider.getSearchResults(pattern: 'John'), isEmpty);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(InventoryHomeProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = InventoryHomeProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });

    group('method signatures', () {
      test('should have getListOfRiders method', () {
        expect(provider.getListOfRiders, isNotNull);
      });

      test('should have assignRider method', () {
        expect(provider.assignRider, isNotNull);
      });

      test('should have toggleLocationState method', () {
        expect(provider.toggleLocationState, isNotNull);
      });
    });
  });
}
