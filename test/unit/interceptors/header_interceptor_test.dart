import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core/core.dart';
import 'package:flutter_trc/src/interceptors/header/header_interceptor.dart';
import 'package:flutter_trc/src/interceptors/auth/request_headers.dart';

// Mocks
class MockHttpRequest extends Mock implements HttpRequest {}

class MockHttpResponse extends Mock implements HttpResponse {}

class MockHttpHandler extends Mock implements HttpHandler {}

class MockHttpHeaders extends Mock implements HttpHeaders {}

// Fakes for registration
class FakeHttpRequest extends Fake implements HttpRequest {}

/// Unit tests for [HeaderInterceptor] class.
///
/// Tests cover:
/// - Common header injection
/// - Service group handling
/// - Initiator check to prevent infinite loops
void main() {
  late HeaderInterceptor sut;
  late MockHttpRequest mockRequest;
  late MockHttpResponse mockResponse;
  late MockHttpHandler mockHandler;
  late MockHttpHeaders mockHeaders;

  const testAppOSHeaderValue = 'Android 12';

  setUpAll(() {
    registerFallbackValue(FakeHttpRequest());
  });

  setUp(() {
    sut = HeaderInterceptor(testAppOSHeaderValue);
    mockRequest = MockHttpRequest();
    mockResponse = MockHttpResponse();
    mockHandler = MockHttpHandler();
    mockHeaders = MockHttpHeaders();
  });

  group('HeaderInterceptor', () {
    group('constructor', () {
      test('should store appOSHeaderValue', () {
        // Assert
        expect(sut.appOSHeaderValue, equals(testAppOSHeaderValue));
      });

      test('should accept empty string as appOSHeaderValue', () {
        // Arrange & Act
        final interceptor = HeaderInterceptor('');

        // Assert
        expect(interceptor.appOSHeaderValue, isEmpty);
      });
    });

    group('getKey', () {
      test('should return "HeaderInterceptor"', () {
        // Assert
        expect(sut.getKey(), equals('HeaderInterceptor'));
      });

      test('HEADER_INTERCEPTOR constant should be correct', () {
        // Assert
        expect(HeaderInterceptor.HEADER_INTERCEPTOR, equals('HEADER_INTERCEPTOR'));
      });
    });

    group('intercept', () {
      test('should pass request through unchanged when initiator is self', () {
        // Arrange
        when(() => mockRequest.initiator).thenReturn(sut);
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert
        stream.listen(expectAsync1((response) {
          expect(response, equals(mockResponse));
        }));
        verify(() => mockHandler.handle(mockRequest)).called(1);
      });

      test('should pass request through unchanged when serviceGroup is null', () {
        // Arrange
        when(() => mockRequest.initiator).thenReturn(null);
        when(() => mockRequest.serviceGroup).thenReturn(null);
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert
        stream.listen(expectAsync1((response) {
          expect(response, equals(mockResponse));
        }));
        verify(() => mockHandler.handle(mockRequest)).called(1);
      });

      test('should add common headers when serviceGroup is not null', () {
        // Arrange
        HttpRequest? capturedRequest;
        when(() => mockRequest.initiator).thenReturn(null);
        when(() => mockRequest.serviceGroup).thenReturn('testServiceGroup');
        when(() => mockRequest.httpHeaders).thenReturn(mockHeaders);
        when(() => mockRequest.clone(setHeaders: any(named: 'setHeaders'))).thenAnswer((invocation) {
          capturedRequest = mockRequest;
          return mockRequest;
        });
        when(() => mockHandler.handle(any())).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert
        stream.listen(expectAsync1((response) {
          verify(() => mockRequest.clone(setHeaders: any(named: 'setHeaders'))).called(1);
        }));
      });

      test('should include x-app-os header with correct value', () {
        // Arrange
        Map<String, String>? capturedHeaders;
        when(() => mockRequest.initiator).thenReturn(null);
        when(() => mockRequest.serviceGroup).thenReturn('testServiceGroup');
        when(() => mockRequest.httpHeaders).thenReturn(mockHeaders);
        when(() => mockRequest.clone(setHeaders: any(named: 'setHeaders'))).thenAnswer((invocation) {
          capturedHeaders = invocation.namedArguments[#setHeaders] as Map<String, String>?;
          return mockRequest;
        });
        when(() => mockHandler.handle(any())).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert
        stream.listen(expectAsync1((_) {
          expect(capturedHeaders, isNotNull);
          expect(capturedHeaders![AppHeaders.X_APP_OS_KEY], equals(testAppOSHeaderValue));
        }));
      });

      test('should include x-app-lang header', () {
        // Arrange
        Map<String, String>? capturedHeaders;
        when(() => mockRequest.initiator).thenReturn(null);
        when(() => mockRequest.serviceGroup).thenReturn('testServiceGroup');
        when(() => mockRequest.httpHeaders).thenReturn(mockHeaders);
        when(() => mockRequest.clone(setHeaders: any(named: 'setHeaders'))).thenAnswer((invocation) {
          capturedHeaders = invocation.namedArguments[#setHeaders] as Map<String, String>?;
          return mockRequest;
        });
        when(() => mockHandler.handle(any())).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert
        stream.listen(expectAsync1((_) {
          expect(capturedHeaders, isNotNull);
          expect(capturedHeaders!.containsKey(AppHeaders.X_APP_LANGUAGE_KEY), isTrue);
        }));
      });

      test('should include x-app-version header', () {
        // Arrange
        Map<String, String>? capturedHeaders;
        when(() => mockRequest.initiator).thenReturn(null);
        when(() => mockRequest.serviceGroup).thenReturn('testServiceGroup');
        when(() => mockRequest.httpHeaders).thenReturn(mockHeaders);
        when(() => mockRequest.clone(setHeaders: any(named: 'setHeaders'))).thenAnswer((invocation) {
          capturedHeaders = invocation.namedArguments[#setHeaders] as Map<String, String>?;
          return mockRequest;
        });
        when(() => mockHandler.handle(any())).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert
        stream.listen(expectAsync1((_) {
          expect(capturedHeaders, isNotNull);
          expect(capturedHeaders!.containsKey(AppHeaders.X_APP_VERSION_KEY), isTrue);
        }));
      });

      test('should not add headers when request initiator is the interceptor itself', () {
        // Arrange
        when(() => mockRequest.initiator).thenReturn(sut);
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert
        stream.listen(expectAsync1((_) {
          verifyNever(() => mockRequest.clone(setHeaders: any(named: 'setHeaders')));
        }));
      });

      test('should handle stream errors from handler', () {
        // Arrange
        final expectedError = Exception('Network error');
        when(() => mockRequest.initiator).thenReturn(null);
        when(() => mockRequest.serviceGroup).thenReturn(null);
        when(() => mockHandler.handle(mockRequest)).thenAnswer((_) => Stream.error(expectedError));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert
        expect(
          stream.first,
          throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Network error'))),
        );
      });
    });

    group('_addCommonHeaders (via intercept)', () {
      test('should set three common headers', () {
        // Arrange
        Map<String, String>? capturedHeaders;
        when(() => mockRequest.initiator).thenReturn(null);
        when(() => mockRequest.serviceGroup).thenReturn('testServiceGroup');
        when(() => mockRequest.httpHeaders).thenReturn(mockHeaders);
        when(() => mockRequest.clone(setHeaders: any(named: 'setHeaders'))).thenAnswer((invocation) {
          capturedHeaders = invocation.namedArguments[#setHeaders] as Map<String, String>?;
          return mockRequest;
        });
        when(() => mockHandler.handle(any())).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = sut.intercept(mockRequest, mockHandler);

        // Assert
        stream.listen(expectAsync1((_) {
          expect(capturedHeaders, isNotNull);
          expect(capturedHeaders!.length, equals(3));
          expect(capturedHeaders!.containsKey(AppHeaders.X_APP_OS_KEY), isTrue);
          expect(capturedHeaders!.containsKey(AppHeaders.X_APP_LANGUAGE_KEY), isTrue);
          expect(capturedHeaders!.containsKey(AppHeaders.X_APP_VERSION_KEY), isTrue);
        }));
      });
    });

    group('Different OS header values', () {
      test('should handle iOS header value', () {
        // Arrange
        final iosInterceptor = HeaderInterceptor('iOS 16');
        Map<String, String>? capturedHeaders;
        when(() => mockRequest.initiator).thenReturn(null);
        when(() => mockRequest.serviceGroup).thenReturn('testServiceGroup');
        when(() => mockRequest.httpHeaders).thenReturn(mockHeaders);
        when(() => mockRequest.clone(setHeaders: any(named: 'setHeaders'))).thenAnswer((invocation) {
          capturedHeaders = invocation.namedArguments[#setHeaders] as Map<String, String>?;
          return mockRequest;
        });
        when(() => mockHandler.handle(any())).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = iosInterceptor.intercept(mockRequest, mockHandler);

        // Assert
        stream.listen(expectAsync1((_) {
          expect(capturedHeaders![AppHeaders.X_APP_OS_KEY], equals('iOS 16'));
        }));
      });

      test('should handle web header value', () {
        // Arrange
        final webInterceptor = HeaderInterceptor('Web');
        Map<String, String>? capturedHeaders;
        when(() => mockRequest.initiator).thenReturn(null);
        when(() => mockRequest.serviceGroup).thenReturn('testServiceGroup');
        when(() => mockRequest.httpHeaders).thenReturn(mockHeaders);
        when(() => mockRequest.clone(setHeaders: any(named: 'setHeaders'))).thenAnswer((invocation) {
          capturedHeaders = invocation.namedArguments[#setHeaders] as Map<String, String>?;
          return mockRequest;
        });
        when(() => mockHandler.handle(any())).thenAnswer((_) => Stream.value(mockResponse));

        // Act
        final stream = webInterceptor.intercept(mockRequest, mockHandler);

        // Assert
        stream.listen(expectAsync1((_) {
          expect(capturedHeaders![AppHeaders.X_APP_OS_KEY], equals('Web'));
        }));
      });
    });
  });
}
