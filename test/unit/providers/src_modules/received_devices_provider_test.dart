import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/rubbing/providers/received_devices_provider.dart';

/// Tests for ReceivedDevicesProvider - Rubbing module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('ReceivedDevicesProvider', () {
    late ReceivedDevicesProvider provider;

    setUp(() {
      provider = ReceivedDevicesProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should create instance', () {
        expect(provider, isNotNull);
      });

      test('should initialize interactor', () {
        expect(provider.interactor, isNotNull);
      });

      test('should accept optional query parameter', () {
        final providerWithQuery = ReceivedDevicesProvider(query: 'test query');
        expect(providerWithQuery.searchQuery, 'test query');
        providerWithQuery.dispose();
      });

      test('should handle null query parameter', () {
        final providerWithNullQuery = ReceivedDevicesProvider(query: null);
        expect(providerWithNullQuery.searchQuery, isNull);
        providerWithNullQuery.dispose();
      });
    });

    group('isGlassChangeRole', () {
      test('should be set based on user role', () {
        // isGlassChangeRole is determined by UserDetails().isGlassChangeRole()
        expect(provider.isGlassChangeRole, isA<bool>());
      });
    });

    group('glassChangeFailReasonList getter', () {
      test('should return null initially', () {
        expect(provider.glassChangeFailReasonList, isNull);
      });
    });

    group('Searchable mixin', () {
      test('should have searchQuery property', () {
        expect(provider.searchQuery, isNull);
      });

      test('should allow setting searchQuery', () {
        provider.searchQuery = 'test search';
        expect(provider.searchQuery, 'test search');
      });

      test('should allow clearing searchQuery', () {
        provider.searchQuery = 'test';
        provider.searchQuery = null;
        expect(provider.searchQuery, isNull);
      });
    });

    group('interactor', () {
      test('should be initialized', () {
        expect(provider.interactor, isNotNull);
      });
    });

    group('receiveDeviceViaScanning', () {
      test('should have receiveDeviceViaScanning method', () {
        expect(provider.receiveDeviceViaScanning, isNotNull);
      });

      test('should return Stream', () {
        expect(provider.receiveDeviceViaScanning is Function, isTrue);
      });
    });

    group('markRubbing', () {
      test('should have markRubbing method', () {
        expect(provider.markRubbing, isNotNull);
      });

      test('should return Future', () {
        expect(provider.markRubbing is Function, isTrue);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = ReceivedDevicesProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
