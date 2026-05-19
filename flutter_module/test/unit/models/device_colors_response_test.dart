import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/device_colors_response.dart';

/// Tests for DeviceColorResponse model.
/// Focus: Testing fromJson/toJson for device colors response with color lists.
void main() {
  group('DeviceColorResponse', () {
    group('fromJson', () {
      test('should parse all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'color': ['Black', 'White', 'Blue', 'Red'],
          'strapColor': ['Black', 'Silver', 'Gold'],
        };

        // Act
        final response = DeviceColorResponse.fromJson(json);

        // Assert
        expect(response.deviceColorList, isNotNull);
        expect(response.deviceColorList!.length, 4);
        expect(response.deviceColorList![0], 'Black');
        expect(response.strapColorList, isNotNull);
        expect(response.strapColorList!.length, 3);
        expect(response.strapColorList![0], 'Black');
        expect(response.trackUrl, 'https://example.com/track');
      });

      test('should handle null color lists', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': null,
          'color': null,
          'strapColor': null,
        };

        // Act
        final response = DeviceColorResponse.fromJson(json);

        // Assert
        expect(response.deviceColorList, null);
        expect(response.strapColorList, null);
      });

      test('should handle empty color lists', () {
        // Arrange
        final json = {
          'color': <String>[],
          'strapColor': <String>[],
        };

        // Act
        final response = DeviceColorResponse.fromJson(json);

        // Assert
        expect(response.deviceColorList, isNotNull);
        expect(response.deviceColorList!.isEmpty, true);
        expect(response.strapColorList, isNotNull);
        expect(response.strapColorList!.isEmpty, true);
      });

      test('should handle only deviceColorList present', () {
        // Arrange
        final json = {
          'color': ['Black', 'White'],
          'strapColor': null,
        };

        // Act
        final response = DeviceColorResponse.fromJson(json);

        // Assert
        expect(response.deviceColorList, isNotNull);
        expect(response.deviceColorList!.length, 2);
        expect(response.strapColorList, null);
      });

      test('should handle only strapColorList present', () {
        // Arrange
        final json = {
          'color': null,
          'strapColor': ['Silver', 'Gold'],
        };

        // Act
        final response = DeviceColorResponse.fromJson(json);

        // Assert
        expect(response.deviceColorList, null);
        expect(response.strapColorList, isNotNull);
        expect(response.strapColorList!.length, 2);
      });

      test('should parse CashifyAlert when present', () {
        // Arrange
        final json = {
          '__ca': {
            't': 'Alert Title',
            'msg': 'Alert Message',
          },
          'turl': 'https://track.com',
          'color': null,
          'strapColor': null,
        };

        // Act
        final response = DeviceColorResponse.fromJson(json);

        // Assert
        expect(response.cashifyAlert, isNotNull);
        expect(response.trackUrl, 'https://track.com');
      });

      test('should handle missing fields gracefully', () {
        // Arrange
        final json = <String, dynamic>{};

        // Act
        final response = DeviceColorResponse.fromJson(json);

        // Assert
        expect(response.deviceColorList, null);
        expect(response.strapColorList, null);
      });

      test('should handle single color in each list', () {
        // Arrange
        final json = {
          'color': ['Space Gray'],
          'strapColor': ['Midnight'],
        };

        // Act
        final response = DeviceColorResponse.fromJson(json);

        // Assert
        expect(response.deviceColorList!.length, 1);
        expect(response.deviceColorList![0], 'Space Gray');
        expect(response.strapColorList!.length, 1);
        expect(response.strapColorList![0], 'Midnight');
      });

      test('should handle many colors', () {
        // Arrange
        final colors = List.generate(50, (i) => 'Color$i');
        final strapColors = List.generate(30, (i) => 'Strap$i');
        final json = {
          'color': colors,
          'strapColor': strapColors,
        };

        // Act
        final response = DeviceColorResponse.fromJson(json);

        // Assert
        expect(response.deviceColorList!.length, 50);
        expect(response.strapColorList!.length, 30);
      });
    });

    group('toJson', () {
      test('should serialize all fields correctly', () {
        // Arrange
        final json = {
          '__ca': null,
          'turl': 'https://example.com/track',
          'color': ['Black', 'White', 'Blue'],
          'strapColor': ['Silver', 'Gold'],
        };
        final response = DeviceColorResponse.fromJson(json);

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['color'], isNotNull);
        expect((serialized['color'] as List).length, 3);
        expect(serialized['strapColor'], isNotNull);
        expect((serialized['strapColor'] as List).length, 2);
        expect(serialized['turl'], 'https://example.com/track');
      });

      test('should handle null values in serialization', () {
        // Arrange
        final response = DeviceColorResponse.fromJson({
          '__ca': null,
          'turl': null,
          'color': null,
          'strapColor': null,
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['color'], null);
        expect(serialized['strapColor'], null);
      });

      test('should serialize empty lists', () {
        // Arrange
        final response = DeviceColorResponse.fromJson({
          'color': <String>[],
          'strapColor': <String>[],
        });

        // Act
        final serialized = response.toJson();

        // Assert
        expect(serialized['color'], isNotNull);
        expect((serialized['color'] as List).isEmpty, true);
        expect(serialized['strapColor'], isNotNull);
        expect((serialized['strapColor'] as List).isEmpty, true);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through parse and serialize cycle', () {
        // Arrange
        final originalJson = {
          '__ca': null,
          'turl': 'https://example.com',
          'color': ['Black', 'White', 'Silver', 'Gold'],
          'strapColor': ['Navy', 'Burgundy', 'Forest Green'],
        };

        // Act
        final response = DeviceColorResponse.fromJson(originalJson);
        final serialized = response.toJson();

        // Assert
        expect(serialized['turl'], 'https://example.com');
        final colorList = serialized['color'] as List;
        expect(colorList.length, 4);
        expect(colorList[0], 'Black');
        expect(colorList[3], 'Gold');
        final strapColorList = serialized['strapColor'] as List;
        expect(strapColorList.length, 3);
        expect(strapColorList[0], 'Navy');
        expect(strapColorList[2], 'Forest Green');
      });
    });

    group('edge cases', () {
      test('should handle empty string colors', () {
        // Arrange
        final json = {
          'color': ['Black', '', 'White'],
          'strapColor': ['', 'Silver'],
        };

        // Act
        final response = DeviceColorResponse.fromJson(json);

        // Assert
        expect(response.deviceColorList!.length, 3);
        expect(response.deviceColorList![1], '');
        expect(response.strapColorList![0], '');
      });

      test('should handle whitespace-only colors', () {
        // Arrange
        final json = {
          'color': ['Black', '   ', 'White'],
        };

        // Act
        final response = DeviceColorResponse.fromJson(json);

        // Assert
        expect(response.deviceColorList![1], '   ');
      });

      test('should handle special characters in color names', () {
        // Arrange
        final json = {
          'color': ['Space Gray', 'Pacific Blue', 'Rose Gold (2024)'],
          'strapColor': ['Midnight/Silver'],
        };

        // Act
        final response = DeviceColorResponse.fromJson(json);

        // Assert
        expect(response.deviceColorList![2], 'Rose Gold (2024)');
        expect(response.strapColorList![0], 'Midnight/Silver');
      });

      test('should handle unicode color names', () {
        // Arrange
        final json = {
          'color': ['काला', '白色', 'Bleu'],
          'strapColor': ['金色'],
        };

        // Act
        final response = DeviceColorResponse.fromJson(json);

        // Assert
        expect(response.deviceColorList![0], 'काला');
        expect(response.deviceColorList![1], '白色');
        expect(response.deviceColorList![2], 'Bleu');
        expect(response.strapColorList![0], '金色');
      });

      test('should handle duplicate colors', () {
        // Arrange
        final json = {
          'color': ['Black', 'White', 'Black', 'Black'],
        };

        // Act
        final response = DeviceColorResponse.fromJson(json);

        // Assert
        expect(response.deviceColorList!.length, 4);
        expect(response.deviceColorList!.where((c) => c == 'Black').length, 3);
      });

      test('should handle long color names', () {
        // Arrange
        final longColorName = 'A' * 200;
        final json = {
          'color': [longColorName],
        };

        // Act
        final response = DeviceColorResponse.fromJson(json);

        // Assert
        expect(response.deviceColorList![0].length, 200);
      });

      test('should handle color codes', () {
        // Arrange
        final json = {
          'color': ['#000000', '#FFFFFF', '#FF5733', 'rgb(255, 0, 0)'],
        };

        // Act
        final response = DeviceColorResponse.fromJson(json);

        // Assert
        expect(response.deviceColorList![0], '#000000');
        expect(response.deviceColorList![1], '#FFFFFF');
        expect(response.deviceColorList![2], '#FF5733');
        expect(response.deviceColorList![3], 'rgb(255, 0, 0)');
      });

      test('should handle mixed case color names', () {
        // Arrange
        final json = {
          'color': ['black', 'BLACK', 'Black', 'BlAcK'],
        };

        // Act
        final response = DeviceColorResponse.fromJson(json);

        // Assert
        expect(response.deviceColorList!.length, 4);
        expect(response.deviceColorList![0], 'black');
        expect(response.deviceColorList![1], 'BLACK');
        expect(response.deviceColorList![2], 'Black');
        expect(response.deviceColorList![3], 'BlAcK');
      });
    });
  });
}
