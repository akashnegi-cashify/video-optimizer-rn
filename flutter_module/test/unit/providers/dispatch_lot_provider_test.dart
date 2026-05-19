import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/providers/dispatch_lot_provider.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for DispatchLotProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('DispatchLotProvider', () {
    late DispatchLotProvider provider;

    setUp(() {
      provider = DispatchLotProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('initial state', () {
      test('showSearchBox should initially be false', () {
        expect(provider.showSearchBox, false);
      });

      test('lotType should initially be null', () {
        expect(provider.lotType, isNull);
      });

      test('searchQuery should initially be null', () {
        expect(provider.searchQuery, isNull);
      });
    });

    group('searchQuery setter', () {
      test('should update searchQuery value', () {
        provider.searchQuery = 'test query';
        expect(provider.searchQuery, 'test query');
      });

      test('should allow null searchQuery', () {
        provider.searchQuery = 'initial';
        provider.searchQuery = null;
        expect(provider.searchQuery, isNull);
      });

      test('should allow empty searchQuery', () {
        provider.searchQuery = '';
        expect(provider.searchQuery, '');
      });

      test('should handle special characters', () {
        provider.searchQuery = 'test@#\$%^&*()';
        expect(provider.searchQuery, 'test@#\$%^&*()');
      });

      test('should handle unicode characters', () {
        provider.searchQuery = '测试查询';
        expect(provider.searchQuery, '测试查询');
      });

      test('should notify listeners when set', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.searchQuery = 'test';

        expect(tracker.callCount, 1);
      });
    });

    group('lotType setter and getter', () {
      test('should update lotType value', () {
        provider.lotType = [1, 2, 3];
        expect(provider.lotType, [1, 2, 3]);
      });

      test('should allow null lotType', () {
        provider.lotType = [1];
        provider.lotType = null;
        expect(provider.lotType, isNull);
      });

      test('should allow empty lotType list', () {
        provider.lotType = [];
        expect(provider.lotType, isEmpty);
      });

      test('should handle single lotType', () {
        provider.lotType = [1];
        expect(provider.lotType?.length, 1);
        expect(provider.lotType?.first, 1);
      });

      test('should handle multiple lotTypes', () {
        provider.lotType = [1, 2, 3, 4, 5];
        expect(provider.lotType?.length, 5);
      });

      test('should notify listeners when set', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.lotType = [1, 2];

        expect(tracker.callCount, 1);
      });

      test('should broadcast to stream controller', () async {
        final receivedValues = <List<int>?>[];
        provider.controller.stream.listen((value) => receivedValues.add(value));

        provider.lotType = [1, 2];
        provider.lotType = [3, 4];
        provider.lotType = null;

        await Future.delayed(Duration.zero);

        expect(receivedValues.length, 3);
        expect(receivedValues[0], [1, 2]);
        expect(receivedValues[1], [3, 4]);
        expect(receivedValues[2], isNull);
      });
    });

    group('showSearchBox setter and getter', () {
      test('should toggle to true', () {
        provider.showSearchBox = true;
        expect(provider.showSearchBox, true);
      });

      test('should toggle back to false', () {
        provider.showSearchBox = true;
        provider.showSearchBox = false;
        expect(provider.showSearchBox, false);
      });

      test('should notify listeners when set', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.showSearchBox = true;

        expect(tracker.callCount, 1);
      });
    });

    group('stream controller', () {
      test('should be a broadcast stream', () async {
        final listener1Values = <List<int>?>[];
        final listener2Values = <List<int>?>[];

        provider.controller.stream.listen((value) => listener1Values.add(value));
        provider.controller.stream.listen((value) => listener2Values.add(value));

        provider.lotType = [1];
        await Future.delayed(Duration.zero);

        expect(listener1Values.length, 1);
        expect(listener2Values.length, 1);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = DispatchLotProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });

      test('should close stream controller', () async {
        final testProvider = DispatchLotProvider();
        testProvider.dispose();

        expect(testProvider.controller.isClosed, true);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(DispatchLotProvider.of, isNotNull);
      });
    });

    group('initiateDispatchCompletion method signature', () {
      test('should have initiateDispatchCompletion method', () {
        expect(provider.initiateDispatchCompletion, isNotNull);
      });
    });
  });
}
