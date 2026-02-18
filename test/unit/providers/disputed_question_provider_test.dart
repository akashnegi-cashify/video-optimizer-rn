import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/providers/disputed_question_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/my_calculator_response.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for DisputedQuestionProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('DisputedQuestionProvider', () {
    late DisputedQuestionProvider provider;
    late List<ManualAuditQuestionItem> mockQuestionList;

    setUp(() {
      mockQuestionList = [
        ManualAuditQuestionItem.fromJson({'mmid': 1, 'ques': 'Question 1'}),
        ManualAuditQuestionItem.fromJson({'mmid': 2, 'ques': 'Question 2'}),
        ManualAuditQuestionItem.fromJson({'mmid': 3, 'ques': 'Question 3'}),
      ];
      provider = DisputedQuestionProvider(mockQuestionList);
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should store disputedQuestionList', () {
        expect(provider.disputedQuestionList, isNotNull);
        expect(provider.disputedQuestionList?.length, 3);
      });

      test('should handle null disputedQuestionList', () {
        final providerWithNull = DisputedQuestionProvider(null);
        expect(providerWithNull.disputedQuestionList, isNull);
        providerWithNull.dispose();
      });

      test('should handle empty disputedQuestionList', () {
        final providerWithEmpty = DisputedQuestionProvider([]);
        expect(providerWithEmpty.disputedQuestionList, isEmpty);
        providerWithEmpty.dispose();
      });
    });

    group('updateQuestionList', () {
      test('should update isSelected to true', () {
        provider.updateQuestionList(0, true);

        expect(provider.disputedQuestionList?[0].isSelected, true);
      });

      test('should update isSelected to false', () {
        provider.disputedQuestionList?[0].isSelected = true;

        provider.updateQuestionList(0, false);

        expect(provider.disputedQuestionList?[0].isSelected, false);
      });

      test('should update isSelected to null', () {
        provider.disputedQuestionList?[0].isSelected = true;

        provider.updateQuestionList(0, null);

        expect(provider.disputedQuestionList?[0].isSelected, isNull);
      });

      test('should notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.updateQuestionList(0, true);

        expect(tracker.callCount, 1);
      });
    });

    group('getSelectedQuestionList', () {
      test('should return empty list when no questions selected', () {
        final result = provider.getSelectedQuestionList();
        expect(result, isEmpty);
      });

      test('should return selected question ids', () {
        provider.disputedQuestionList?[0].isSelected = true;
        provider.disputedQuestionList?[2].isSelected = true;

        final result = provider.getSelectedQuestionList();

        expect(result.length, 2);
        expect(result, contains(1));
        expect(result, contains(3));
      });

      test('should return all ids when all selected', () {
        provider.disputedQuestionList?.forEach((q) => q.isSelected = true);

        final result = provider.getSelectedQuestionList();

        expect(result.length, 3);
        expect(result, containsAll([1, 2, 3]));
      });

      test('should return empty list when disputedQuestionList is null', () {
        final providerWithNull = DisputedQuestionProvider(null);

        final result = providerWithNull.getSelectedQuestionList();

        expect(result, isEmpty);
        providerWithNull.dispose();
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(DisputedQuestionProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = DisputedQuestionProvider(mockQuestionList);
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
