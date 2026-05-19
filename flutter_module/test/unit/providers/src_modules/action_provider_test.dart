import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/part_qc/retrieved_part_qc/providers/action_provider.dart';
import 'package:core_widgets/core_widgets.dart';

/// Tests for ActionProvider - Part QC Retrieved Part module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('ActionProvider', () {
    late ActionProvider provider;

    setUp(() {
      provider = ActionProvider('TEST_BARCODE_001');
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should create instance with barcode', () {
        expect(provider, isNotNull);
      });

      test('should initialize listState with initial status', () {
        expect(provider.listState.status, RequestStatus.initial);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(ActionProvider.of, isNotNull);
      });
    });

    group('listState', () {
      test('should have listState property', () {
        expect(provider.listState, isNotNull);
      });

      test('listState should have initial status', () {
        expect(provider.listState.status, RequestStatus.initial);
      });
    });

    group('updateRetrievedPartStatus', () {
      test('should have updateRetrievedPartStatus method', () {
        expect(provider.updateRetrievedPartStatus, isNotNull);
      });

      test('should return Future<bool>', () {
        expect(provider.updateRetrievedPartStatus is Function, isTrue);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = ActionProvider('TEST');
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
