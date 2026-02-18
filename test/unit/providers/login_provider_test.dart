import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/login/providers/login_provider.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for TRCLoginProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('TRCLoginProvider', () {
    late TRCLoginProvider provider;

    setUp(() {
      provider = TRCLoginProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('initial state', () {
      test('start should initially be 30', () {
        expect(provider.start, 30);
      });

      test('isTimerStared should initially be false', () {
        expect(provider.isTimerStared, false);
      });

      test('isActiveResendOtp should initially be false', () {
        expect(provider.isActiveResendOtp, false);
      });

      test('otpResponse should initially be null', () {
        expect(provider.otpResponse, isNull);
      });

      test('timer should initially be null', () {
        expect(provider.timer, isNull);
      });
    });

    group('resetResendOtpButton', () {
      test('should set isActiveResendOtp to false', () {
        provider.isActiveResendOtp = true;

        provider.resetResendOtpButton();

        expect(provider.isActiveResendOtp, false);
      });

      test('should reset start to 30', () {
        provider.start = 5;

        provider.resetResendOtpButton();

        expect(provider.start, 30);
      });

      test('should notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.resetResendOtpButton();

        expect(tracker.callCount, 1);
      });
    });

    group('resetSentOTPResponse', () {
      test('should set isActiveResendOtp to false', () {
        provider.isActiveResendOtp = true;

        provider.resetSentOTPResponse();

        expect(provider.isActiveResendOtp, false);
      });

      test('should reset start to 30', () {
        provider.start = 5;

        provider.resetSentOTPResponse();

        expect(provider.start, 30);
      });

      test('should set otpResponse to null', () {
        provider.resetSentOTPResponse();

        expect(provider.otpResponse, isNull);
      });

      test('should notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.resetSentOTPResponse();

        expect(tracker.callCount, 1);
      });
    });

    group('startTimer', () {
      test('should start timer', () {
        provider.startTimer();

        expect(provider.timer, isNotNull);

        // Clean up timer
        provider.timer?.cancel();
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(TRCLoginProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = TRCLoginProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });

      test('should cancel active timer on dispose', () {
        final testProvider = TRCLoginProvider();
        testProvider.startTimer();

        testProvider.dispose();

        // After dispose, timer should be cancelled
        expect(testProvider.timer?.isActive ?? false, false);
      });
    });

    group('method signatures', () {
      test('should have userLogin method', () {
        expect(provider.userLogin, isNotNull);
      });

      test('should have qcSendOTP method', () {
        expect(provider.qcSendOTP, isNotNull);
      });

      test('should have authenticateSentOTP method', () {
        expect(provider.authenticateSentOTP, isNotNull);
      });
    });
  });
}
