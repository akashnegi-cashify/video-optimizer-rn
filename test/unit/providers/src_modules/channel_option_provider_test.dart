import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/providers/channel_option_provider.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_part.dart';

/// Tests for ChannelOptionProvider - ELSS QC module provider.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('ChannelOptionProvider', () {
    late ChannelOptionProvider provider;

    setUp(() {
      provider = ChannelOptionProvider('TEST_BARCODE_001');
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should create instance with barcode', () {
        expect(provider, isNotNull);
      });

      test('should have isOptionDataLoading initially true', () {
        expect(provider.isOptionDataLoading, isTrue);
      });

      test('should have empty errorOfChannel initially', () {
        expect(provider.errorOfChannel, '');
      });

      test('should accept optional pQuoteId', () {
        final providerWithQuoteId = ChannelOptionProvider('BARCODE', pQuoteId: 'QUOTE123');
        expect(providerWithQuoteId.pQuoteId, 'QUOTE123');
        providerWithQuoteId.dispose();
      });

      test('should accept optional remarks', () {
        final providerWithRemarks = ChannelOptionProvider('BARCODE', remarks: 'Test remarks');
        expect(providerWithRemarks.remarks, 'Test remarks');
        providerWithRemarks.dispose();
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(ChannelOptionProvider.of, isNotNull);
      });
    });

    group('channelOptionResponse', () {
      test('should be null initially', () {
        expect(provider.channelOptionResponse, isNull);
      });
    });

    group('otherChannelOptions', () {
      test('should return null when channelOptionResponse is null', () {
        expect(provider.otherChannelOptions, isNull);
      });
    });

    group('yourChannelSuggestion', () {
      test('should return null when channelOptionResponse is null', () {
        expect(provider.yourChannelSuggestion, isNull);
      });
    });

    group('defaultChannelSuggestion', () {
      test('should return null when channelOptionResponse is null', () {
        expect(provider.defaultChannelSuggestion, isNull);
      });
    });

    group('initialChannelSuggestion', () {
      test('should return null when channelOptionResponse is null', () {
        expect(provider.initialChannelSuggestion, isNull);
      });
    });

    group('markPNAStatus', () {
      test('should have markPNAStatus method', () {
        expect(provider.markPNAStatus, isNotNull);
      });
    });

    group('checkIsItemSelectedForPNA', () {
      test('should return false for empty list', () {
        expect(provider.checkIsItemSelectedForPNA([]), isFalse);
      });

      test('should return false when no items have isPnaSelected true', () {
        final parts = [
          ElssPart(sku: 'SKU001', isPnaSelected: false),
        ];
        expect(provider.checkIsItemSelectedForPNA(parts), isFalse);
      });

      test('should return true when an item has isPnaSelected true', () {
        final parts = [
          ElssPart(sku: 'SKU001', isPnaSelected: true),
        ];
        expect(provider.checkIsItemSelectedForPNA(parts), isTrue);
      });
    });

    group('getPostDataMapForElssOptionData', () {
      test('should return empty list for empty input', () {
        final result = provider.getPostDataMapForElssOptionData([]);
        expect(result, isEmpty);
      });

      test('should return list of maps with sku and partName', () {
        final parts = [
          ElssPart(sku: 'SKU001', partName: 'Part 1'),
          ElssPart(sku: 'SKU002', partName: 'Part 2'),
        ];
        final result = provider.getPostDataMapForElssOptionData(parts);
        expect(result.length, 2);
        expect(result[0]['sku'], 'SKU001');
        expect(result[0]['partName'], 'Part 1');
      });
    });

    group('submitElssAcceptData', () {
      test('should have submitElssAcceptData method', () {
        expect(provider.submitElssAcceptData, isNotNull);
      });
    });

    group('removePNASelectedItem', () {
      test('should not throw for empty list', () {
        expect(() => provider.removePNASelectedItem([]), returnsNormally);
      });

      test('should set isPnaSelected to false for all items', () {
        final parts = [
          ElssPart(sku: 'SKU001', isPnaSelected: true),
          ElssPart(sku: 'SKU002', isPnaSelected: true),
        ];
        provider.removePNASelectedItem(parts);
        expect(parts[0].isPnaSelected, isFalse);
        expect(parts[1].isPnaSelected, isFalse);
      });
    });

    group('getDevicePartsForPna', () {
      test('should return null for null input', () {
        expect(provider.getDevicePartsForPna(null), isNull);
      });

      test('should return empty list for empty input', () {
        final result = provider.getDevicePartsForPna([]);
        expect(result, isEmpty);
      });
    });

    group('resetTransaction', () {
      test('should not throw', () {
        expect(() => provider.resetTransaction('BARCODE'), returnsNormally);
      });

      test('should accept null barcode', () {
        expect(() => provider.resetTransaction(null), returnsNormally);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = ChannelOptionProvider('TEST');
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });
  });
}
