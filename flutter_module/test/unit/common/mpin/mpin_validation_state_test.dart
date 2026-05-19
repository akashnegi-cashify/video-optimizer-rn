import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/mpin/mpin_validation_state.dart';

void main() {
  group('MPinValidationState', () {
    test('has correct enum values', () {
      expect(MPinValidationState.values.length, 3);
      expect(MPinValidationState.values.contains(MPinValidationState.idle), true);
      expect(MPinValidationState.values.contains(MPinValidationState.success), true);
      expect(MPinValidationState.values.contains(MPinValidationState.error), true);
    });

    test('idle state is accessible', () {
      const state = MPinValidationState.idle;
      expect(state, MPinValidationState.idle);
      expect(state.name, 'idle');
    });

    test('success state is accessible', () {
      const state = MPinValidationState.success;
      expect(state, MPinValidationState.success);
      expect(state.name, 'success');
    });

    test('error state is accessible', () {
      const state = MPinValidationState.error;
      expect(state, MPinValidationState.error);
      expect(state.name, 'error');
    });

    test('states are correctly ordered in values list', () {
      expect(MPinValidationState.values[0], MPinValidationState.idle);
      expect(MPinValidationState.values[1], MPinValidationState.success);
      expect(MPinValidationState.values[2], MPinValidationState.error);
    });

    test('states can be compared for equality', () {
      expect(MPinValidationState.idle == MPinValidationState.idle, true);
      expect(MPinValidationState.idle == MPinValidationState.success, false);
      expect(MPinValidationState.success == MPinValidationState.error, false);
    });

    test('states have correct index', () {
      expect(MPinValidationState.idle.index, 0);
      expect(MPinValidationState.success.index, 1);
      expect(MPinValidationState.error.index, 2);
    });
  });
}
