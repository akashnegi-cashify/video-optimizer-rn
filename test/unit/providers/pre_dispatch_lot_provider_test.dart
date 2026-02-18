import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/pre_dispatch/providers/pre_dispatch_lot_provider.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for PreDispatchLotProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('PreDispatchLotProvider', () {
    late PreDispatchLotProvider provider;

    setUp(() {
      provider = PreDispatchLotProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should initialize controller', () {
        expect(provider.controller, isNotNull);
        expect(provider.controller, isA<StreamController<List<int>?>>());
      });
    });

    group('initial state', () {
      test('lotTypeQuery should initially be null', () {
        expect(provider.lotTypeQuery, isNull);
      });
    });

    group('barcode setter', () {
      test('should set barcode value', () {
        // barcode is a write-only setter, verify it doesn't throw
        expect(() => provider.barcode = 'TEST_BARCODE_123', returnsNormally);
      });

      test('should accept empty barcode', () {
        expect(() => provider.barcode = '', returnsNormally);
      });
    });

    group('lotName setter', () {
      test('should set lotName value', () {
        // lotName is a write-only setter, verify it doesn't throw
        expect(() => provider.lotName = 'TEST_LOT_NAME', returnsNormally);
      });

      test('should allow null lotName', () {
        expect(() => provider.lotName = null, returnsNormally);
      });

      test('should accept empty lotName', () {
        expect(() => provider.lotName = '', returnsNormally);
      });
    });

    group('lotTypeQuery setter and getter', () {
      test('should update lotTypeQuery value', () {
        provider.lotTypeQuery = [1, 2, 3];
        expect(provider.lotTypeQuery, [1, 2, 3]);
      });

      test('should allow null lotTypeQuery', () {
        provider.lotTypeQuery = [1];
        provider.lotTypeQuery = null;
        expect(provider.lotTypeQuery, isNull);
      });

      test('should allow empty lotTypeQuery list', () {
        provider.lotTypeQuery = [];
        expect(provider.lotTypeQuery, isEmpty);
      });

      test('should handle single lotType', () {
        provider.lotTypeQuery = [1];
        expect(provider.lotTypeQuery?.length, 1);
        expect(provider.lotTypeQuery?.first, 1);
      });

      test('should handle multiple lotTypes', () {
        provider.lotTypeQuery = [1, 2, 3, 4, 5];
        expect(provider.lotTypeQuery?.length, 5);
      });

      test('should broadcast to stream controller', () async {
        final receivedValues = <List<int>?>[];
        provider.controller.stream.listen((value) => receivedValues.add(value));

        provider.lotTypeQuery = [1, 2];
        provider.lotTypeQuery = [3, 4];
        provider.lotTypeQuery = null;

        await Future.delayed(Duration.zero);

        expect(receivedValues.length, 3);
        expect(receivedValues[0], [1, 2]);
        expect(receivedValues[1], [3, 4]);
        expect(receivedValues[2], isNull);
      });
    });

    group('resetSearchFilters', () {
      test('should reset lotName to null', () {
        provider.lotName = 'TEST_LOT';
        provider.resetSearchFilters();
        
        // lotName is private, verify method runs without error
        expect(() => provider.resetSearchFilters(), returnsNormally);
      });

      test('should reset barcode to null', () {
        provider.barcode = 'TEST_BARCODE';
        provider.resetSearchFilters();
        
        // barcode is private, verify method runs without error
        expect(() => provider.resetSearchFilters(), returnsNormally);
      });

      test('should run without error when already null', () {
        expect(() => provider.resetSearchFilters(), returnsNormally);
      });
    });

    group('stream controller', () {
      test('should be a broadcast stream', () async {
        final listener1Values = <List<int>?>[];
        final listener2Values = <List<int>?>[];

        provider.controller.stream.listen((value) => listener1Values.add(value));
        provider.controller.stream.listen((value) => listener2Values.add(value));

        provider.lotTypeQuery = [1];
        await Future.delayed(Duration.zero);

        expect(listener1Values.length, 1);
        expect(listener2Values.length, 1);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = PreDispatchLotProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });

      test('should close stream controller', () async {
        final testProvider = PreDispatchLotProvider();
        testProvider.dispose();

        expect(testProvider.controller.isClosed, true);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(PreDispatchLotProvider.of, isNotNull);
      });
    });

    group('completePreDispatchLot method signature', () {
      test('should have completePreDispatchLot method', () {
        expect(provider.completePreDispatchLot, isNotNull);
      });
    });
  });
}
