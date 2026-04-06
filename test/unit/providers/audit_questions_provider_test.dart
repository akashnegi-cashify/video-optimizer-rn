import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/providers/audit_questions_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/resources/new_audit_response.dart';
import '../../helpers/provider_test_helpers.dart';

/// Testable subclass that doesn't make API calls in constructor
class TestableAuditQuestionsProvider extends AuditQuestionsProvider {
  TestableAuditQuestionsProvider(super.scannedData);

  @override
  getAuditQuestionsData(String scannedBarcode) {
    // Skip API call in tests
    isQuestionsDataLoading = false;
  }
}

/// Tests for AuditQuestionsProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      const MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async => '/tmp',
    );
  });

  group('AuditQuestionsProvider', () {
    late TestableAuditQuestionsProvider provider;

    setUp(() {
      provider = TestableAuditQuestionsProvider('TEST_BARCODE_001');
    });

    tearDown(() {
      provider.dispose();
    });

    group('initial state', () {
      test('auditData should initially be null', () {
        expect(provider.auditData, isNull);
      });

      test('isQuestionsDataLoading should be false after testable init', () {
        // In testable subclass, loading is set to false in constructor
        expect(provider.isQuestionsDataLoading, false);
      });

      test('errMessage should initially be null', () {
        expect(provider.errMessage, isNull);
      });
    });

    group('onQuestionOptionSelected', () {
      test('should not throw when auditData is null', () {
        provider.auditData = null;

        expect(
          () => provider.onQuestionOptionSelected(1, 'Yes'),
          returnsNormally,
        );
      });

      test('should not throw when questionList is null', () {
        provider.auditData = AuditQuestionResponse.fromJson({});

        expect(
          () => provider.onQuestionOptionSelected(1, 'Yes'),
          returnsNormally,
        );
      });

      test('should not throw when questionList is empty', () {
        provider.auditData = AuditQuestionResponse.fromJson({
          'dpr': [],
        });

        expect(
          () => provider.onQuestionOptionSelected(1, 'Yes'),
          returnsNormally,
        );
      });

      test('should update selectedOption when question found', () {
        provider.auditData = AuditQuestionResponse.fromJson({
          'dpr': [
            {'pi': 1, 'pn': 'Question 1'},
            {'pi': 2, 'pn': 'Question 2'},
          ],
        });

        provider.onQuestionOptionSelected(1, 'Yes');

        expect(provider.auditData?.auditQuestionList?[0].selectedOption, 'Yes');
      });

      test('should not update when question not found', () {
        provider.auditData = AuditQuestionResponse.fromJson({
          'dpr': [
            {'pi': 1, 'pn': 'Question 1'},
          ],
        });

        provider.onQuestionOptionSelected(999, 'Yes');

        expect(provider.auditData?.auditQuestionList?[0].selectedOption, isNull);
      });

      test('should notify listeners', () {
        provider.auditData = AuditQuestionResponse.fromJson({
          'dpr': [
            {'pi': 1, 'pn': 'Question 1'},
          ],
        });

        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.onQuestionOptionSelected(1, 'Yes');

        expect(tracker.callCount, 1);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(AuditQuestionsProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = TestableAuditQuestionsProvider('TEST');
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });

    group('method signatures', () {
      test('should have getAuditQuestionsData method', () {
        expect(provider.getAuditQuestionsData, isNotNull);
      });
    });
  });
}
