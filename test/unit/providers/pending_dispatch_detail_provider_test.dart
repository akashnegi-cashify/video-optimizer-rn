import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/providers/pending_dispatch_detail_provider.dart';
import '../../helpers/provider_test_helpers.dart';

/// Tests for PendingDispatchDetailProvider - the actual provider implementation.
/// These tests import and execute the real provider code to ensure coverage.
void main() {
  group('PendingDispatchDetailProvider', () {
    late PendingDispatchDetailProvider provider;

    setUp(() {
      provider = PendingDispatchDetailProvider('INV123456', 'LOT_NAME_001');
    });

    tearDown(() {
      provider.dispose();
    });

    group('constructor', () {
      test('should store scannedInvoiceNo', () {
        expect(provider.scannedInvoiceNo, 'INV123456');
      });

      test('should store lotName', () {
        expect(provider.lotName, 'LOT_NAME_001');
      });

      test('should accept null scannedInvoiceNo', () {
        final providerWithNull = PendingDispatchDetailProvider(null, 'LOT');
        expect(providerWithNull.scannedInvoiceNo, isNull);
        providerWithNull.dispose();
      });

      test('should accept null lotName', () {
        final providerWithNull = PendingDispatchDetailProvider('INV', null);
        expect(providerWithNull.lotName, isNull);
        providerWithNull.dispose();
      });

      test('should accept both null values', () {
        final providerWithNull = PendingDispatchDetailProvider(null, null);
        expect(providerWithNull.scannedInvoiceNo, isNull);
        expect(providerWithNull.lotName, isNull);
        providerWithNull.dispose();
      });
    });

    group('initial state', () {
      test('invoiceUrl should initially be null', () {
        expect(provider.invoiceUrl, isNull);
      });
    });

    group('invoiceUrl setter and getter', () {
      test('should update invoiceUrl value', () {
        provider.invoiceUrl = 'https://example.com/invoice.pdf';

        expect(provider.invoiceUrl, 'https://example.com/invoice.pdf');
      });

      test('should allow null invoiceUrl', () {
        provider.invoiceUrl = 'https://test.com';
        provider.invoiceUrl = null;

        expect(provider.invoiceUrl, isNull);
      });

      test('should allow empty invoiceUrl', () {
        provider.invoiceUrl = '';

        expect(provider.invoiceUrl, '');
      });

      test('should notify listeners when set', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.invoiceUrl = 'https://example.com';

        expect(tracker.callCount, 1);
      });
    });

    group('onNewInvoiceScanned', () {
      test('should update scannedInvoiceNo', () {
        provider.onNewInvoiceScanned('NEW_INV_789');

        expect(provider.scannedInvoiceNo, 'NEW_INV_789');
      });

      test('should reset invoiceUrl to null', () {
        provider.invoiceUrl = 'https://example.com';
        provider.onNewInvoiceScanned('NEW_INV');

        expect(provider.invoiceUrl, isNull);
      });

      test('should notify listeners', () {
        final tracker = ListenerTracker();
        provider.addListener(tracker.listener);

        provider.onNewInvoiceScanned('NEW_INV');

        expect(tracker.callCount, 1);
      });

      test('should handle empty scanned data', () {
        provider.onNewInvoiceScanned('');

        expect(provider.scannedInvoiceNo, '');
      });
    });

    group('isAllDataFilled', () {
      test('should return false when invoiceUrl is null', () {
        provider.invoiceUrl = null;
        provider.scannedInvoiceNo = 'INV123';

        expect(provider.isAllDataFilled('AWB123'), false);
      });

      test('should return false when invoiceUrl is empty', () {
        provider.invoiceUrl = '';
        provider.scannedInvoiceNo = 'INV123';

        expect(provider.isAllDataFilled('AWB123'), false);
      });

      test('should return false when awbNo is null', () {
        provider.invoiceUrl = 'https://example.com';
        provider.scannedInvoiceNo = 'INV123';

        expect(provider.isAllDataFilled(null), false);
      });

      test('should return false when awbNo is empty', () {
        provider.invoiceUrl = 'https://example.com';
        provider.scannedInvoiceNo = 'INV123';

        expect(provider.isAllDataFilled(''), false);
      });

      test('should return false when scannedInvoiceNo is null', () {
        provider.invoiceUrl = 'https://example.com';
        provider.scannedInvoiceNo = null;

        expect(provider.isAllDataFilled('AWB123'), false);
      });

      test('should return false when scannedInvoiceNo is empty', () {
        provider.invoiceUrl = 'https://example.com';
        provider.scannedInvoiceNo = '';

        expect(provider.isAllDataFilled('AWB123'), false);
      });

      test('should return true when all data is filled', () {
        provider.invoiceUrl = 'https://example.com/invoice.pdf';
        provider.scannedInvoiceNo = 'INV123';

        expect(provider.isAllDataFilled('AWB123'), true);
      });

      test('should return false when all data is missing', () {
        provider.invoiceUrl = null;
        provider.scannedInvoiceNo = null;

        expect(provider.isAllDataFilled(null), false);
      });
    });

    group('static of() method', () {
      test('should have static of method', () {
        expect(PendingDispatchDetailProvider.of, isNotNull);
      });
    });

    group('dispose', () {
      test('should dispose without errors', () {
        final testProvider = PendingDispatchDetailProvider('INV', 'LOT');
        expect(() => testProvider.dispose(), returnsNormally);
      });
    });

    group('completeDispatch method signature', () {
      test('should have completeDispatch method', () {
        expect(provider.completeDispatch, isNotNull);
      });
    });
  });
}
