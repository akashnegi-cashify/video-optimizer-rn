import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/gaurd/models/collected_order_list_response.dart';

/// Tests for CollectedOrderListResponse and CollectedOrderListData models.
/// Focus: Testing JsonSerializable fromJson/toJson with nested list objects.
void main() {
  group('CollectedOrderListResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly with complete data', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'col': [
            {
              'an': 'John Doe',
              'tm': 1706520000000,
              'dc': 5,
              'un': 'admin_user',
              'fn': 'Warehouse A',
              'im': 'https://example.com/image.png',
            },
            {
              'an': 'Jane Smith',
              'tm': 1706606400000,
              'dc': 10,
              'un': 'super_user',
              'fn': 'Warehouse B',
              'im': 'https://example.com/image2.png',
            },
          ],
          'anl': ['Agent 1', 'Agent 2', 'Agent 3'],
        };

        // Act
        final response = CollectedOrderListResponse.fromJson(json);

        // Assert
        expect(response.collectedOrderList, isNotNull);
        expect(response.collectedOrderList!.length, 2);
        expect(response.deliveryAgentList, isNotNull);
        expect(response.deliveryAgentList!.length, 3);
        expect(response.trackUrl, 'https://example.com/track');
        expect(response.cashifyAlert, null);

        // Check first item
        final firstItem = response.collectedOrderList![0];
        expect(firstItem.deliveryAgentName, 'John Doe');
        expect(firstItem.time, 1706520000000);
        expect(firstItem.quantity, 5);
        expect(firstItem.entryByUserName, 'admin_user');
        expect(firstItem.facilityName, 'Warehouse A');
        expect(firstItem.imgUrl, 'https://example.com/image.png');
      });

      test('should handle null collectedOrderList', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': 'https://track.com',
          'col': null,
          'anl': ['Agent 1'],
        };

        // Act
        final response = CollectedOrderListResponse.fromJson(json);

        // Assert
        expect(response.collectedOrderList, null);
        expect(response.deliveryAgentList!.length, 1);
      });

      test('should handle empty collectedOrderList', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': null,
          'col': [],
          'anl': [],
        };

        // Act
        final response = CollectedOrderListResponse.fromJson(json);

        // Assert
        expect(response.collectedOrderList, isNotNull);
        expect(response.collectedOrderList!.isEmpty, true);
        expect(response.deliveryAgentList!.isEmpty, true);
      });

      test('should handle null deliveryAgentList', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': null,
          'col': [],
          'anl': null,
        };

        // Act
        final response = CollectedOrderListResponse.fromJson(json);

        // Assert
        expect(response.deliveryAgentList, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{
          '__ca': null,
          'turl': null,
        };

        // Act
        final response = CollectedOrderListResponse.fromJson(json);

        // Assert
        expect(response.collectedOrderList, null);
        expect(response.deliveryAgentList, null);
      });

      test('should handle empty JSON', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = CollectedOrderListResponse.fromJson(json);

        // Assert
        expect(response.collectedOrderList, null);
        expect(response.deliveryAgentList, null);
        expect(response.cashifyAlert, null);
        expect(response.trackUrl, null);
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Info',
            'msg': 'Order list loaded successfully',
          },
          'turl': null,
          'col': [],
          'anl': [],
        };

        // Act
        final response = CollectedOrderListResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
      });

      test('should handle list with partial data items', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'col': [
            {
              'an': 'Partial Agent',
            },
          ],
          'anl': [],
        };

        // Act
        final response = CollectedOrderListResponse.fromJson(json);

        // Assert
        expect(response.collectedOrderList!.length, 1);
        expect(response.collectedOrderList![0].deliveryAgentName, 'Partial Agent');
        expect(response.collectedOrderList![0].time, null);
        expect(response.collectedOrderList![0].quantity, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final response = CollectedOrderListResponse.fromJson({
          '__ca': null,
          'turl': 'https://track.com',
          'col': [
            {
              'an': 'Test Agent',
              'tm': 1706520000000,
              'dc': 3,
              'un': 'test_user',
              'fn': 'Test Facility',
              'im': 'https://example.com/test.png',
            },
          ],
          'anl': ['Agent A', 'Agent B'],
        });

        // Act
        final json = response.toJson();

        // Assert
        expect(json['turl'], 'https://track.com');
        expect(json['anl'], ['Agent A', 'Agent B']);
        expect(json['col'], isNotNull);
        expect((json['col'] as List).length, 1);
      });

      test('should handle null lists in serialization', () {
        // Arrange
        final response = CollectedOrderListResponse(null, null, null, 'https://track.com');

        // Act
        final json = response.toJson();

        // Assert
        expect(json['col'], null);
        expect(json['anl'], null);
        expect(json['turl'], 'https://track.com');
      });

      test('should handle empty lists in serialization', () {
        // Arrange
        final response = CollectedOrderListResponse([], [], null, null);

        // Act
        final json = response.toJson();

        // Assert
        expect((json['col'] as List).isEmpty, true);
        expect((json['anl'] as List).isEmpty, true);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'col': [
            {
              'an': 'Round Trip Agent',
              'tm': 1706520000000,
              'dc': 7,
              'un': 'round_user',
              'fn': 'Round Facility',
              'im': 'https://example.com/round.png',
            },
          ],
          'anl': ['Agent X', 'Agent Y'],
        };

        // Act
        final response = CollectedOrderListResponse.fromJson(originalJson);
        final serializedJson = response.toJson();

        // Assert
        expect(serializedJson['turl'], originalJson['turl']);
        expect(serializedJson['anl'], originalJson['anl']);
        expect((serializedJson['col'] as List).length, 1);
      });
    });

    group('edge cases', () {
      test('should handle special characters in agent names', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'col': [
            {
              'an': 'John O\'Brien Jr.',
              'fn': 'Warehouse & Storage Co.',
            },
          ],
          'anl': ['Agent "A"', 'Agent <B>', 'Agent & Co.'],
        };

        // Act
        final response = CollectedOrderListResponse.fromJson(json);

        // Assert
        expect(response.collectedOrderList![0].deliveryAgentName, 'John O\'Brien Jr.');
        expect(response.collectedOrderList![0].facilityName, 'Warehouse & Storage Co.');
        expect(response.deliveryAgentList, ['Agent "A"', 'Agent <B>', 'Agent & Co.']);
      });

      test('should handle unicode characters', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'col': [
            {
              'an': '配达员 张三',
              'fn': 'मुंबई गोदाम',
            },
          ],
          'anl': ['エージェント1', 'Агент2'],
        };

        // Act
        final response = CollectedOrderListResponse.fromJson(json);

        // Assert
        expect(response.collectedOrderList![0].deliveryAgentName, '配达员 张三');
        expect(response.collectedOrderList![0].facilityName, 'मुंबई गोदाम');
        expect(response.deliveryAgentList, ['エージェント1', 'Агент2']);
      });

      test('should handle large quantity values', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'col': [
            {
              'an': 'Agent',
              'dc': 2147483647,
            },
          ],
          'anl': [],
        };

        // Act
        final response = CollectedOrderListResponse.fromJson(json);

        // Assert
        expect(response.collectedOrderList![0].quantity, 2147483647);
      });

      test('should handle zero values', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'col': [
            {
              'an': 'Agent',
              'tm': 0,
              'dc': 0,
            },
          ],
          'anl': [],
        };

        // Act
        final response = CollectedOrderListResponse.fromJson(json);

        // Assert
        expect(response.collectedOrderList![0].time, 0);
        expect(response.collectedOrderList![0].quantity, 0);
      });

      test('should handle empty strings', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': '',
          'col': [
            {
              'an': '',
              'un': '',
              'fn': '',
              'im': '',
            },
          ],
          'anl': [''],
        };

        // Act
        final response = CollectedOrderListResponse.fromJson(json);

        // Assert
        expect(response.trackUrl, '');
        expect(response.collectedOrderList![0].deliveryAgentName, '');
        expect(response.collectedOrderList![0].entryByUserName, '');
        expect(response.collectedOrderList![0].facilityName, '');
        expect(response.collectedOrderList![0].imgUrl, '');
        expect(response.deliveryAgentList, ['']);
      });

      test('should handle very long lists', () {
        // Arrange
        final items = List.generate(
          100,
          (index) => {
            'an': 'Agent $index',
            'dc': index,
          },
        );
        final agents = List.generate(50, (index) => 'Agent Name $index');

        final json = {
          '__ca': null,
          'turl': null,
          'col': items,
          'anl': agents,
        };

        // Act
        final response = CollectedOrderListResponse.fromJson(json);

        // Assert
        expect(response.collectedOrderList!.length, 100);
        expect(response.deliveryAgentList!.length, 50);
        expect(response.collectedOrderList![99].deliveryAgentName, 'Agent 99');
        expect(response.collectedOrderList![99].quantity, 99);
      });
    });

    group('constructor', () {
      test('should create instance with all parameters', () {
        // Arrange
        final items = [
          CollectedOrderListData(
            deliveryAgentName: 'Test Agent',
            time: 1706520000000,
            quantity: 5,
          ),
        ];
        final agents = ['Agent 1', 'Agent 2'];

        // Act
        final response = CollectedOrderListResponse(items, agents, null, 'https://track.com');

        // Assert
        expect(response.collectedOrderList!.length, 1);
        expect(response.deliveryAgentList!.length, 2);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should create instance with null parameters', () {
        // Act
        final response = CollectedOrderListResponse(null, null, null, null);

        // Assert
        expect(response.collectedOrderList, null);
        expect(response.deliveryAgentList, null);
        expect(response.trackUrl, null);
      });
    });
  });

  group('CollectedOrderListData', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          'an': 'Test Agent',
          'tm': 1706520000000,
          'dc': 10,
          'un': 'test_user',
          'fn': 'Test Facility',
          'im': 'https://example.com/image.png',
        };

        // Act
        final data = CollectedOrderListData.fromJson(json);

        // Assert
        expect(data.deliveryAgentName, 'Test Agent');
        expect(data.time, 1706520000000);
        expect(data.quantity, 10);
        expect(data.entryByUserName, 'test_user');
        expect(data.facilityName, 'Test Facility');
        expect(data.imgUrl, 'https://example.com/image.png');
      });

      test('should handle null fields', () {
        // Arrange
        final json = <String, dynamic>{
          'an': null,
          'tm': null,
          'dc': null,
          'un': null,
          'fn': null,
          'im': null,
        };

        // Act
        final data = CollectedOrderListData.fromJson(json);

        // Assert
        expect(data.deliveryAgentName, null);
        expect(data.time, null);
        expect(data.quantity, null);
        expect(data.entryByUserName, null);
        expect(data.facilityName, null);
        expect(data.imgUrl, null);
      });

      test('should handle missing fields', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final data = CollectedOrderListData.fromJson(json);

        // Assert
        expect(data.deliveryAgentName, null);
        expect(data.time, null);
        expect(data.quantity, null);
        expect(data.entryByUserName, null);
        expect(data.facilityName, null);
        expect(data.imgUrl, null);
      });

      test('should handle partial data', () {
        // Arrange
        final json = {
          'an': 'Partial Agent',
          'dc': 5,
        };

        // Act
        final data = CollectedOrderListData.fromJson(json);

        // Assert
        expect(data.deliveryAgentName, 'Partial Agent');
        expect(data.quantity, 5);
        expect(data.time, null);
        expect(data.entryByUserName, null);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final data = CollectedOrderListData(
          deliveryAgentName: 'Test Agent',
          time: 1706520000000,
          quantity: 15,
          entryByUserName: 'admin',
          facilityName: 'Main Warehouse',
          imgUrl: 'https://example.com/img.png',
        );

        // Act
        final json = data.toJson();

        // Assert
        expect(json['an'], 'Test Agent');
        expect(json['tm'], 1706520000000);
        expect(json['dc'], 15);
        expect(json['un'], 'admin');
        expect(json['fn'], 'Main Warehouse');
        expect(json['im'], 'https://example.com/img.png');
      });

      test('should handle null values in serialization', () {
        // Arrange
        final data = CollectedOrderListData();

        // Act
        final json = data.toJson();

        // Assert
        expect(json['an'], null);
        expect(json['tm'], null);
        expect(json['dc'], null);
        expect(json['un'], null);
        expect(json['fn'], null);
        expect(json['im'], null);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          'an': 'Round Trip Agent',
          'tm': 1706520000000,
          'dc': 25,
          'un': 'round_user',
          'fn': 'Round Facility',
          'im': 'https://example.com/round.png',
        };

        // Act
        final data = CollectedOrderListData.fromJson(originalJson);
        final serializedJson = data.toJson();

        // Assert
        expect(serializedJson['an'], originalJson['an']);
        expect(serializedJson['tm'], originalJson['tm']);
        expect(serializedJson['dc'], originalJson['dc']);
        expect(serializedJson['un'], originalJson['un']);
        expect(serializedJson['fn'], originalJson['fn']);
        expect(serializedJson['im'], originalJson['im']);
      });
    });

    group('constructor', () {
      test('should create instance with named parameters', () {
        // Act
        final data = CollectedOrderListData(
          deliveryAgentName: 'Named Agent',
          time: 1000000,
          quantity: 3,
          entryByUserName: 'user1',
          facilityName: 'Facility 1',
          imgUrl: 'https://img.com',
        );

        // Assert
        expect(data.deliveryAgentName, 'Named Agent');
        expect(data.time, 1000000);
        expect(data.quantity, 3);
        expect(data.entryByUserName, 'user1');
        expect(data.facilityName, 'Facility 1');
        expect(data.imgUrl, 'https://img.com');
      });

      test('should create instance with no parameters', () {
        // Act
        final data = CollectedOrderListData();

        // Assert
        expect(data.deliveryAgentName, null);
        expect(data.time, null);
        expect(data.quantity, null);
        expect(data.entryByUserName, null);
        expect(data.facilityName, null);
        expect(data.imgUrl, null);
      });

      test('should create instance with partial parameters', () {
        // Act
        final data = CollectedOrderListData(
          deliveryAgentName: 'Only Name',
          quantity: 1,
        );

        // Assert
        expect(data.deliveryAgentName, 'Only Name');
        expect(data.quantity, 1);
        expect(data.time, null);
      });
    });

    group('edge cases', () {
      test('should handle negative time values', () {
        // Arrange
        final json = {
          'an': 'Agent',
          'tm': -1,
        };

        // Act
        final data = CollectedOrderListData.fromJson(json);

        // Assert
        expect(data.time, -1);
      });

      test('should handle image URL with query parameters', () {
        // Arrange
        final json = {
          'an': 'Agent',
          'im': 'https://example.com/image.png?size=large&format=webp',
        };

        // Act
        final data = CollectedOrderListData.fromJson(json);

        // Assert
        expect(data.imgUrl, 'https://example.com/image.png?size=large&format=webp');
      });
    });
  });
}
