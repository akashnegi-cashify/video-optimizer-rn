import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/gaurd/providers/qc_guard_add_agent_provider.dart';
import 'package:core_widgets/core_widgets.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for AddAgentProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('AddAgentProvider', () {
    late AddAgentProvider provider;

    setUp(() {
      provider = AddAgentProvider(['Agent 1', 'Agent 2', 'Agent 3']);
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should initialize with agent list', () {
        expect(provider.agentList, isNotNull);
        expect(provider.agentList.isNotEmpty, isTrue);
      });

      test('should prepend "Select Agent" to the list', () {
        // The constructor inserts "Select Agent" at index 0
        expect(provider.agentList.first.label, 'Select Agent');
      });

      test('should create dropdown items from agent list', () {
        // Original list: ['Agent 1', 'Agent 2', 'Agent 3']
        // After insert: ['Select Agent', 'Agent 1', 'Agent 2', 'Agent 3']
        expect(provider.agentList.length, 4);
      });

      test('should initialize textEditingController', () {
        expect(provider.textEditingController, isNotNull);
      });

      test('should handle empty agent list', () {
        final emptyProvider = AddAgentProvider([]);
        // After insert, list should have just "Select Agent"
        expect(emptyProvider.agentList.length, 1);
        expect(emptyProvider.agentList.first.label, 'Select Agent');
        emptyProvider.dispose();
      });

      test('should handle single agent list', () {
        final singleProvider = AddAgentProvider(['Single Agent']);
        expect(singleProvider.agentList.length, 2);
        expect(singleProvider.agentList[0].label, 'Select Agent');
        expect(singleProvider.agentList[1].label, 'Single Agent');
        singleProvider.dispose();
      });
    });

    group('agentList', () {
      test('should return list of DropDownItem', () {
        expect(provider.agentList, isA<List<DropDownItem<bool>>>());
      });

      test('should have extraData set to false initially for all items', () {
        for (final item in provider.agentList) {
          expect(item.extraData, isFalse);
        }
      });
    });

    group('selectedAgent', () {
      test('should return first item when none is selected', () {
        expect(provider.selectedAgent.label, 'Select Agent');
      });

      test('should return selected agent after selection', () {
        // Select the second agent (index 1 = Agent 1)
        provider.onAgentSelectionChange(provider.agentList[1]);
        expect(provider.selectedAgent.label, 'Agent 1');
      });
    });

    group('onAgentSelectionChange', () {
      test('should mark selected item as true', () {
        provider.onAgentSelectionChange(provider.agentList[1]);
        expect(provider.agentList[1].extraData, isTrue);
      });

      test('should deselect previous selection', () {
        provider.onAgentSelectionChange(provider.agentList[1]);
        provider.onAgentSelectionChange(provider.agentList[2]);

        expect(provider.agentList[1].extraData, isFalse);
        expect(provider.agentList[2].extraData, isTrue);
      });

      test('should notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.onAgentSelectionChange(provider.agentList[1]);

        expect(tracker.callCount, 1);
      });

      test('should handle multiple selection changes', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.onAgentSelectionChange(provider.agentList[1]);
        provider.onAgentSelectionChange(provider.agentList[2]);
        provider.onAgentSelectionChange(provider.agentList[3]);

        expect(tracker.callCount, 3);
        expect(provider.selectedAgent.label, 'Agent 3');
      });

      test('should handle selecting the same item again', () {
        provider.onAgentSelectionChange(provider.agentList[1]);
        provider.onAgentSelectionChange(provider.agentList[1]);

        // Item should still be selected
        expect(provider.selectedAgent.label, 'Agent 1');
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(AddAgentProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = AddAgentProvider(['Test Agent']);
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });

  group('AddAgentProvider edge cases', () {
    test('should handle special characters in agent names', () {
      final provider = AddAgentProvider(['Agent 1/2', 'Agent_Test#1', 'Agent (Main)']);
      expect(provider.agentList.length, 4);
      expect(provider.agentList[1].label, 'Agent 1/2');
      expect(provider.agentList[2].label, 'Agent_Test#1');
      expect(provider.agentList[3].label, 'Agent (Main)');
      provider.dispose();
    });

    test('should handle unicode characters in agent names', () {
      final provider = AddAgentProvider(['代理人一', '代理人二']);
      expect(provider.agentList.length, 3);
      expect(provider.agentList[1].label, '代理人一');
      expect(provider.agentList[2].label, '代理人二');
      provider.dispose();
    });

    test('should handle long agent names', () {
      final longName = 'A' * 500;
      final provider = AddAgentProvider([longName]);
      expect(provider.agentList[1].label?.length, 500);
      provider.dispose();
    });

    test('should handle large number of agents', () {
      final agents = List.generate(100, (i) => 'Agent $i');
      final provider = AddAgentProvider(agents);
      expect(provider.agentList.length, 101); // 100 + "Select Agent"
      provider.dispose();
    });

    test('should handle duplicate agent names', () {
      final provider = AddAgentProvider(['Agent 1', 'Agent 1', 'Agent 2']);
      expect(provider.agentList.length, 4);
      provider.dispose();
    });

    test('should handle empty string agent names', () {
      final provider = AddAgentProvider(['', 'Agent 1', '']);
      expect(provider.agentList.length, 4);
      expect(provider.agentList[1].label, '');
      provider.dispose();
    });
  });
}
