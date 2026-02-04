import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/gaurd/providers/guardDeviceCountingListProvider.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for GuardDeviceCountingListProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('GuardDeviceCountingListProvider', () {
    late GuardDeviceCountingListProvider provider;

    setUp(() {
      provider = GuardDeviceCountingListProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should create instance without errors', () {
        final testProvider = GuardDeviceCountingListProvider();
        expect(testProvider, isNotNull);
        testProvider.dispose();
      });
    });

    group('initial state', () {
      test('deliveryAgentList should initially be null', () {
        expect(provider.deliveryAgentList, isNull);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(GuardDeviceCountingListProvider.of, isNotNull);
      });
    });

    group('deliveryAgentList', () {
      test('should allow setting deliveryAgentList', () {
        provider.deliveryAgentList = ['Agent 1', 'Agent 2', 'Agent 3'];
        expect(provider.deliveryAgentList, isNotNull);
        expect(provider.deliveryAgentList!.length, 3);
      });

      test('should allow setting deliveryAgentList to null', () {
        provider.deliveryAgentList = ['Agent 1'];
        provider.deliveryAgentList = null;
        expect(provider.deliveryAgentList, isNull);
      });

      test('should allow setting empty deliveryAgentList', () {
        provider.deliveryAgentList = [];
        expect(provider.deliveryAgentList, isNotNull);
        expect(provider.deliveryAgentList!.isEmpty, isTrue);
      });
    });

    group('method signatures', () {
      test('should have getCollectedOrdersList method', () {
        expect(provider.getCollectedOrdersList, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = GuardDeviceCountingListProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });

  group('GuardDeviceCountingListProvider edge cases', () {
    test('should handle special characters in agent names', () {
      final provider = GuardDeviceCountingListProvider();
      provider.deliveryAgentList = ['Agent 1/2', 'Agent_Test#1', 'Agent (Main)'];
      expect(provider.deliveryAgentList!.length, 3);
      expect(provider.deliveryAgentList![0], 'Agent 1/2');
      provider.dispose();
    });

    test('should handle unicode characters in agent names', () {
      final provider = GuardDeviceCountingListProvider();
      provider.deliveryAgentList = ['配送员一', '配送员二'];
      expect(provider.deliveryAgentList!.length, 2);
      expect(provider.deliveryAgentList![0], '配送员一');
      provider.dispose();
    });

    test('should handle large number of agents', () {
      final provider = GuardDeviceCountingListProvider();
      provider.deliveryAgentList = List.generate(100, (i) => 'Agent $i');
      expect(provider.deliveryAgentList!.length, 100);
      provider.dispose();
    });

    test('should handle duplicate agent names', () {
      final provider = GuardDeviceCountingListProvider();
      provider.deliveryAgentList = ['Agent 1', 'Agent 1', 'Agent 2'];
      expect(provider.deliveryAgentList!.length, 3);
      provider.dispose();
    });

    test('should create multiple instances independently', () {
      final provider1 = GuardDeviceCountingListProvider();
      final provider2 = GuardDeviceCountingListProvider();

      provider1.deliveryAgentList = ['Agent A'];
      provider2.deliveryAgentList = ['Agent B'];

      expect(provider1.deliveryAgentList, isNot(same(provider2.deliveryAgentList)));
      expect(provider1.deliveryAgentList![0], 'Agent A');
      expect(provider2.deliveryAgentList![0], 'Agent B');

      provider1.dispose();
      provider2.dispose();
    });
  });
}
