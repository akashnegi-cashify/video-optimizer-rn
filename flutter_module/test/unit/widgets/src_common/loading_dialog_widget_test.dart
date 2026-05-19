import 'dart:async';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/loading_dialog_widget.dart';

void main() {
  group('Op Extension on Stream', () {
    test('doAsyncOp calls onLoading with true initially', () async {
      final stream = Stream.value('test');
      bool loadingState = false;
      bool loadingCalled = false;

      stream.doAsyncOp(
        (value) {},
        (loading) {
          if (!loadingCalled) {
            loadingState = loading;
            loadingCalled = true;
          }
        },
        (e, s) {},
      );

      // Wait for stream to process
      await Future.delayed(const Duration(milliseconds: 50));
      expect(loadingState, isTrue);
    });

    test('doAsyncOp calls onValue with stream value', () async {
      final stream = Stream.value('test value');
      String? receivedValue;

      stream.doAsyncOp(
        (value) {
          receivedValue = value;
        },
        (loading) {},
        (e, s) {},
      );

      // Wait for stream to process
      await Future.delayed(const Duration(milliseconds: 50));
      expect(receivedValue, 'test value');
    });

    test('doAsyncOp calls onLoading with false after value received', () async {
      final stream = Stream.value('test');
      bool finalLoadingState = true;

      stream.doAsyncOp(
        (value) {},
        (loading) {
          finalLoadingState = loading;
        },
        (e, s) {},
      );

      // Wait for stream to process
      await Future.delayed(const Duration(milliseconds: 50));
      expect(finalLoadingState, isFalse);
    });

    test('doAsyncOp handles error and calls handleError', () async {
      final stream = Stream<String>.error(Exception('test error'));
      dynamic receivedError;

      stream.doAsyncOp(
        (value) {},
        (loading) {},
        (e, s) {
          receivedError = e;
        },
      );

      // Wait for stream to process
      await Future.delayed(const Duration(milliseconds: 50));
      expect(receivedError, isA<Exception>());
    });

    test('doAsyncOp sets loading to false on error', () async {
      final stream = Stream<String>.error(Exception('test error'));
      bool finalLoadingState = true;

      stream.doAsyncOp(
        (value) {},
        (loading) {
          finalLoadingState = loading;
        },
        (e, s) {},
      );

      // Wait for stream to process
      await Future.delayed(const Duration(milliseconds: 50));
      expect(finalLoadingState, isFalse);
    });

    test('doAsyncOp receives stack trace on error', () async {
      final stream = Stream<String>.error(Exception('test error'));
      dynamic receivedStackTrace;

      stream.doAsyncOp(
        (value) {},
        (loading) {},
        (e, s) {
          receivedStackTrace = s;
        },
      );

      // Wait for stream to process
      await Future.delayed(const Duration(milliseconds: 50));
      expect(receivedStackTrace, isA<StackTrace>());
    });

    test('doAsyncOp works with int stream', () async {
      final stream = Stream.value(42);
      int? receivedValue;

      stream.doAsyncOp(
        (value) {
          receivedValue = value;
        },
        (loading) {},
        (e, s) {},
      );

      // Wait for stream to process
      await Future.delayed(const Duration(milliseconds: 50));
      expect(receivedValue, 42);
    });

    test('doAsyncOp works with custom object stream', () async {
      final testObject = _TestObject(id: 1, name: 'test');
      final stream = Stream.value(testObject);
      _TestObject? receivedValue;

      stream.doAsyncOp(
        (value) {
          receivedValue = value;
        },
        (loading) {},
        (e, s) {},
      );

      // Wait for stream to process
      await Future.delayed(const Duration(milliseconds: 50));
      expect(receivedValue, testObject);
      expect(receivedValue?.id, 1);
      expect(receivedValue?.name, 'test');
    });

    test('doAsyncOp works with nullable stream', () async {
      final stream = Stream<String?>.value(null);
      String? receivedValue = 'not null';
      bool valueCalled = false;

      stream.doAsyncOp(
        (value) {
          receivedValue = value;
          valueCalled = true;
        },
        (loading) {},
        (e, s) {},
      );

      // Wait for stream to process
      await Future.delayed(const Duration(milliseconds: 50));
      expect(valueCalled, isTrue);
      expect(receivedValue, isNull);
    });

    test('doAsyncOp loading sequence is correct', () async {
      final stream = Stream.value('test');
      final loadingStates = <bool>[];

      stream.doAsyncOp(
        (value) {},
        (loading) {
          loadingStates.add(loading);
        },
        (e, s) {},
      );

      // Wait for stream to process
      await Future.delayed(const Duration(milliseconds: 50));
      expect(loadingStates, [true, false]);
    });

    test('doAsyncOp error loading sequence is correct', () async {
      final stream = Stream<String>.error(Exception('error'));
      final loadingStates = <bool>[];

      stream.doAsyncOp(
        (value) {},
        (loading) {
          loadingStates.add(loading);
        },
        (e, s) {},
      );

      // Wait for stream to process
      await Future.delayed(const Duration(milliseconds: 50));
      expect(loadingStates, [true, false]);
    });

    test('doAsyncOp handles multiple stream values', () async {
      final controller = StreamController<int>();
      final receivedValues = <int>[];
      final loadingStates = <bool>[];

      controller.stream.doAsyncOp(
        (value) {
          receivedValues.add(value);
        },
        (loading) {
          loadingStates.add(loading);
        },
        (e, s) {},
      );

      controller.add(1);
      controller.add(2);
      controller.add(3);
      await controller.close();

      // Wait for stream to process
      await Future.delayed(const Duration(milliseconds: 50));
      expect(receivedValues, [1, 2, 3]);
    });
  });
}

/// Test helper class for custom object stream testing
class _TestObject {
  final int id;
  final String name;

  _TestObject({required this.id, required this.name});
}
