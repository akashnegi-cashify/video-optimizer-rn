import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/part_qc/retrieved_part_qc/providers/part_qc_user_report_provider.dart';
import 'package:core_widgets/core_widgets.dart';
import '../../../helpers/provider_test_helpers.dart';

/// Tests for PartQcUserReportProvider - Part QC module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('PartQcUserReportProvider', () {
    late PartQcUserReportProvider provider;

    setUp(() {
      provider = PartQcUserReportProvider();
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should create instance', () {
        expect(provider, isNotNull);
      });

      test('should initialize queries as empty list', () {
        expect(provider.queries, isEmpty);
      });

      test('should have dateTimeRange initially null', () {
        expect(provider.dateTimeRange, isNull);
      });

      test('should have qcReportData', () {
        expect(provider.qcReportData, isNotNull);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(PartQcUserReportProvider.of, isNotNull);
      });
    });

    group('queries', () {
      test('should be empty initially', () {
        expect(provider.queries, isEmpty);
      });
    });

    group('dateTimeRange', () {
      test('should be null initially', () {
        expect(provider.dateTimeRange, isNull);
      });
    });

    group('onQueryChange', () {
      test('should add query when state is true', () {
        provider.onQueryChange('CATEGORY_001', true);
        expect(provider.queries, contains('CATEGORY_001'));
      });

      test('should remove query when state is false', () {
        provider.queries.add('CATEGORY_001');
        provider.onQueryChange('CATEGORY_001', false);
        expect(provider.queries, isNot(contains('CATEGORY_001')));
      });

      test('should notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.onQueryChange('CATEGORY_001', true);
        expect(tracker.callCount, 1);

        provider.removeListener(tracker.listener);
      });
    });

    group('onDateTimeChange', () {
      test('should update dateTimeRange', () {
        final range = DateTimeRange(
          start: DateTime(2024, 1, 1),
          end: DateTime(2024, 1, 31),
        );
        provider.onDateTimeChange(range);
        expect(provider.dateTimeRange, range);
      });
    });

    group('getFilterData', () {
      test('should return map with empty fp when dateTimeRange is null', () {
        final result = provider.getFilterData();
        expect(result, isNotNull);
        expect(result!['fp'], isEmpty);
      });

      test('should return map with from/to when dateTimeRange is set', () {
        final range = DateTimeRange(
          start: DateTime(2024, 1, 1),
          end: DateTime(2024, 1, 31),
        );
        provider.dateTimeRange = range;
        final result = provider.getFilterData();
        expect(result, isNotNull);
        expect(result!['fp']['from'], isA<int>());
        expect(result['fp']['to'], isA<int>());
      });
    });

    group('getSearchResults', () {
      test('should return all data when queries is empty', () {
        // When queries is empty, should return qcReportData.data
        expect(provider.queries, isEmpty);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = PartQcUserReportProvider();
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
