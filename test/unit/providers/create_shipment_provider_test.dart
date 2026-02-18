import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/providers/create_shipment_provider.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/box_list_response.dart';
import 'package:flutter_trc/shipex/modules/create_shipment/models/shipment_provider_list_response.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for CreateShipmentProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('CreateShipmentProvider', () {
    late CreateShipmentProvider provider;

    setUp(() {
      provider = CreateShipmentProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should create instance without parameters', () {
        expect(provider, isNotNull);
      });

      test('should accept pincode parameter', () {
        final providerWithPincode = CreateShipmentProvider(pincode: '400001');
        expect(providerWithPincode.pincode, '400001');
        providerWithPincode.dispose();
      });

      test('should accept groupId parameter', () {
        final providerWithGroupId = CreateShipmentProvider(groupId: '123');
        expect(providerWithGroupId.groupId, '123');
        providerWithGroupId.dispose();
      });

      test('should accept both parameters', () {
        final providerWithBoth = CreateShipmentProvider(
          pincode: '400001',
          groupId: '456',
        );
        expect(providerWithBoth.pincode, '400001');
        expect(providerWithBoth.groupId, '456');
        providerWithBoth.dispose();
      });
    });

    group('initial state', () {
      test('boxDataLoading should initially be true', () {
        expect(provider.boxDataLoading, true);
      });

      test('providerDataListLoading should initially be false', () {
        expect(provider.providerDataListLoading, false);
      });

      test('estimatedProviderDataLoading should initially be false', () {
        expect(provider.estimatedProviderDataLoading, false);
      });

      test('boxList should initially be null', () {
        expect(provider.boxList, isNull);
      });

      test('providerList should initially be null', () {
        expect(provider.providerList, isNull);
      });

      test('selectedBox should initially be null', () {
        expect(provider.selectedBox, isNull);
      });

      test('selectedProvider should initially be null', () {
        expect(provider.selectedProvider, isNull);
      });

      test('boxDataErrorMessage should initially be null', () {
        expect(provider.boxDataErrorMessage, isNull);
      });

      test('providerDataErrorMessage should initially be null', () {
        expect(provider.providerDataErrorMessage, isNull);
      });

      test('estimatedProvider should initially be null', () {
        expect(provider.estimatedProvider, isNull);
      });
    });

    group('onBoxChange', () {
      test('should update selectedBox', () {
        final newBox = BoxListData.fromJson({'id': 1, 'name': 'Small Box'});

        provider.onBoxChange(newBox);

        expect(provider.selectedBox?.id, 1);
        expect(provider.selectedBox?.name, 'Small Box');
      });

      test('should reset selectedProvider when box changes', () {
        final box = BoxListData.fromJson({'id': 1, 'name': 'Box'});
        provider.selectedProvider = ShipmentProviderListData.fromJson({
          'key': 'dhl',
          'name': 'DHL',
        });

        provider.onBoxChange(box);

        expect(provider.selectedProvider, isNull);
      });
    });

    group('onProviderChange', () {
      test('should update selectedProvider', () {
        final newProvider = ShipmentProviderListData.fromJson({
          'key': 'dhl',
          'name': 'DHL Express',
        });

        provider.onProviderChange(newProvider);

        expect(provider.selectedProvider?.key, 'dhl');
        expect(provider.selectedProvider?.name, 'DHL Express');
      });

      test('should notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);
        final newProvider = ShipmentProviderListData.fromJson({
          'key': 'fedex',
          'name': 'FedEx',
        });

        provider.onProviderChange(newProvider);

        expect(tracker.callCount, 1);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(CreateShipmentProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = CreateShipmentProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });

    group('method signatures', () {
      test('should have generateShipment method', () {
        expect(provider.generateShipment, isNotNull);
      });
    });
  });
}
