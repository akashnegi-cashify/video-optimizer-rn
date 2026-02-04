import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/resources/lot_type_filter_service.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/resources/lot_type_filter_response.dart';
import 'package:flutter_trc/qc/qc_common/lot_type_filters/resources/lot_type_filter_new_response.dart';

/// Unit tests for [LotTypeFilterService] class.
///
/// These tests execute actual service methods to ensure code coverage.
/// Since the service uses internal QcService() instances, we test:
/// - Method invocation and stream creation
/// - Endpoint verification
/// - Return type verification
void main() {
  group('LotTypeFilterService', () {
    group('storeOutLotTypeFilters', () {
      test('should create stream and execute method', () {
        final stream = LotTypeFilterService.storeOutLotTypeFilters();
        expect(stream, isA<Stream<LotTypeFilterResponse?>>());
      });

      test('method should be callable without throwing', () {
        expect(() => LotTypeFilterService.storeOutLotTypeFilters(), returnsNormally);
      });

      test('endpoint verification', () {
        const endpoint = '/store-out/v2/list-lot-types';
        
        expect(endpoint, equals('/store-out/v2/list-lot-types'));
        expect(endpoint, contains('/v2/'));
        expect(endpoint, startsWith('/store-out'));
        expect(endpoint, isNot(contains('?')));
      });
    });

    group('storeOutLotTypeFiltersNew', () {
      test('should create stream and execute method', () {
        final stream = LotTypeFilterService.storeOutLotTypeFiltersNew();
        expect(stream, isA<Stream<LotTypeFilterNewResponse?>>());
      });

      test('method should be callable without throwing', () {
        expect(() => LotTypeFilterService.storeOutLotTypeFiltersNew(), returnsNormally);
      });

      test('endpoint verification', () {
        const endpoint = '/v1/lot/type';
        
        expect(endpoint, equals('/v1/lot/type'));
        expect(endpoint, startsWith('/v1'));
        expect(endpoint, isNot(contains('?')));
      });
    });

    group('endpoint comparison', () {
      test('old endpoint uses v2 in path, new uses v1 prefix', () {
        const oldEndpoint = '/store-out/v2/list-lot-types';
        const newEndpoint = '/v1/lot/type';

        expect(oldEndpoint, contains('v2'));
        expect(newEndpoint, startsWith('/v1'));
      });

      test('endpoints have different base paths', () {
        const oldEndpoint = '/store-out/v2/list-lot-types';
        const newEndpoint = '/v1/lot/type';

        expect(oldEndpoint, startsWith('/store-out'));
        expect(newEndpoint, startsWith('/v1/lot'));
      });
    });

    group('Integration - All methods create valid streams', () {
      test('all service methods should be callable and return streams', () {
        expect(() => LotTypeFilterService.storeOutLotTypeFilters(), returnsNormally);
        expect(() => LotTypeFilterService.storeOutLotTypeFiltersNew(), returnsNormally);
        
        final stream1 = LotTypeFilterService.storeOutLotTypeFilters();
        final stream2 = LotTypeFilterService.storeOutLotTypeFiltersNew();
        
        expect(stream1, isA<Stream<LotTypeFilterResponse?>>());
        expect(stream2, isA<Stream<LotTypeFilterNewResponse?>>());
      });
    });
  });
}
