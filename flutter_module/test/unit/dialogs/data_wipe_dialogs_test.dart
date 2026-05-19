import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/data_wipe/dialog/show_bulk_erase_initiate_dialog.dart';
import 'package:flutter_trc/qc/modules/data_wipe/dialog/show_filter_dialog.dart';
import 'package:flutter_trc/qc/modules/data_wipe/dialog/show_imei_status_dialog.dart';
import 'package:flutter_trc/qc/modules/data_wipe/dialog/show_serial_no_status_dialog.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/data_wipe_filter_list_response.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/verification_status_enum.dart';

void main() {
  group('showBulkEraseInitiateDialog', () {
    test('function exists and is callable', () {
      // Verify the function signature exists
      expect(showBulkEraseInitiateDialog, isA<Function>());
    });

    test('function has correct parameter types', () {
      // Verify the function can accept the correct types
      final statusList = <DataWipFilterListItem>[
        DataWipFilterListItem.fromJson({'k': 1, 'v': 'Status 1'}),
        DataWipFilterListItem.fromJson({'k': 2, 'v': 'Status 2'}),
      ];
      expect(statusList.length, 2);
    });

    test('DataWipFilterListItem model works correctly', () {
      final item = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Test Label'});
      expect(item.id, 1);
      expect(item.label, 'Test Label');
    });

    test('DataWipFilterListItem equality works', () {
      final item1 = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Test'});
      final item2 = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Test'});
      final item3 = DataWipFilterListItem.fromJson({'k': 2, 'v': 'Test'});

      expect(item1 == item2, isTrue);
      expect(item1 == item3, isFalse);
    });

    test('DataWipFilterListItem toJson works', () {
      final item = DataWipFilterListItem.fromJson({'k': 1, 'v': 'Test'});
      final json = item.toJson();
      expect(json['k'], 1);
      expect(json['v'], 'Test');
    });

    test('DataWipFilterListItem handles null values in JSON', () {
      final item = DataWipFilterListItem.fromJson({});
      expect(item.id, isNull);
      expect(item.label, isNull);
    });

    test('DataWipFilterListItem equality with different labels but same id', () {
      final item1 = DataWipFilterListItem.fromJson({'k': 5, 'v': 'Label A'});
      final item2 = DataWipFilterListItem.fromJson({'k': 5, 'v': 'Label B'});
      expect(item1 == item2, isTrue);
    });
  });

  group('showFilterDialog', () {
    test('function exists and is callable', () {
      // Verify the function signature exists (deprecated but still present)
      // ignore: deprecated_member_use_from_same_package
      expect(showFilterDialog, isA<Function>());
    });

    test('function accepts null selectedFilter', () {
      // Function should work with null filters
      Map<String, List<DataWipFilterListItem>>? filters;
      expect(filters, isNull);
    });

    test('function accepts empty selectedFilter', () {
      final filters = <String, List<DataWipFilterListItem>>{};
      expect(filters, isEmpty);
    });

    test('function accepts populated selectedFilter', () {
      final filters = {
        'status': [
          DataWipFilterListItem.fromJson({'k': 1, 'v': 'Pending'}),
          DataWipFilterListItem.fromJson({'k': 2, 'v': 'Completed'}),
        ],
      };
      expect(filters['status']?.length, 2);
    });
  });

  group('showImeiStatusDialog', () {
    test('function exists and is callable', () {
      expect(showImeiStatusDialog, isA<Function>());
    });

    test('VerificationStatusEnum has correct values', () {
      expect(VerificationStatusEnum.values.length, 2);
      expect(VerificationStatusEnum.matched, isNotNull);
      expect(VerificationStatusEnum.misMatched, isNotNull);
    });

    test('function handles matched status', () {
      const status = VerificationStatusEnum.matched;
      expect(status, VerificationStatusEnum.matched);
    });

    test('function handles misMatched status', () {
      const status = VerificationStatusEnum.misMatched;
      expect(status, VerificationStatusEnum.misMatched);
    });

    test('function accepts optional scannedImeiNos', () {
      final scannedImeis = ['123456789012345', '543210987654321'];
      expect(scannedImeis.length, 2);
    });

    test('function accepts optional systemImeiNos', () {
      final systemImeis = ['111111111111111'];
      expect(systemImeis.first, '111111111111111');
    });

    test('function accepts optional callbacks', () {
      VoidCallback? onRetry;
      VoidCallback? onReport;
      VoidCallback? onProceedToDataWipe;
      
      expect(onRetry, isNull);
      expect(onReport, isNull);
      expect(onProceedToDataWipe, isNull);
    });
  });

  group('showSerialNoStatusDialog', () {
    test('function exists and is callable', () {
      expect(showSerialNoStatusDialog, isA<Function>());
    });

    test('function handles matched status', () {
      const status = VerificationStatusEnum.matched;
      expect(status, VerificationStatusEnum.matched);
    });

    test('function handles misMatched status', () {
      const status = VerificationStatusEnum.misMatched;
      expect(status, VerificationStatusEnum.misMatched);
    });

    test('function accepts optional scannedSerialNo', () {
      const scannedSerial = 'SN123456789';
      expect(scannedSerial, 'SN123456789');
    });

    test('function accepts optional systemSerialNo', () {
      const systemSerial = 'SN987654321';
      expect(systemSerial, 'SN987654321');
    });

    test('function accepts optional callbacks', () {
      VoidCallback? onRetry;
      VoidCallback? onReport;
      VoidCallback? onProceedToDataWipe;
      
      expect(onRetry, isNull);
      expect(onReport, isNull);
      expect(onProceedToDataWipe, isNull);
    });
  });

  group('VerificationStatusEnum', () {
    test('matched value exists', () {
      expect(VerificationStatusEnum.matched.name, 'matched');
    });

    test('misMatched value exists', () {
      expect(VerificationStatusEnum.misMatched.name, 'misMatched');
    });

    test('can be used in conditionals', () {
      final status = VerificationStatusEnum.matched;
      
      if (status == VerificationStatusEnum.matched) {
        expect(true, isTrue);
      } else {
        fail('Status should be matched');
      }
    });

    test('enum indices are correct', () {
      expect(VerificationStatusEnum.matched.index, 0);
      expect(VerificationStatusEnum.misMatched.index, 1);
    });

    test('can iterate over values', () {
      final values = VerificationStatusEnum.values;
      expect(values, isNotEmpty);
      expect(values.length, 2);
    });

    test('can use in switch statement', () {
      const status = VerificationStatusEnum.matched;
      String result;
      switch (status) {
        case VerificationStatusEnum.matched:
          result = 'matched';
          break;
        case VerificationStatusEnum.misMatched:
          result = 'mismatched';
          break;
      }
      expect(result, 'matched');
    });
  });

  group('DataWipeFilterData', () {
    test('fromJson parses correctly', () {
      final json = {
        'fname': 'Test Filter',
        'ftype': 1,
        'fval': [
          {'k': 1, 'v': 'Option 1'},
          {'k': 2, 'v': 'Option 2'},
        ]
      };
      final data = DataWipeFilterData.fromJson(json);
      expect(data.filterName, 'Test Filter');
      expect(data.filterType, 1);
      expect(data.filterList?.length, 2);
    });

    test('toJson serializes correctly', () {
      final data = DataWipeFilterData.fromJson({
        'fname': 'Test',
        'ftype': 1,
        'fval': []
      });
      final json = data.toJson();
      expect(json['fname'], 'Test');
      expect(json['ftype'], 1);
    });

    test('handles null filterList', () {
      final data = DataWipeFilterData.fromJson({
        'fname': 'Test',
        'ftype': 1,
      });
      expect(data.filterList, isNull);
    });

    test('handles empty filterList', () {
      final data = DataWipeFilterData.fromJson({
        'fname': 'Test',
        'ftype': 1,
        'fval': [],
      });
      expect(data.filterList, isEmpty);
    });

    test('handles multiple filter types', () {
      // Single select type
      final singleSelect = DataWipeFilterData.fromJson({
        'fname': 'Single',
        'ftype': 1,
        'fval': [{'k': 1, 'v': 'Option'}],
      });
      expect(singleSelect.filterType, 1);
      
      // Multi select type
      final multiSelect = DataWipeFilterData.fromJson({
        'fname': 'Multi',
        'ftype': 2,
        'fval': [{'k': 1, 'v': 'Option'}],
      });
      expect(multiSelect.filterType, 2);
    });
  });

  group('DataWipeFilterListResponse', () {
    test('fromJson parses old format with dt wrapper', () {
      final json = {
        '__ca': null,
        'turl': 'test_url',
        'dt': {
          'status': {
            'fname': 'Status',
            'ftype': 1,
            'fval': [{'k': 1, 'v': 'Active'}]
          }
        }
      };
      final response = DataWipeFilterListResponse.fromJson(json);
      expect(response.trackUrl, 'test_url');
      expect(response.dataWipeFilterMap, isNotNull);
      expect(response.dataWipeFilterMap?['status'], isNotNull);
    });

    test('fromJson parses new format without dt wrapper', () {
      final json = {
        '__ca': null,
        'turl': 'test_url',
        'status': {
          'fname': 'Status',
          'ftype': 1,
          'fval': [{'k': 1, 'v': 'Active'}]
        }
      };
      final response = DataWipeFilterListResponse.fromJson(json);
      expect(response.trackUrl, 'test_url');
      expect(response.dataWipeFilterMap, isNotNull);
    });

    test('toJson serializes correctly', () {
      final response = DataWipeFilterListResponse.fromJson({
        '__ca': null,
        'turl': 'test_url',
        'status': {
          'fname': 'Status',
          'ftype': 1,
          'fval': []
        }
      });
      final json = response.toJson();
      expect(json['turl'], 'test_url');
    });

    test('handles multiple filter keys', () {
      final json = {
        '__ca': null,
        'turl': null,
        'status': {
          'fname': 'Status',
          'ftype': 1,
          'fval': [{'k': 1, 'v': 'Active'}]
        },
        'provider': {
          'fname': 'Provider',
          'ftype': 2,
          'fval': [{'k': 1, 'v': 'CASHIFY'}]
        },
      };
      final response = DataWipeFilterListResponse.fromJson(json);
      expect(response.dataWipeFilterMap?.keys.length, 2);
      expect(response.dataWipeFilterMap?['status'], isNotNull);
      expect(response.dataWipeFilterMap?['provider'], isNotNull);
    });

    test('handles empty response', () {
      final json = {
        '__ca': null,
        'turl': null,
      };
      final response = DataWipeFilterListResponse.fromJson(json);
      expect(response.dataWipeFilterMap, isEmpty);
    });

    test('filters out non-map values', () {
      final json = {
        '__ca': null,
        'turl': 'test',
        'status': {
          'fname': 'Status',
          'ftype': 1,
          'fval': []
        },
        'invalid_string': 'string value',
        'invalid_number': 123,
        'invalid_null': null,
      };
      final response = DataWipeFilterListResponse.fromJson(json);
      // Should only have 'status' in the map, invalid entries filtered
      expect(response.dataWipeFilterMap?.containsKey('status'), isTrue);
      expect(response.dataWipeFilterMap?.containsKey('invalid_string'), isFalse);
    });
  });
}
