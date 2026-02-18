import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/utils/parse_array.dart';

void main() {
  group('ParseArray', () {
    group('parseListItem', () {
      test('should parse empty list correctly', () {
        // Arrange
        final List<dynamic> emptyList = [];
        String fromJson(dynamic json) => json.toString();

        // Act
        final result = ParseArray.parseListItem<String>(emptyList, fromJson);

        // Assert
        expect(result, isEmpty);
        expect(result, isA<List<String>>());
      });

      test('should parse list of strings correctly', () {
        // Arrange
        final List<dynamic> stringList = ['hello', 'world', 'test'];
        String fromJson(dynamic json) => json.toString().toUpperCase();

        // Act
        final result = ParseArray.parseListItem<String>(stringList, fromJson);

        // Assert
        expect(result.length, 3);
        expect(result[0], 'HELLO');
        expect(result[1], 'WORLD');
        expect(result[2], 'TEST');
      });

      test('should parse list of integers correctly', () {
        // Arrange
        final List<dynamic> intList = [1, 2, 3, 4, 5];
        int fromJson(dynamic json) => (json as int) * 2;

        // Act
        final result = ParseArray.parseListItem<int>(intList, fromJson);

        // Assert
        expect(result.length, 5);
        expect(result, [2, 4, 6, 8, 10]);
      });

      test('should parse list of maps to custom objects', () {
        // Arrange
        final List<dynamic> mapList = [
          {'name': 'John', 'age': 30},
          {'name': 'Jane', 'age': 25},
        ];
        _TestPerson fromJson(dynamic json) => _TestPerson.fromJson(json);

        // Act
        final result = ParseArray.parseListItem<_TestPerson>(mapList, fromJson);

        // Assert
        expect(result.length, 2);
        expect(result[0].name, 'John');
        expect(result[0].age, 30);
        expect(result[1].name, 'Jane');
        expect(result[1].age, 25);
      });

      test('should handle single item list correctly', () {
        // Arrange
        final List<dynamic> singleItemList = [42];
        int fromJson(dynamic json) => json as int;

        // Act
        final result = ParseArray.parseListItem<int>(singleItemList, fromJson);

        // Assert
        expect(result.length, 1);
        expect(result[0], 42);
      });

      test('should maintain order of elements', () {
        // Arrange
        final List<dynamic> orderedList = [5, 3, 8, 1, 9];
        int fromJson(dynamic json) => json as int;

        // Act
        final result = ParseArray.parseListItem<int>(orderedList, fromJson);

        // Assert
        expect(result, [5, 3, 8, 1, 9]);
      });

      test('should handle list with null values when fromJson handles nulls', () {
        // Arrange
        final List<dynamic> listWithNulls = ['a', null, 'b'];
        String fromJson(dynamic json) => json?.toString() ?? 'NULL';

        // Act
        final result = ParseArray.parseListItem<String>(listWithNulls, fromJson);

        // Assert
        expect(result.length, 3);
        expect(result[0], 'a');
        expect(result[1], 'NULL');
        expect(result[2], 'b');
      });

      test('should handle large list correctly', () {
        // Arrange
        final List<dynamic> largeList = List.generate(1000, (index) => index);
        int fromJson(dynamic json) => json as int;

        // Act
        final result = ParseArray.parseListItem<int>(largeList, fromJson);

        // Assert
        expect(result.length, 1000);
        expect(result.first, 0);
        expect(result.last, 999);
      });

      test('should handle nested lists in map correctly', () {
        // Arrange
        final List<dynamic> nestedList = [
          {'values': [1, 2, 3]},
          {'values': [4, 5, 6]},
        ];
        List<int> fromJson(dynamic json) =>
            (json['values'] as List).cast<int>();

        // Act
        final result =
            ParseArray.parseListItem<List<int>>(nestedList, fromJson);

        // Assert
        expect(result.length, 2);
        expect(result[0], [1, 2, 3]);
        expect(result[1], [4, 5, 6]);
      });

      test('should handle mixed type list when fromJson converts properly', () {
        // Arrange
        final List<dynamic> mixedList = [1, 'two', 3.0, true];
        String fromJson(dynamic json) => json.toString();

        // Act
        final result = ParseArray.parseListItem<String>(mixedList, fromJson);

        // Assert
        expect(result.length, 4);
        expect(result[0], '1');
        expect(result[1], 'two');
        expect(result[2], '3.0');
        expect(result[3], 'true');
      });

      test('should apply transformation correctly with complex fromJson', () {
        // Arrange
        final List<dynamic> dataList = [
          {'id': 1, 'value': 10},
          {'id': 2, 'value': 20},
          {'id': 3, 'value': 30},
        ];
        _ComputedValue fromJson(dynamic json) {
          final map = json as Map<String, dynamic>;
          return _ComputedValue(
            id: map['id'] as int,
            computedValue: (map['id'] as int) * (map['value'] as int),
          );
        }

        // Act
        final result =
            ParseArray.parseListItem<_ComputedValue>(dataList, fromJson);

        // Assert
        expect(result.length, 3);
        expect(result[0].id, 1);
        expect(result[0].computedValue, 10);
        expect(result[1].id, 2);
        expect(result[1].computedValue, 40);
        expect(result[2].id, 3);
        expect(result[2].computedValue, 90);
      });

      test('should return correct generic type', () {
        // Arrange
        final List<dynamic> doubleList = [1.1, 2.2, 3.3];
        double fromJson(dynamic json) => json as double;

        // Act
        final result = ParseArray.parseListItem<double>(doubleList, fromJson);

        // Assert
        expect(result, isA<List<double>>());
        expect(result[0], isA<double>());
      });
    });
  });
}

/// Test helper class for testing object parsing
class _TestPerson {
  final String name;
  final int age;

  _TestPerson({required this.name, required this.age});

  factory _TestPerson.fromJson(Map<String, dynamic> json) {
    return _TestPerson(
      name: json['name'] as String,
      age: json['age'] as int,
    );
  }
}

/// Test helper class for testing computed values
class _ComputedValue {
  final int id;
  final int computedValue;

  _ComputedValue({required this.id, required this.computedValue});
}
