import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/gaurd/models/add_agent_comp_param.dart';

void main() {
  group('AddAgentCompParam', () {
    group('constructor', () {
      test('should create instance with all parameters', () {
        // Act
        final param = AddAgentCompParam(
          agentList: ['Agent1', 'Agent2', 'Agent3'],
          header: 'Select Agent',
        );

        // Assert
        expect(param.agentList, ['Agent1', 'Agent2', 'Agent3']);
        expect(param.header, 'Select Agent');
      });

      test('should create instance with no parameters', () {
        // Act
        final param = AddAgentCompParam();

        // Assert
        expect(param.agentList, isNull);
        expect(param.header, isNull);
      });

      test('should create instance with only agentList', () {
        // Act
        final param = AddAgentCompParam(
          agentList: ['Agent1'],
        );

        // Assert
        expect(param.agentList, ['Agent1']);
        expect(param.header, isNull);
      });

      test('should create instance with only header', () {
        // Act
        final param = AddAgentCompParam(
          header: 'Header Only',
        );

        // Assert
        expect(param.agentList, isNull);
        expect(param.header, 'Header Only');
      });
    });

    group('agentList property', () {
      test('should handle empty agent list', () {
        // Act
        final param = AddAgentCompParam(
          agentList: [],
        );

        // Assert
        expect(param.agentList, isNotNull);
        expect(param.agentList!.isEmpty, true);
      });

      test('should handle single agent in list', () {
        // Act
        final param = AddAgentCompParam(
          agentList: ['SingleAgent'],
        );

        // Assert
        expect(param.agentList!.length, 1);
        expect(param.agentList![0], 'SingleAgent');
      });

      test('should handle many agents in list', () {
        // Arrange
        final manyAgents = List.generate(100, (i) => 'Agent$i');

        // Act
        final param = AddAgentCompParam(
          agentList: manyAgents,
        );

        // Assert
        expect(param.agentList!.length, 100);
        expect(param.agentList![0], 'Agent0');
        expect(param.agentList![99], 'Agent99');
      });

      test('should handle agent list with duplicates', () {
        // Act
        final param = AddAgentCompParam(
          agentList: ['Agent1', 'Agent1', 'Agent2'],
        );

        // Assert
        expect(param.agentList!.length, 3);
        expect(param.agentList!.where((a) => a == 'Agent1').length, 2);
      });

      test('should handle agent list with empty strings', () {
        // Act
        final param = AddAgentCompParam(
          agentList: ['', 'Agent1', ''],
        );

        // Assert
        expect(param.agentList!.length, 3);
        expect(param.agentList![0], '');
        expect(param.agentList![1], 'Agent1');
      });
    });

    group('header property', () {
      test('should handle empty header string', () {
        // Act
        final param = AddAgentCompParam(
          header: '',
        );

        // Assert
        expect(param.header, '');
      });

      test('should handle header with special characters', () {
        // Act
        final param = AddAgentCompParam(
          header: 'Select Agent !@#\$%^&*()',
        );

        // Assert
        expect(param.header, 'Select Agent !@#\$%^&*()');
      });

      test('should handle header with unicode characters', () {
        // Act
        final param = AddAgentCompParam(
          header: 'एजेंट चुनें',
        );

        // Assert
        expect(param.header, 'एजेंट चुनें');
      });

      test('should handle header with whitespace', () {
        // Act
        final param = AddAgentCompParam(
          header: '  Header with spaces  ',
        );

        // Assert
        expect(param.header, '  Header with spaces  ');
      });

      test('should handle long header string', () {
        // Arrange
        final longHeader = 'A' * 500;

        // Act
        final param = AddAgentCompParam(
          header: longHeader,
        );

        // Assert
        expect(param.header!.length, 500);
      });
    });

    group('typical usage scenarios', () {
      test('should create param for delivery agent selection', () {
        // Arrange & Act
        final param = AddAgentCompParam(
          agentList: ['FedEx', 'DHL', 'BlueDart', 'DTDC'],
          header: 'Select Delivery Agent',
        );

        // Assert
        expect(param.header, 'Select Delivery Agent');
        expect(param.agentList!.length, 4);
        expect(param.agentList!.contains('FedEx'), true);
      });

      test('should create param for courier selection', () {
        // Arrange & Act
        final param = AddAgentCompParam(
          agentList: ['Courier A', 'Courier B'],
          header: 'Choose Courier Partner',
        );

        // Assert
        expect(param.header, 'Choose Courier Partner');
        expect(param.agentList!.length, 2);
      });

      test('should create param with no predefined agents', () {
        // Arrange & Act
        final param = AddAgentCompParam(
          agentList: [],
          header: 'No Agents Available',
        );

        // Assert
        expect(param.header, 'No Agents Available');
        expect(param.agentList!.isEmpty, true);
      });
    });

    group('edge cases', () {
      test('should handle agent names with special characters', () {
        // Act
        final param = AddAgentCompParam(
          agentList: ['Agent-001', 'Agent_002', 'Agent/003'],
        );

        // Assert
        expect(param.agentList!.length, 3);
      });

      test('should handle agent names with numbers', () {
        // Act
        final param = AddAgentCompParam(
          agentList: ['123', '456', '789'],
        );

        // Assert
        expect(param.agentList!.length, 3);
      });

      test('should handle agent names with unicode', () {
        // Act
        final param = AddAgentCompParam(
          agentList: ['एजेंट1', 'エージェント2', '代理人3'],
        );

        // Assert
        expect(param.agentList!.length, 3);
      });

      test('should handle header with newlines', () {
        // Act
        final param = AddAgentCompParam(
          header: 'Line 1\nLine 2',
        );

        // Assert
        expect(param.header, 'Line 1\nLine 2');
      });
    });
  });

  group('AddAgentCompParamKeys', () {
    test('header should have value "h"', () {
      expect(AddAgentCompParamKeys.header.value, 'h');
    });

    test('agentList should have value "al"', () {
      expect(AddAgentCompParamKeys.agentList.value, 'al');
    });

    test('should have exactly 2 keys', () {
      expect(AddAgentCompParamKeys.values.length, 2);
    });

    group('enum names', () {
      test('header should have correct name', () {
        expect(AddAgentCompParamKeys.header.name, 'header');
      });

      test('agentList should have correct name', () {
        expect(AddAgentCompParamKeys.agentList.name, 'agentList');
      });
    });

    group('enum order', () {
      test('values should be in expected order', () {
        final values = AddAgentCompParamKeys.values;
        expect(values[0], AddAgentCompParamKeys.header);
        expect(values[1], AddAgentCompParamKeys.agentList);
      });
    });

    group('enum indices', () {
      test('header should have index 0', () {
        expect(AddAgentCompParamKeys.header.index, 0);
      });

      test('agentList should have index 1', () {
        expect(AddAgentCompParamKeys.agentList.index, 1);
      });
    });

    group('typical usage', () {
      test('should support map as key', () {
        final map = {
          AddAgentCompParamKeys.header: 'Select Agent',
          AddAgentCompParamKeys.agentList: ['Agent1', 'Agent2'],
        };
        expect(map[AddAgentCompParamKeys.header], 'Select Agent');
        expect(map[AddAgentCompParamKeys.agentList], ['Agent1', 'Agent2']);
      });

      test('should iterate over all values', () {
        var count = 0;
        for (final key in AddAgentCompParamKeys.values) {
          count++;
          expect(key, isA<AddAgentCompParamKeys>());
        }
        expect(count, 2);
      });
    });
  });
}
