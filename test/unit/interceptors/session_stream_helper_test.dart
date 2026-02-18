import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/interceptors/auth/session_stream.helper.dart';

/// Unit tests for [SessionStreamHelper] class.
///
/// Tests cover:
/// - Subject creation when null or closed
/// - Stream reuse when subject exists
/// - Success callback handling
/// - Error callback handling
void main() {
  group('SessionStreamHelper', () {
    setUp(() {
      // Reset the static subject before each test
      SessionStreamHelper.subject?.close();
      SessionStreamHelper.subject = null;
    });

    tearDown(() {
      // Clean up after each test
      SessionStreamHelper.subject?.close();
      SessionStreamHelper.subject = null;
    });

    group('handleSessionExpire', () {
      test('should create new BehaviorSubject when subject is null', () async {
        // Arrange
        final completer = Completer<String>();
        Future<String> callback() => completer.future;

        // Act
        final stream = SessionStreamHelper.handleSessionExpire(callback);

        // Assert
        expect(SessionStreamHelper.subject, isNotNull);
        expect(stream, isA<Stream<String>>());

        // Complete the callback to clean up
        completer.complete('test_auth');
        await stream.first;
      });

      test('should return existing stream when subject is not null and not closed', () async {
        // Arrange
        final completer1 = Completer<String>();
        final completer2 = Completer<String>();
        Future<String> callback1() => completer1.future;
        Future<String> callback2() => completer2.future;

        // Act - First call creates the subject
        final stream1 = SessionStreamHelper.handleSessionExpire(callback1);
        final subject1 = SessionStreamHelper.subject;

        // Second call should return the same subject's stream
        final stream2 = SessionStreamHelper.handleSessionExpire(callback2);
        final subject2 = SessionStreamHelper.subject;

        // Assert
        expect(identical(subject1, subject2), isTrue);

        // Complete to clean up
        completer1.complete('test_auth');
        await stream1.first;
      });

      test('should create new subject when previous subject is closed', () async {
        // Arrange
        final completer1 = Completer<String>();
        Future<String> callback1() => completer1.future;

        // Act - First call
        final stream1 = SessionStreamHelper.handleSessionExpire(callback1);
        completer1.complete('test_auth_1');
        await stream1.first; // Wait for completion which closes the subject

        // Wait a bit for cleanup
        await Future.delayed(const Duration(milliseconds: 10));

        // Second call should create new subject since previous is closed
        final completer2 = Completer<String>();
        Future<String> callback2() => completer2.future;
        final stream2 = SessionStreamHelper.handleSessionExpire(callback2);

        // Assert
        expect(SessionStreamHelper.subject, isNotNull);

        // Clean up
        completer2.complete('test_auth_2');
        await stream2.first;
      });

      test('should emit auth value when callback succeeds', () async {
        // Arrange
        const expectedAuth = 'test_sso_token_123';
        final completer = Completer<String>();
        Future<String> callback() => completer.future;

        // Act
        final stream = SessionStreamHelper.handleSessionExpire(callback);
        completer.complete(expectedAuth);

        // Assert
        expect(await stream.first, equals(expectedAuth));
      });

      test('should emit error when callback fails', () async {
        // Arrange
        final expectedError = Exception('Session refresh failed');
        final completer = Completer<String>();
        Future<String> callback() => completer.future;

        // Act
        final stream = SessionStreamHelper.handleSessionExpire(callback);
        completer.completeError(expectedError);

        // Assert
        expect(
          stream.first,
          throwsA(isA<Exception>().having((e) => e.toString(), 'message', contains('Session refresh failed'))),
        );
      });

      test('should close subject after successful callback', () async {
        // Arrange
        final completer = Completer<String>();
        Future<String> callback() => completer.future;

        // Act
        final stream = SessionStreamHelper.handleSessionExpire(callback);
        completer.complete('test_auth');
        await stream.first;

        // Wait for cleanup
        await Future.delayed(const Duration(milliseconds: 10));

        // Assert
        expect(SessionStreamHelper.subject, isNull);
      });

      test('should close subject after callback error', () async {
        // Arrange
        final completer = Completer<String>();
        Future<String> callback() => completer.future;

        // Act
        final stream = SessionStreamHelper.handleSessionExpire(callback);
        completer.completeError(Exception('Error'));

        // Consume the error
        try {
          await stream.first;
        } catch (_) {}

        // Wait for cleanup
        await Future.delayed(const Duration(milliseconds: 10));

        // Assert
        expect(SessionStreamHelper.subject, isNull);
      });

      test('should handle null callback gracefully', () async {
        // Arrange & Act
        final stream = SessionStreamHelper.handleSessionExpire(null);

        // Assert
        expect(SessionStreamHelper.subject, isNotNull);
        expect(stream, isA<Stream<String>>());

        // The stream won't emit anything since callback is null
        // Clean up manually
        SessionStreamHelper.subject?.close();
        SessionStreamHelper.subject = null;
      });

      test('should not create new subject during pending callback', () async {
        // Arrange
        final completer = Completer<String>();
        Future<String> callback() => completer.future;

        // Act
        SessionStreamHelper.handleSessionExpire(callback);
        final subject1 = SessionStreamHelper.subject;

        // Call again while callback is pending
        SessionStreamHelper.handleSessionExpire(callback);
        final subject2 = SessionStreamHelper.subject;

        // Assert - Same subject should be reused
        expect(identical(subject1, subject2), isTrue);

        // Clean up
        completer.complete('test');
        await Future.delayed(const Duration(milliseconds: 10));
      });

      test('should allow multiple listeners on the stream', () async {
        // Arrange
        const expectedAuth = 'shared_auth_token';
        final completer = Completer<String>();
        Future<String> callback() => completer.future;

        // Act
        final stream = SessionStreamHelper.handleSessionExpire(callback);

        // Multiple listeners
        final results = <String>[];
        stream.listen((value) => results.add('listener1: $value'));
        stream.listen((value) => results.add('listener2: $value'));

        completer.complete(expectedAuth);
        await Future.delayed(const Duration(milliseconds: 50));

        // Assert - BehaviorSubject broadcasts to all listeners
        expect(results, contains(contains('listener1')));
        expect(results, contains(contains('listener2')));
      });
    });
  });
}
