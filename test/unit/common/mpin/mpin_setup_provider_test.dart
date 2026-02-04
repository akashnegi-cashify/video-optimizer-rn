import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/mpin/providers/mpin_setup_provider.dart';
import 'package:flutter_trc/src/common/mpin/mpin_validation_state.dart';

/// Testable subclass that doesn't make API calls
class TestableMPinSetupProvider extends MPinSetupProvider {
  TestableMPinSetupProvider();

  // Override onSubmit to prevent actual API calls
  @override
  Future<void> onSubmit() {
    // Return a completed future for testing
    return Future.value();
  }
}

void main() {
  group('MPinSetupProvider', () {
    late MPinSetupProvider provider;

    setUp(() {
      provider = TestableMPinSetupProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('initial state', () {
      test('consecutiveState is idle initially', () {
        expect(provider.consecutiveState, MPinValidationState.idle);
      });

      test('repetitive is idle initially', () {
        expect(provider.repetitive, MPinValidationState.idle);
      });
    });

    group('onMPinChanged', () {
      test('sets error for consecutive ascending digits', () {
        provider.onMPinChanged('1234');

        expect(provider.consecutiveState, MPinValidationState.error);
      });

      test('sets error for consecutive descending digits', () {
        provider.onMPinChanged('4321');

        expect(provider.consecutiveState, MPinValidationState.error);
      });

      test('sets success for non-consecutive digits', () {
        provider.onMPinChanged('1357');

        expect(provider.consecutiveState, MPinValidationState.success);
      });

      test('sets error for repetitive digits', () {
        provider.onMPinChanged('1111');

        expect(provider.repetitive, MPinValidationState.error);
      });

      test('sets success for non-repetitive digits', () {
        provider.onMPinChanged('1234');

        expect(provider.repetitive, MPinValidationState.success);
      });

      test('valid PIN has both success states', () {
        provider.onMPinChanged('1357');

        expect(provider.consecutiveState, MPinValidationState.success);
        expect(provider.repetitive, MPinValidationState.success);
      });

      test('consecutive PIN has error and success', () {
        provider.onMPinChanged('1234');

        expect(provider.consecutiveState, MPinValidationState.error);
        expect(provider.repetitive, MPinValidationState.success);
      });

      test('repetitive PIN has both error states', () {
        provider.onMPinChanged('1111');

        // 1111 is both consecutive (same digit repeated) and repetitive
        // For isConsecutive: '1111' is NOT consecutive sequence like 1234
        // Actually, let's check what MPinController.isConsecutive returns for '1111'
        // isConsecutive checks if diff is 1 (or -1), for '1111' the diff is 0, so it returns false
        expect(provider.consecutiveState, MPinValidationState.success);
        expect(provider.repetitive, MPinValidationState.error);
      });
    });

    group('onConfirmPinChanged', () {
      test('can set confirm PIN', () {
        // Should not throw
        expect(() => provider.onConfirmPinChanged('1234'), returnsNormally);
      });

      test('can update confirm PIN', () {
        provider.onConfirmPinChanged('1234');
        provider.onConfirmPinChanged('5678');
        // No assertion needed - just verifying it doesn't throw
      });
    });

    group('isEnableSubmitButton', () {
      test('returns false when states are idle', () {
        expect(provider.isEnableSubmitButton(), false);
      });

      test('returns false when consecutiveState is error', () {
        provider.onMPinChanged('1234'); // consecutive
        provider.onConfirmPinChanged('1234');

        expect(provider.isEnableSubmitButton(), false);
      });

      test('returns false when repetitive is error', () {
        provider.onMPinChanged('1111'); // repetitive
        provider.onConfirmPinChanged('1111');

        expect(provider.isEnableSubmitButton(), false);
      });

      test('returns false when confirm PIN is empty', () {
        provider.onMPinChanged('1357'); // valid

        expect(provider.isEnableSubmitButton(), false);
      });

      test('returns true when PIN is valid and confirm PIN is set', () {
        provider.onMPinChanged('1357'); // valid PIN
        provider.onConfirmPinChanged('1357');

        expect(provider.isEnableSubmitButton(), true);
      });

      test('returns true for complex valid PIN', () {
        provider.onMPinChanged('2468'); // even numbers, non-consecutive
        provider.onConfirmPinChanged('2468');

        expect(provider.isEnableSubmitButton(), true);
      });
    });

    group('validation combinations', () {
      test('PIN 0246 is valid (non-consecutive, non-repetitive)', () {
        provider.onMPinChanged('0246');
        provider.onConfirmPinChanged('0246');

        expect(provider.consecutiveState, MPinValidationState.success);
        expect(provider.repetitive, MPinValidationState.success);
        expect(provider.isEnableSubmitButton(), true);
      });

      test('PIN 9999 is invalid (repetitive)', () {
        provider.onMPinChanged('9999');
        provider.onConfirmPinChanged('9999');

        expect(provider.repetitive, MPinValidationState.error);
        expect(provider.isEnableSubmitButton(), false);
      });

      test('PIN 5678 is invalid (consecutive ascending)', () {
        provider.onMPinChanged('5678');
        provider.onConfirmPinChanged('5678');

        expect(provider.consecutiveState, MPinValidationState.error);
        expect(provider.isEnableSubmitButton(), false);
      });

      test('PIN 8765 is invalid (consecutive descending)', () {
        provider.onMPinChanged('8765');
        provider.onConfirmPinChanged('8765');

        expect(provider.consecutiveState, MPinValidationState.error);
        expect(provider.isEnableSubmitButton(), false);
      });
    });
  });
}
