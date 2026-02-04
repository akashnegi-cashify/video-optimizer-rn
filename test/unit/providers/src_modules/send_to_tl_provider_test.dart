import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/providers/send_to_tl_provider.dart';
import 'package:core_widgets/core_widgets.dart';
import '../../../helpers/provider_test_helpers.dart';

/// Tests for SendToTLProvider - Engineer module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('SendToTLProvider', () {
    late SendToTLProvider provider;

    setUp(() {
      provider = SendToTLProvider();
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
        final reason = DropDownItem('1', 'Test Reason');
        provider.selectedReason = reason;
        expect(provider.selectedReason, reason);
      });

      test('should allow clearing selectedReason', () {
        final reason = DropDownItem('1', 'Test Reason');
        provider.selectedReason = reason;
        provider.selectedReason = null;
        expect(provider.selectedReason, isNull);
      });

      test('should notify listeners when changed', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.selectedReason = DropDownItem('1', 'Test');
        expect(tracker.callCount, 1);

        provider.removeListener(tracker.listener);
      });

      test('should notify on each change', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.selectedReason = DropDownItem('1', 'First');
        provider.selectedReason = DropDownItem('2', 'Second');
        provider.selectedReason = null;

        expect(tracker.callCount, 3);
        provider.removeListener(tracker.listener);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = SendToTLProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
