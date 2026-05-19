import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/core.dart';
import 'package:flutter_trc/src/interceptors/log_interceptor.dart';

// Mocks
class MockHttpRequest extends Mock implements HttpRequest {}

class MockHttpResponse extends Mock implements HttpResponse {}

class MockHttpHandler extends Mock implements HttpHandler {}

class MockHttpHeaders extends Mock implements HttpHeaders {}

class MockHttpParams extends Mock implements HttpParams {}

class MockHttpErrorResponse extends Mock implements HttpErrorResponse {}

class MockHttpMultipartFormData extends Mock implements HttpMultipartFormData {}

// Fakes for registration
class FakeHttpRequest extends Fake implements HttpRequest {}

/// Unit tests for [LogInterceptor] class.
///
/// Tests cover:
/// - Interceptor constant values
/// - getKey method
/// - intercept method with stream handling
/// - oAuthStreamTransformer data handling
/// - oAuthStreamTransformer error handling
/// - Multipart form data handling
///
/// NOTE: Logging functionality is not directly tested as it's implementation detail.
/// Focus is on stream transformation and data flow.
void main() {
  late LogInterceptor sut;
  late MockHttpRequest mockRequest;
  late MockHttpResponse mockResponse;
  late MockHttpHandler mockHandler;
  late MockHttpHeaders mockHeaders;
  late MockHttpParams mockParams;

  setUpAll(() {
    registerFallbackValue(FakeHttpRequest());
  });

  setUp(() {
    sut = LogInterceptor();
    mockRequest = MockHttpRequest();
    mockResponse = MockHttpResponse();
    mockHandler = MockHttpHandler();
    mockHeaders = MockHttpHeaders();
    mockParams = MockHttpParams();
  });

  group('LogInterceptor', () {
    group('constants', () {
      test('LOG_INTERCEPTOR should be "LOG_INTERCEPTOR"', () {
        // Assert
        expect(LogInterceptor.LOG_INTERCEPTOR, equals('LOG_INTERCEPTOR'));
      });
    });

    group('getKey', () {
      test('should return "LogInterceptor"', () {
        // Assert
        expect(sut.getKey(), equals('LogInterceptor'));
      });

      test('getKey should return consistent value', () {
        // Act
        final key1 = sut.getKey();
        final key2 = sut.getKey();

        // Assert
        expect(key1, equals(key2));
      });
    });

    group('cshAlice', () {
      test('should have cshAlice instance', () {
        // Assert
        expect(sut.cshAlice, isNotNull);
      });
    });

    group('intercept', () {
      test('should pass request to handler and return transformed stream', () async {
        // Arrange
        when(() => mockRequest.method).thenReturn('GET');
        when(() => mockRequest.url).thenReturn(Uri.parse('https://api.example.com/test'));
        when(() => mockRequest.httpHeaders).thenReturn(mockHeaders);
        when(() => mockRequest.httpParams).thenReturn(mockParams);
        when(() => mockRequest.body).thenReturn('{"test": "data"}');
        when(() => mockParams.getAllParams()).thenReturn({'key': ['value']});
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));
        when(() => mockResponse.request).thenReturn(null);
        when(() => mockResponse.response).thenReturn(null);

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);
        final result = await stream.first;

        // Assert
        expect(result, equals(mockResponse));
        verify(() => mockHandler.handle(mockRequest)).called(1);
      });

      test('should handle null request body', () async {
        // Arrange
        when(() => mockRequest.method).thenReturn('GET');
        when(() => mockRequest.url).thenReturn(Uri.parse('https://api.example.com/test'));
        when(() => mockRequest.httpHeaders).thenReturn(mockHeaders);
        when(() => mockRequest.httpParams).thenReturn(mockParams);
        when(() => mockRequest.body).thenReturn(null);
        when(() => mockParams.getAllParams()).thenReturn({});
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));
        when(() => mockResponse.request).thenReturn(null);
        when(() => mockResponse.response).thenReturn(null);

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);
        final result = await stream.first;

        // Assert
        expect(result, equals(mockResponse));
      });

      test('should handle empty params', () async {
        // Arrange
        when(() => mockRequest.method).thenReturn('POST');
        when(() => mockRequest.url).thenReturn(Uri.parse('https://api.example.com/test'));
        when(() => mockRequest.httpHeaders).thenReturn(mockHeaders);
        when(() => mockRequest.httpParams).thenReturn(mockParams);
        when(() => mockRequest.body).thenReturn('{}');
        when(() => mockParams.getAllParams()).thenReturn({});
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));
        when(() => mockResponse.request).thenReturn(null);
        when(() => mockResponse.response).thenReturn(null);

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);
        final result = await stream.first;

        // Assert
        expect(result, equals(mockResponse));
      });
    });

    group('oAuthStreamTransformer', () {
      group('handleData', () {
        test('should pass through data unchanged', () async {
          // Arrange
          when(() => mockResponse.request).thenReturn(null);
          when(() => mockResponse.response).thenReturn(null);

          // Act
          final transformer = sut.oAuthStreamTransformer();
          final controller = StreamController<HttpResponse>();
          final transformedStream = controller.stream.transform(transformer);

          final completer = Completer<HttpResponse>();
          transformedStream.listen(completer.complete);

          controller.add(mockResponse);
          await controller.close();

          // Assert
          final result = await completer.future;
          expect(result, equals(mockResponse));
        });

        test('should handle response with null request', () async {
          // Arrange
          when(() => mockResponse.request).thenReturn(null);
          when(() => mockResponse.response).thenReturn(null);

          // Act
          final transformer = sut.oAuthStreamTransformer();
          final controller = StreamController<HttpResponse>();
          final transformedStream = controller.stream.transform(transformer);

          final results = <HttpResponse>[];
          final completer = Completer<void>();
          transformedStream.listen(
            results.add,
            onDone: completer.complete,
          );

          controller.add(mockResponse);
          await controller.close();
          await completer.future;

          // Assert
          expect(results.length, equals(1));
          expect(results.first, equals(mockResponse));
        });

        test('should handle multiple responses', () async {
          // Arrange
          final mockResponse2 = MockHttpResponse();
          when(() => mockResponse.request).thenReturn(null);
          when(() => mockResponse.response).thenReturn(null);
          when(() => mockResponse2.request).thenReturn(null);
          when(() => mockResponse2.response).thenReturn(null);

          // Act
          final transformer = sut.oAuthStreamTransformer();
          final controller = StreamController<HttpResponse>();
          final transformedStream = controller.stream.transform(transformer);

          final results = <HttpResponse>[];
          final completer = Completer<void>();
          transformedStream.listen(
            results.add,
            onDone: completer.complete,
          );

          controller.add(mockResponse);
          controller.add(mockResponse2);
          await controller.close();
          await completer.future;

          // Assert
          expect(results.length, equals(2));
        });
      });

      group('handleError', () {
        test('should propagate HttpErrorResponse errors', () async {
          // Arrange
          final mockErrorResponse = MockHttpErrorResponse();
          when(() => mockErrorResponse.request).thenReturn(null);
          when(() => mockErrorResponse.response).thenReturn(null);

          // Act
          final transformer = sut.oAuthStreamTransformer();
          final controller = StreamController<HttpResponse>();
          final transformedStream = controller.stream.transform(transformer);

          // Assert
          expectLater(
            transformedStream,
            emitsError(isA<HttpErrorResponse>()),
          );

          controller.addError(mockErrorResponse);
          await controller.close();
        });

        test('should propagate non-HttpErrorResponse errors', () async {
          // Arrange
          final genericError = Exception('Generic error');

          // Act
          final transformer = sut.oAuthStreamTransformer();
          final controller = StreamController<HttpResponse>();
          final transformedStream = controller.stream.transform(transformer);

          // Assert
          expectLater(
            transformedStream,
            emitsError(isA<Exception>()),
          );

          controller.addError(genericError);
          await controller.close();
        });

        test('should preserve stack trace when propagating errors', () async {
          // Arrange
          final error = Exception('Test error');
          final stackTrace = StackTrace.current;

          // Act
          final transformer = sut.oAuthStreamTransformer();
          final controller = StreamController<HttpResponse>();
          final transformedStream = controller.stream.transform(transformer);

          Object? capturedError;
          StackTrace? capturedStackTrace;

          transformedStream.listen(
            (_) {},
            onError: (e, st) {
              capturedError = e;
              capturedStackTrace = st;
            },
          );

          controller.addError(error, stackTrace);
          await controller.close();

          // Allow stream processing
          await Future.delayed(const Duration(milliseconds: 10));

          // Assert
          expect(capturedError, equals(error));
          expect(capturedStackTrace, isNotNull);
        });

        test('should handle HttpErrorResponse with null request', () async {
          // Arrange
          final mockErrorResponse = MockHttpErrorResponse();
          when(() => mockErrorResponse.request).thenReturn(null);
          when(() => mockErrorResponse.response).thenReturn(null);

          // Act
          final transformer = sut.oAuthStreamTransformer();
          final controller = StreamController<HttpResponse>();
          final transformedStream = controller.stream.transform(transformer);

          Object? capturedError;
          transformedStream.listen(
            (_) {},
            onError: (e, st) {
              capturedError = e;
            },
          );

          controller.addError(mockErrorResponse);
          await controller.close();

          // Allow stream processing
          await Future.delayed(const Duration(milliseconds: 10));

          // Assert
          expect(capturedError, equals(mockErrorResponse));
        });
      });

      group('multipart form data handling', () {
        test('should handle request with multipart form data in response', () async {
          // Arrange
          final multipartFormData = MockHttpMultipartFormData();
          when(() => multipartFormData.fields).thenReturn({'field1': 'value1'});
          when(() => mockRequest.body).thenReturn(multipartFormData);
          when(() => mockRequest.httpParams).thenReturn(mockParams);
          when(() => mockParams.getAllParams()).thenReturn({});
          when(() => mockResponse.request).thenReturn(mockRequest);
          when(() => mockResponse.response).thenReturn(null);

          // Act
          final transformer = sut.oAuthStreamTransformer();
          final controller = StreamController<HttpResponse>();
          final transformedStream = controller.stream.transform(transformer);

          final completer = Completer<HttpResponse>();
          transformedStream.listen(completer.complete);

          controller.add(mockResponse);
          await controller.close();

          // Assert
          final result = await completer.future;
          expect(result, equals(mockResponse));
        });

        test('should handle HttpErrorResponse with multipart form data', () async {
          // Arrange
          final multipartFormData = MockHttpMultipartFormData();
          when(() => multipartFormData.fields).thenReturn({'field1': 'value1'});
          when(() => mockRequest.body).thenReturn(multipartFormData);
          when(() => mockRequest.httpParams).thenReturn(mockParams);
          when(() => mockParams.getAllParams()).thenReturn({});

          final mockErrorResponse = MockHttpErrorResponse();
          when(() => mockErrorResponse.request).thenReturn(mockRequest);
          when(() => mockErrorResponse.response).thenReturn(null);

          // Act
          final transformer = sut.oAuthStreamTransformer();
          final controller = StreamController<HttpResponse>();
          final transformedStream = controller.stream.transform(transformer);

          Object? capturedError;
          transformedStream.listen(
            (_) {},
            onError: (e, st) {
              capturedError = e;
            },
          );

          controller.addError(mockErrorResponse);
          await controller.close();

          // Allow stream processing
          await Future.delayed(const Duration(milliseconds: 10));

          // Assert
          expect(capturedError, equals(mockErrorResponse));
        });
      });
    });

    group('edge cases', () {
      test('should handle stream with no data', () async {
        // Arrange
        when(() => mockRequest.method).thenReturn('GET');
        when(() => mockRequest.url).thenReturn(Uri.parse('https://api.example.com/test'));
        when(() => mockRequest.httpHeaders).thenReturn(mockHeaders);
        when(() => mockRequest.httpParams).thenReturn(mockParams);
        when(() => mockRequest.body).thenReturn(null);
        when(() => mockParams.getAllParams()).thenReturn({});
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => const Stream.empty());

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);
        final results = await stream.toList();

        // Assert
        expect(results, isEmpty);
      });

      test('should handle special characters in request URL', () async {
        // Arrange
        when(() => mockRequest.method).thenReturn('GET');
        when(() => mockRequest.url).thenReturn(Uri.parse('https://api.example.com/test?query=%20%21%40'));
        when(() => mockRequest.httpHeaders).thenReturn(mockHeaders);
        when(() => mockRequest.httpParams).thenReturn(mockParams);
        when(() => mockRequest.body).thenReturn(null);
        when(() => mockParams.getAllParams()).thenReturn({'query': [' !@']});
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));
        when(() => mockResponse.request).thenReturn(null);
        when(() => mockResponse.response).thenReturn(null);

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);
        final result = await stream.first;

        // Assert
        expect(result, equals(mockResponse));
      });

      test('should handle JSON body with nested objects', () async {
        // Arrange
        final nestedBody = jsonEncode({
          'level1': {
            'level2': {
              'level3': 'value',
            },
          },
        });
        when(() => mockRequest.method).thenReturn('POST');
        when(() => mockRequest.url).thenReturn(Uri.parse('https://api.example.com/test'));
        when(() => mockRequest.httpHeaders).thenReturn(mockHeaders);
        when(() => mockRequest.httpParams).thenReturn(mockParams);
        when(() => mockRequest.body).thenReturn(nestedBody);
        when(() => mockParams.getAllParams()).thenReturn({});
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));
        when(() => mockResponse.request).thenReturn(null);
        when(() => mockResponse.response).thenReturn(null);

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);
        final result = await stream.first;

        // Assert
        expect(result, equals(mockResponse));
      });
    });

    group('transformer type validation', () {
      test('oAuthStreamTransformer should return StreamTransformer', () {
        // Act
        final transformer = sut.oAuthStreamTransformer();

        // Assert
        expect(transformer, isA<StreamTransformer<HttpResponse, HttpResponse>>());
      });

      test('oAuthStreamTransformer should return new instance each call', () {
        // Act
        final transformer1 = sut.oAuthStreamTransformer();
        final transformer2 = sut.oAuthStreamTransformer();

        // Assert
        expect(identical(transformer1, transformer2), isFalse);
      });
    });
  });
}
