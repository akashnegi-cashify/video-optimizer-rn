import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

void main() {
  group('TRCServiceGroups Enum', () {
    group('enum values', () {
      test('should have qc service group', () {
        expect(TRCServiceGroups.qc, isNotNull);
        expect(TRCServiceGroups.values.contains(TRCServiceGroups.qc), isTrue);
      });

      test('should have trc service group', () {
        expect(TRCServiceGroups.trc, isNotNull);
        expect(TRCServiceGroups.values.contains(TRCServiceGroups.trc), isTrue);
      });

      test('should have supersalesOms service group', () {
        expect(TRCServiceGroups.supersalesOms, isNotNull);
        expect(TRCServiceGroups.values.contains(TRCServiceGroups.supersalesOms), isTrue);
      });

      test('should have imageOptimiser service group', () {
        expect(TRCServiceGroups.imageOptimiser, isNotNull);
        expect(TRCServiceGroups.values.contains(TRCServiceGroups.imageOptimiser), isTrue);
      });

      test('should have qcErazer service group', () {
        expect(TRCServiceGroups.qcErazer, isNotNull);
        expect(TRCServiceGroups.values.contains(TRCServiceGroups.qcErazer), isTrue);
      });

      test('should have rms service group', () {
        expect(TRCServiceGroups.rms, isNotNull);
        expect(TRCServiceGroups.values.contains(TRCServiceGroups.rms), isTrue);
      });

      test('should have qcTransferLot service group', () {
        expect(TRCServiceGroups.qcTransferLot, isNotNull);
        expect(TRCServiceGroups.values.contains(TRCServiceGroups.qcTransferLot), isTrue);
      });

      test('should have qcConsole service group', () {
        expect(TRCServiceGroups.qcConsole, isNotNull);
        expect(TRCServiceGroups.values.contains(TRCServiceGroups.qcConsole), isTrue);
      });

      test('should have unifyTrc service group', () {
        expect(TRCServiceGroups.unifyTrc, isNotNull);
        expect(TRCServiceGroups.values.contains(TRCServiceGroups.unifyTrc), isTrue);
      });

      test('should have salesOrder service group', () {
        expect(TRCServiceGroups.salesOrder, isNotNull);
        expect(TRCServiceGroups.values.contains(TRCServiceGroups.salesOrder), isTrue);
      });

      test('should have exactly 10 service groups', () {
        expect(TRCServiceGroups.values.length, 10);
      });
    });

    group('value property', () {
      test('qc should have value "qc"', () {
        expect(TRCServiceGroups.qc.value, 'qc');
      });

      test('trc should have value "trc"', () {
        expect(TRCServiceGroups.trc.value, 'trc');
      });

      test('supersalesOms should have value "supersales-oms"', () {
        expect(TRCServiceGroups.supersalesOms.value, 'supersales-oms');
      });

      test('imageOptimiser should have value "image-optimizer"', () {
        expect(TRCServiceGroups.imageOptimiser.value, 'image-optimizer');
      });

      test('qcErazer should have value "qc-data-erazer"', () {
        expect(TRCServiceGroups.qcErazer.value, 'qc-data-erazer');
      });

      test('rms should have value "sales-rms"', () {
        expect(TRCServiceGroups.rms.value, 'sales-rms');
      });

      test('qcTransferLot should have value "qc-transfer-lot"', () {
        expect(TRCServiceGroups.qcTransferLot.value, 'qc-transfer-lot');
      });

      test('qcConsole should have value "qc-console"', () {
        expect(TRCServiceGroups.qcConsole.value, 'qc-console');
      });

      test('unifyTrc should have value "unify-trc"', () {
        expect(TRCServiceGroups.unifyTrc.value, 'unify-trc');
      });

      test('salesOrder should have value "qc-sales-order"', () {
        expect(TRCServiceGroups.salesOrder.value, 'qc-sales-order');
      });
    });

    group('value uniqueness', () {
      test('all service group values should be unique', () {
        // Arrange
        final values = TRCServiceGroups.values.map((e) => e.value).toList();

        // Act
        final uniqueValues = values.toSet();

        // Assert
        expect(uniqueValues.length, values.length,
            reason: 'Each service group should have a unique value');
      });

      test('all values should be non-empty strings', () {
        for (final group in TRCServiceGroups.values) {
          expect(group.value, isNotEmpty,
              reason: '${group.name} should have a non-empty value');
          expect(group.value, isA<String>());
        }
      });
    });

    group('ServiceGroupsMixin implementation', () {
      test('all service groups should have value property from mixin', () {
        // The enum uses ServiceGroupsMixin which requires value property
        for (final group in TRCServiceGroups.values) {
          expect(group.value, isA<String>());
        }
      });
    });

    group('value format conventions', () {
      test('values should follow kebab-case convention', () {
        // Verify values with multiple words use kebab-case
        expect(TRCServiceGroups.supersalesOms.value, contains('-'));
        expect(TRCServiceGroups.imageOptimiser.value, contains('-'));
        expect(TRCServiceGroups.qcErazer.value, contains('-'));
        expect(TRCServiceGroups.qcTransferLot.value, contains('-'));
        expect(TRCServiceGroups.qcConsole.value, contains('-'));
        expect(TRCServiceGroups.unifyTrc.value, contains('-'));
        expect(TRCServiceGroups.salesOrder.value, contains('-'));
      });

      test('simple values should be single words', () {
        expect(TRCServiceGroups.qc.value, isNot(contains('-')));
        expect(TRCServiceGroups.trc.value, isNot(contains('-')));
      });

      test('all values should be lowercase', () {
        for (final group in TRCServiceGroups.values) {
          expect(group.value, equals(group.value.toLowerCase()),
              reason: '${group.name} value should be lowercase');
        }
      });
    });

    group('mapping consistency', () {
      test('QC-related groups should have qc prefix in value', () {
        // qcErazer, qcTransferLot, qcConsole all have qc prefix
        expect(TRCServiceGroups.qcErazer.value, startsWith('qc'));
        expect(TRCServiceGroups.qcTransferLot.value, startsWith('qc'));
        expect(TRCServiceGroups.qcConsole.value, startsWith('qc'));
        expect(TRCServiceGroups.salesOrder.value, startsWith('qc'));
      });

      test('TRC-related groups should contain trc in value', () {
        expect(TRCServiceGroups.trc.value, contains('trc'));
        expect(TRCServiceGroups.unifyTrc.value, contains('trc'));
      });

      test('RMS group should have sales prefix in value', () {
        expect(TRCServiceGroups.rms.value, startsWith('sales'));
      });
    });
  });
}
