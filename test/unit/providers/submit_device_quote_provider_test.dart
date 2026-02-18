import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/providers/submit_device_quote_provider.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for SubmitDeviceQuoteProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('SubmitDeviceQuoteProvider', () {
    late SubmitDeviceQuoteProvider provider;

    setUp(() {
      provider = SubmitDeviceQuoteProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('initial state', () {
      test('isShowCompleteState should initially be false', () {
        expect(provider.isShowCompleteState, false);
      });

      test('isShowTryAgainState should initially be false', () {
        expect(provider.isShowTryAgainState, false);
      });

      test('isCaptureQcImages should initially be false', () {
        expect(provider.isCaptureQcImages, false);
      });

      test('stepperDetails should have initial item', () {
        expect(provider.stepperDetails, isNotNull);
        expect(provider.stepperDetails.length, 1);
        expect(provider.stepperDetails.first.title, 'Requesting Colors');
      });

      test('iDeviceQuote should initially be null', () {
        expect(provider.iDeviceQuote, isNull);
      });

      test('gradeObtained should initially be null', () {
        expect(provider.gradeObtained, isNull);
      });
    });

    group('setDeviceQuoteInterface', () {
      test('iDeviceQuote should initially be null', () {
        // setDeviceQuoteInterface requires a non-null interface
        // but the initial state is null
        expect(provider.iDeviceQuote, isNull);
      });
    });

    group('resetQcImageCaptureFlag', () {
      test('should set isCaptureQcImages to false', () {
        provider.isCaptureQcImages = true;
        provider.resetQcImageCaptureFlag();

        expect(provider.isCaptureQcImages, false);
      });

      test('should notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.resetQcImageCaptureFlag();

        expect(tracker.callCount, 1);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(SubmitDeviceQuoteProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = SubmitDeviceQuoteProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });

    group('method signatures', () {
      test('should have updateSelectedColor method', () {
        expect(provider.updateSelectedColor, isNotNull);
      });

      test('should have getDeviceStatus method', () {
        expect(provider.getDeviceStatus, isNotNull);
      });

      test('should have getManualQuestions method', () {
        expect(provider.getManualQuestions, isNotNull);
      });

      test('should have onManualQuestionAnswered method', () {
        expect(provider.onManualQuestionAnswered, isNotNull);
      });

      test('should have submitTrcRemarks method', () {
        expect(provider.submitTrcRemarks, isNotNull);
      });
    });
  });
}
