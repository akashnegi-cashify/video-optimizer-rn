import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/part_detail/providers/return_part_provider.dart';
import 'package:core_widgets/core_widgets.dart';
import '../../../helpers/provider_test_helpers.dart';

/// Tests for ReturnPartProvider - Engineer module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('ReturnPartProvider', () {
    late ReturnPartProvider provider;

    setUp(() {
      provider = ReturnPartProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should create instance', () {
        expect(provider, isNotNull);
      });
    });

    group('selectedReason getter/setter', () {
      test('should return null initially', () {
        expect(provider.selectedReason, isNull);
      });

      test('should update selectedReason', () {
        final reason = DropDownItem<String>('1', 'Test Reason');
        provider.selectedReason = reason;
        expect(provider.selectedReason, reason);
      });

      test('should allow clearing selectedReason', () {
        final reason = DropDownItem<String>('1', 'Test Reason');
        provider.selectedReason = reason;
        provider.selectedReason = null;
        expect(provider.selectedReason, isNull);
      });

      test('should notify listeners when changed', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.selectedReason = DropDownItem<String>('1', 'Test');
        expect(tracker.callCount, 1);

        provider.removeListener(tracker.listener);
      });
    });

    group('retrievedPartBarcode getter/setter', () {
      test('should return null initially', () {
        expect(provider.retrievedPartBarcode, isNull);
      });

      test('should update retrievedPartBarcode', () {
        provider.retrievedPartBarcode = 'BARCODE_001';
        expect(provider.retrievedPartBarcode, 'BARCODE_001');
      });

      test('should allow clearing retrievedPartBarcode', () {
        provider.retrievedPartBarcode = 'BARCODE_001';
        provider.retrievedPartBarcode = null;
        expect(provider.retrievedPartBarcode, isNull);
      });

      test('should notify listeners when changed', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.retrievedPartBarcode = 'BARCODE_001';
        expect(tracker.callCount, 1);

        provider.removeListener(tracker.listener);
      });
    });

    group('remarks', () {
      test('should be null initially', () {
        expect(provider.remarks, isNull);
      });

      test('should allow setting remarks', () {
        provider.remarks = 'Test remarks';
        expect(provider.remarks, 'Test remarks');
      });
    });

    group('isEnabled', () {
      test('should return false when selectedReason is null', () {
        expect(provider.isEnabled(false), isFalse);
        expect(provider.isEnabled(true), isFalse);
      });

      test('should return true when selectedReason is set and isRetrievedPartAssign is false', () {
        provider.selectedReason = DropDownItem<String>('1', 'Reason');
        expect(provider.isEnabled(false), isTrue);
      });

      test('should return false when isRetrievedPartAssign is true and retrievedPartBarcode is null', () {
        provider.selectedReason = DropDownItem<String>('1', 'Reason');
        expect(provider.isEnabled(true), isFalse);
      });

      test('should return true when isRetrievedPartAssign is true and retrievedPartBarcode is set', () {
        provider.selectedReason = DropDownItem<String>('1', 'Reason');
        provider.retrievedPartBarcode = 'BARCODE_001';
        expect(provider.isEnabled(true), isTrue);
      });

      test('should return false when isRetrievedPartAssign is true and retrievedPartBarcode is empty', () {
        provider.selectedReason = DropDownItem<String>('1', 'Reason');
        provider.retrievedPartBarcode = '';
        expect(provider.isEnabled(true), isFalse);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = ReturnPartProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
