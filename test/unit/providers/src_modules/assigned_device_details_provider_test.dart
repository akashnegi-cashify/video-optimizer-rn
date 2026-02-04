import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/providers/assigned_device_details_provider.dart';
import '../../../helpers/provider_test_helpers.dart';

/// Tests for AssignedDeviceDetailsProvider - Inventory Manager module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('AssignedDeviceDetailsProvider', () {
    late AssignedDeviceDetailsProvider provider;

    setUp(() {
      provider = AssignedDeviceDetailsProvider(12345);
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should store did', () {
        expect(provider.did, 12345);
      });

      test('should have isDataLoading initially true', () {
        expect(provider.isDataLoading, isTrue);
      });

      test('should have empty errMessage initially', () {
        expect(provider.errMessage, '');
      });

      test('should have isListDataLoading initially true', () {
        expect(provider.isListDataLoading, isTrue);
      });

      test('should have empty listErrorMessage initially', () {
        expect(provider.listErrorMessage, '');
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(AssignedDeviceDetailsProvider.of, isNotNull);
      });
    });

    group('assignedDeviceDetails', () {
      test('should be null initially', () {
        expect(provider.assignedDeviceDetails, isNull);
      });
    });

    group('deviceAllottedPartsResponse', () {
      test('should be null initially', () {
        expect(provider.deviceAllottedPartsResponse, isNull);
      });
    });

    group('refreshDataOnPage', () {
      test('should set isDataLoading to true', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);
        
        provider.refreshDataOnPage();
        
        expect(provider.isDataLoading, isTrue);
        provider.removeListener(tracker.listener);
      });

      test('should set isListDataLoading to true', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);
        
        provider.refreshDataOnPage();
        
        expect(provider.isListDataLoading, isTrue);
        provider.removeListener(tracker.listener);
      });

      test('should notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);
        
        provider.refreshDataOnPage();
        
        expect(tracker.callCount, greaterThanOrEqualTo(1));
        provider.removeListener(tracker.listener);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = AssignedDeviceDetailsProvider(100);
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
