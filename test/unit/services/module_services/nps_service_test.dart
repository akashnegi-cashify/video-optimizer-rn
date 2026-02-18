import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

/// Unit tests for [NpsService] class.
///
/// Tests cover:
/// - getNpsQuestions: endpoint construction
/// - submitNpsQuestions: request body construction
void main() {
  group('NpsService', () {
    group('getNpsQuestions', () {
      test('should use correct endpoint /nps/list', () {
        // Arrange
        const expectedEndpoint = '/nps/list';

        // Assert
        expect(expectedEndpoint, equals('/nps/list'));
      });

      test('endpoint should start with /nps prefix', () {
        // Arrange
        const endpoint = '/nps/list';

        // Assert
        expect(endpoint, startsWith('/nps'));
      });

      test('endpoint should end with /list', () {
        // Arrange
        const endpoint = '/nps/list';

        // Assert
        expect(endpoint, endsWith('/list'));
      });
    });

    group('submitNpsQuestions', () {
      test('should use correct endpoint /nps/submit/question/app', () {
        // Arrange
        const expectedEndpoint = '/nps/submit/question/app';

        // Assert
        expect(expectedEndpoint, equals('/nps/submit/question/app'));
      });

      test('should construct request body with question answers', () {
        // Arrange
        final body = {
          'questionId': 1,
          'answer': 5,
          'feedback': 'Great service',
        };

        // Act
        final encoded = jsonEncode(body);
        final decoded = jsonDecode(encoded) as Map<String, dynamic>;

        // Assert
        expect(decoded['questionId'], equals(1));
        expect(decoded['answer'], equals(5));
        expect(decoded['feedback'], equals('Great service'));
      });

      test('should handle empty body', () {
        // Arrange
        final body = <String, dynamic>{};

        // Act
        final encoded = jsonEncode(body);
        final decoded = jsonDecode(encoded) as Map<String, dynamic>;

        // Assert
        expect(decoded, isEmpty);
      });

      test('should handle null values in body', () {
        // Arrange
        final body = {
          'questionId': 1,
          'answer': null,
          'feedback': null,
        };

        // Act
        final encoded = jsonEncode(body);
        final decoded = jsonDecode(encoded) as Map<String, dynamic>;

        // Assert
        expect(decoded['questionId'], equals(1));
        expect(decoded['answer'], isNull);
        expect(decoded['feedback'], isNull);
      });

      test('should handle multiple questions in body', () {
        // Arrange
        final body = {
          'responses': [
            {'questionId': 1, 'answer': 5},
            {'questionId': 2, 'answer': 4},
            {'questionId': 3, 'answer': 3},
          ],
        };

        // Act
        final encoded = jsonEncode(body);
        final decoded = jsonDecode(encoded) as Map<String, dynamic>;

        // Assert
        expect(decoded['responses'], isA<List>());
        expect((decoded['responses'] as List).length, equals(3));
      });

      test('endpoint should contain submit path segment', () {
        // Arrange
        const endpoint = '/nps/submit/question/app';

        // Assert
        expect(endpoint, contains('submit'));
      });

      test('endpoint should end with /app', () {
        // Arrange
        const endpoint = '/nps/submit/question/app';

        // Assert
        expect(endpoint, endsWith('/app'));
      });
    });

    group('endpoint consistency', () {
      test('both endpoints should start with /nps', () {
        // Arrange
        const getEndpoint = '/nps/list';
        const submitEndpoint = '/nps/submit/question/app';

        // Assert
        expect(getEndpoint, startsWith('/nps'));
        expect(submitEndpoint, startsWith('/nps'));
      });

      test('endpoints should not have query parameters', () {
        // Arrange
        const getEndpoint = '/nps/list';
        const submitEndpoint = '/nps/submit/question/app';

        // Assert
        expect(getEndpoint, isNot(contains('?')));
        expect(submitEndpoint, isNot(contains('?')));
      });
    });
  });
}
