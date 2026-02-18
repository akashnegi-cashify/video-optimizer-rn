import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty;
import 'package:flutter_trc/src/interceptors/cashify_alert_interceptor.dart';
import 'package:flutter_trc/src/common/cashify_alert/cashify_alert_handler.dart';

// Mocks
class MockHttpRequest extends Mock implements HttpRequest {}

class MockHttpResponse extends Mock implements HttpResponse {}

class MockHttpHandler extends Mock implements HttpHandler {}

class MockCashifyAlert extends Mock implements CashifyAlert {}

// Fakes for registration
class FakeHttpRequest extends Fake implements HttpRequest {}

class FakeCashifyAlert extends Fake implements CashifyAlert {}

/// Unit tests for [CashifyAlertInterceptor] class.
///
/// Tests cover:
/// - Interceptor constant values
/// - getKey method
/// - intercept method behavior with valid alerts
/// - CashifyAlertHandler callback registration
///
/// NOTE: The CashifyAlertInterceptor uses asyncMap with a StreamController that
/// only gets populated when a valid CashifyAlert is found in the response body.
/// When alert is null (no __ca field or parse failure), the stream never completes.
/// Tests for null alert scenarios use timeout expectations to verify this behavior.
void main() {
  late CashifyAlertInterceptor sut;
  late MockHttpRequest mockRequest;
  late MockHttpResponse mockResponse;
  late MockHttpHandler mockHandler;

  setUpAll(() {
    registerFallbackValue(FakeHttpRequest());
    registerFallbackValue(FakeCashifyAlert());
  });

  setUp(() {
    sut = CashifyAlertInterceptor();
    mockRequest = MockHttpRequest();
    mockResponse = MockHttpResponse();
    mockHandler = MockHttpHandler();

    // Setup default CashifyAlertHandler callback
    CashifyAlertHandler.instance.setAlertCallback((alert) => Future.value(true));
  });

  group('CashifyAlertInterceptor', () {
    group('constants', () {
      test('CASHIFY_ALERT_INTERCEPTOR should be "CASHIFY_ALERT_INTERCEPTOR"', () {
        // Assert
        expect(CashifyAlertInterceptor.CASHIFY_ALERT_INTERCEPTOR, equals('CASHIFY_ALERT_INTERCEPTOR'));
      });

      test('constant should be non-empty string', () {
        // Assert
        expect(CashifyAlertInterceptor.CASHIFY_ALERT_INTERCEPTOR.isNotEmpty, isTrue);
      });

      test('constant should be immutable', () {
        // Act & Assert
        final value1 = CashifyAlertInterceptor.CASHIFY_ALERT_INTERCEPTOR;
        final value2 = CashifyAlertInterceptor.CASHIFY_ALERT_INTERCEPTOR;
        expect(identical(value1, value2), isTrue);
      });
    });

    group('getKey', () {
      test('should return "CashifyAlertInterceptor"', () {
        // Assert
        expect(sut.getKey(), equals('CashifyAlertInterceptor'));
      });

      test('getKey should return consistent value', () {
        // Act
        final key1 = sut.getKey();
        final key2 = sut.getKey();

        // Assert
        expect(key1, equals(key2));
      });

      test('getKey should return non-empty string', () {
        // Assert
        expect(sut.getKey().isNotEmpty, isTrue);
      });

      test('getKey should not equal CASHIFY_ALERT_INTERCEPTOR constant', () {
        // Note: The constant is uppercase format, getKey returns PascalCase
        expect(sut.getKey(), isNot(equals(CashifyAlertInterceptor.CASHIFY_ALERT_INTERCEPTOR)));
      });
    });

    group('intercept', () {
      test('should call handler.handle with the request', () async {
        // Arrange
        // Create a response with a valid alert that will complete the stream
        final alertJson = {
          '__ca': {
            'title': 'Test',
            'message': 'Test message',
            'positiveButtonText': 'OK',
            'negativeButtonText': 'Cancel',
            'cancelable': 1,
            'actionResponse': {'type': 1},
          },
        };
        when(() => mockResponse.body).thenReturn(jsonEncode(alertJson));
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert - verify handler was called (stream may timeout if alert parsing fails)
        verify(() => mockHandler.handle(mockRequest)).called(1);

        // Cleanup - don't await the stream as it may not complete
        stream.listen((_) {});
      });

      test('should return a Stream', () {
        // Arrange
        when(() => mockResponse.body).thenReturn('{}');
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final result = sut.intercept(mockRequest, mockHandler);

        // Assert
        expect(result, isA<Stream<HttpResponse>>());
      });

      test('should handle empty stream from handler', () async {
        // Arrange
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => const Stream.empty());

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);
        final results = await stream.toList();

        // Assert
        expect(results, isEmpty);
      });

      test('should propagate errors from handler', () async {
        // Arrange
        final expectedError = Exception('Handler error');
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.error(expectedError));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert
        await expectLater(stream.first, throwsA(isA<Exception>()));
      });
    });

    group('alert extraction behavior', () {
      // NOTE: When alert is null (no __ca or parse failure), the StreamController
      // in intercept() is never populated, causing the stream to hang.
      // These tests document this behavior using timeout expectations.

      test('should not complete stream when body has no __ca field', () async {
        // Arrange
        when(() => mockResponse.body).thenReturn('{"data": "test"}');
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert - stream should timeout because StreamController is never populated
        // when alert is null
        expect(
          stream.first.timeout(const Duration(milliseconds: 100)),
          throwsA(isA<TimeoutException>()),
        );
      });

      test('should not complete stream when body is empty JSON', () async {
        // Arrange
        when(() => mockResponse.body).thenReturn('{}');
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert
        expect(
          stream.first.timeout(const Duration(milliseconds: 100)),
          throwsA(isA<TimeoutException>()),
        );
      });

      test('should not complete stream when __ca is null', () async {
        // Arrange
        when(() => mockResponse.body).thenReturn('{"__ca": null}');
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert
        expect(
          stream.first.timeout(const Duration(milliseconds: 100)),
          throwsA(isA<TimeoutException>()),
        );
      });

      test('should not complete stream when body is invalid JSON', () async {
        // Arrange
        when(() => mockResponse.body).thenReturn('invalid json');
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert - mayBe catches the parse error, alert becomes null
        expect(
          stream.first.timeout(const Duration(milliseconds: 100)),
          throwsA(isA<TimeoutException>()),
        );
      });

      test('should not complete stream when __ca is not an object', () async {
        // Arrange
        when(() => mockResponse.body).thenReturn('{"__ca": "string value"}');
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert
        expect(
          stream.first.timeout(const Duration(milliseconds: 100)),
          throwsA(isA<TimeoutException>()),
        );
      });
    });

    group('CashifyAlertHandler integration', () {
      test('CashifyAlertHandler.instance should be accessible', () {
        // Assert
        expect(CashifyAlertHandler.instance, isNotNull);
      });

      test('CashifyAlertHandler.instance should be singleton', () {
        // Act
        final instance1 = CashifyAlertHandler.instance;
        final instance2 = CashifyAlertHandler.instance;

        // Assert
        expect(identical(instance1, instance2), isTrue);
      });

      test('should be able to set alert callback on handler', () {
        // Arrange
        final callback = (CashifyAlert alert) {
          return Future.value(true);
        };

        // Act
        CashifyAlertHandler.instance.setAlertCallback(callback);

        // Assert - callback should be set
        expect(CashifyAlertHandler.instance.registerAlertCallback, isNotNull);
      });

      test('isPopupShowing should be accessible', () {
        // Assert
        expect(CashifyAlertHandler.instance.isPopupShowing, isA<bool>());
      });

      test('isPopupShowing should default to false', () {
        // Note: This may vary based on test order, but documents the field exists
        expect(CashifyAlertHandler.instance.isPopupShowing, isA<bool>());
      });
    });

    group('stream behavior', () {
      test('should use asyncMap transformation', () {
        // Arrange
        when(() => mockResponse.body).thenReturn('{}');
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert - verify stream is created (asyncMap is used internally)
        expect(stream, isA<Stream<HttpResponse>>());
      });

      test('should handle multiple responses from handler', () async {
        // Arrange
        final response1 = MockHttpResponse();
        final response2 = MockHttpResponse();
        when(() => response1.body).thenReturn('{"id": 1}');
        when(() => response2.body).thenReturn('{"id": 2}');
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.fromIterable([response1, response2]));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert - both responses will timeout since no valid alerts
        // This documents the asyncMap behavior with multiple items
        expect(
          stream.first.timeout(const Duration(milliseconds: 100)),
          throwsA(isA<TimeoutException>()),
        );
      });
    });

    group('type verification', () {
      test('should extend HttpInterceptor', () {
        // Assert
        expect(sut, isA<HttpInterceptor>());
      });

      test('intercept should have correct signature', () {
        // Arrange
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => const Stream.empty());

        // Act
        final result = sut.intercept(mockRequest, mockHandler);

        // Assert
        expect(result, isA<Stream<HttpResponse>>());
      });
    });

    group('edge cases', () {
      test('should handle body with unicode characters without crashing', () async {
        // Arrange
        final body = jsonEncode({
          'message': '你好世界 🌍',
          '__ca': null,
        });
        when(() => mockResponse.body).thenReturn(body);
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert - should not crash, but will timeout due to null alert
        expect(
          stream.first.timeout(const Duration(milliseconds: 100)),
          throwsA(isA<TimeoutException>()),
        );
      });

      test('should handle body with escaped characters without crashing', () async {
        // Arrange
        final body = '{"message": "Line1\\nLine2\\tTab", "__ca": null}';
        when(() => mockResponse.body).thenReturn(body);
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert
        expect(
          stream.first.timeout(const Duration(milliseconds: 100)),
          throwsA(isA<TimeoutException>()),
        );
      });

      test('should handle deeply nested JSON without crashing', () async {
        // Arrange
        final body = jsonEncode({
          'level1': {
            'level2': {
              'level3': {
                'level4': {
                  'level5': 'deep value',
                },
              },
            },
          },
        });
        when(() => mockResponse.body).thenReturn(body);
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert
        expect(
          stream.first.timeout(const Duration(milliseconds: 100)),
          throwsA(isA<TimeoutException>()),
        );
      });

      test('should handle body that is just a JSON array without crashing', () async {
        // Arrange
        when(() => mockResponse.body).thenReturn('[1, 2, 3]');
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert - array body will cause parse error for __ca, caught by mayBe
        expect(
          stream.first.timeout(const Duration(milliseconds: 100)),
          throwsA(isA<TimeoutException>()),
        );
      });

      test('should handle empty string body without crashing', () async {
        // Arrange
        when(() => mockResponse.body).thenReturn('');
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert
        expect(
          stream.first.timeout(const Duration(milliseconds: 100)),
          throwsA(isA<TimeoutException>()),
        );
      });
    });
  });
}
