import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/libraries/analytics/cashify/resources/save_analytic_request.dart';

void main() {
  group('SaveAnalyticsRequest', () {
    group('constructor', () {
      test('should create instance with required parameters', () {
        // Arrange & Act
        final request = SaveAnalyticsRequest('event_key', 'subordinate_key');

        // Assert
        expect(request.eventKey, equals('event_key'));
        expect(request.subOrdinateEventKey, equals('subordinate_key'));
        expect(request.parameters, isNull);
      });

      test('should create instance with parameters', () {
        // Arrange
        final params = {'key': 'value', 'count': 10};

        // Act
        final request = SaveAnalyticsRequest(
          'event_key',
          'subordinate_key',
          parameters: params,
        );

        // Assert
        expect(request.eventKey, equals('event_key'));
        expect(request.subOrdinateEventKey, equals('subordinate_key'));
        expect(request.parameters, equals(params));
      });

      test('should allow null event key', () {
        // Arrange & Act
        final request = SaveAnalyticsRequest(null, 'subordinate_key');

        // Assert
        expect(request.eventKey, isNull);
        expect(request.subOrdinateEventKey, equals('subordinate_key'));
      });

      test('should allow null subordinate key', () {
        // Arrange & Act
        final request = SaveAnalyticsRequest('event_key', null);

        // Assert
        expect(request.eventKey, equals('event_key'));
        expect(request.subOrdinateEventKey, isNull);
      });
    });

    group('fromJson', () {
      test('should parse JSON with all fields', () {
        // Arrange
        final json = {
          'ekey': 'event_key',
          'sokey': 'subordinate_key',
          'pldata': {'key': 'value'},
        };

        // Act
        final request = SaveAnalyticsRequest.fromJson(json);

        // Assert
        expect(request.eventKey, equals('event_key'));
        expect(request.subOrdinateEventKey, equals('subordinate_key'));
        expect(request.parameters, equals({'key': 'value'}));
      });

      test('should parse JSON with missing optional fields', () {
        // Arrange
        final json = {
          'ekey': 'event_key',
          'sokey': 'subordinate_key',
        };

        // Act
        final request = SaveAnalyticsRequest.fromJson(json);

        // Assert
        expect(request.eventKey, equals('event_key'));
        expect(request.subOrdinateEventKey, equals('subordinate_key'));
        expect(request.parameters, isNull);
      });

      test('should parse JSON with null values', () {
        // Arrange
        final json = <String, dynamic>{
          'ekey': null,
          'sokey': null,
          'pldata': null,
        };

        // Act
        final request = SaveAnalyticsRequest.fromJson(json);

        // Assert
        expect(request.eventKey, isNull);
        expect(request.subOrdinateEventKey, isNull);
        expect(request.parameters, isNull);
      });

      test('should parse JSON with complex parameters', () {
        // Arrange
        final json = {
          'ekey': 'test_event',
          'sokey': 'test_sub',
          'pldata': {
            'string': 'value',
            'number': 123,
            'boolean': true,
            'nested': {'key': 'nested_value'},
            'list': [1, 2, 3],
          },
        };

        // Act
        final request = SaveAnalyticsRequest.fromJson(json);

        // Assert
        expect(request.parameters?['string'], equals('value'));
        expect(request.parameters?['number'], equals(123));
        expect(request.parameters?['boolean'], equals(true));
        expect(request.parameters?['nested'], equals({'key': 'nested_value'}));
        expect(request.parameters?['list'], equals([1, 2, 3]));
      });
    });

    group('toJson', () {
      test('should serialize to JSON with all fields', () {
        // Arrange
        final request = SaveAnalyticsRequest(
          'event_key',
          'subordinate_key',
          parameters: {'key': 'value'},
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json['ekey'], equals('event_key'));
        expect(json['sokey'], equals('subordinate_key'));
        expect(json['pldata'], equals({'key': 'value'}));
      });

      test('should serialize to JSON with null parameters', () {
        // Arrange
        final request = SaveAnalyticsRequest('event_key', 'subordinate_key');

        // Act
        final json = request.toJson();

        // Assert
        expect(json['ekey'], equals('event_key'));
        expect(json['sokey'], equals('subordinate_key'));
        expect(json['pldata'], isNull);
      });

      test('should serialize to JSON with null keys', () {
        // Arrange
        final request = SaveAnalyticsRequest(null, null);

        // Act
        final json = request.toJson();

        // Assert
        expect(json['ekey'], isNull);
        expect(json['sokey'], isNull);
      });
    });

    group('round-trip serialization', () {
      test('should maintain data through serialization round-trip', () {
        // Arrange
        final original = SaveAnalyticsRequest(
          'event_key',
          'subordinate_key',
          parameters: {
            'string': 'value',
            'number': 42,
            'boolean': false,
          },
        );

        // Act
        final json = original.toJson();
        final restored = SaveAnalyticsRequest.fromJson(json);

        // Assert
        expect(restored.eventKey, equals(original.eventKey));
        expect(restored.subOrdinateEventKey, equals(original.subOrdinateEventKey));
        expect(restored.parameters, equals(original.parameters));
      });
    });

    group('JsonKey annotations', () {
      test('should use correct JSON keys for serialization', () {
        // Arrange
        final request = SaveAnalyticsRequest(
          'test_event',
          'test_sub',
          parameters: {'test': 'value'},
        );

        // Act
        final json = request.toJson();

        // Assert
        expect(json.containsKey('ekey'), isTrue);
        expect(json.containsKey('sokey'), isTrue);
        expect(json.containsKey('pldata'), isTrue);
        expect(json.containsKey('eventKey'), isFalse);
        expect(json.containsKey('subOrdinateEventKey'), isFalse);
        expect(json.containsKey('parameters'), isFalse);
      });
    });
  });
}
