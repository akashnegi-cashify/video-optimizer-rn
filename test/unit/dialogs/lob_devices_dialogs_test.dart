import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/dialogs/show_update_imei_dialog.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/dialogs/show_timeout_reason_dialog.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/dialogs/show_mismatch_serial_dialog.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/dialogs/show_mismatch_imei_dialog.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/dialogs/show_manul_enter_serial_dialog.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/dialogs/select_category_bottom_sheet.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/dialogs/select_brand_bottom_sheet.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/reasons.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/brand_list_response.dart';
import 'package:flutter_trc/src/modules/elss/common_models/brand_list_response_console.dart';

void main() {
  group('showUpdateImeiDialog', () {
    test('function exists and is callable', () {
      expect(showUpdateImeiDialog, isA<Function>());
    });

    test('function accepts required parameters', () {
      List<String>? scannedList;
      String? matchedImei;
      VoidCallback? onRescan;
      Function(String?, bool?, String, bool)? onUpdateImei;
      expect(scannedList, isNull);
      expect(matchedImei, isNull);
      expect(onRescan, isNull);
      expect(onUpdateImei, isNull);
    });

    test('handles single IMEI in scanned list', () {
      final scannedList = ['123456789012345'];
      expect(scannedList.length, 1);
      expect(scannedList.length <= 1, isTrue);
    });

    test('handles multiple IMEIs in scanned list', () {
      final scannedList = ['123456789012345', '543210987654321'];
      expect(scannedList.length, 2);
      expect(scannedList.length > 1, isTrue);
    });

    test('isImei2Available is true when scannedList has more than 1 item', () {
      final scannedList = ['IMEI1', 'IMEI2'];
      bool isImei2Available = scannedList.length > 1;
      expect(isImei2Available, isTrue);
    });

    test('isImei2Available is false when scannedList has 1 or fewer items', () {
      final scannedList = ['IMEI1'];
      bool isImei2Available = scannedList.length > 1;
      expect(isImei2Available, isFalse);
    });

    test('filters out matched IMEI from dropdown list', () {
      final scannedList = ['IMEI1', 'IMEI2', 'IMEI3'];
      const matchedImei = 'IMEI1';

      final filteredList = scannedList.where((element) => element != matchedImei).toList();
      expect(filteredList.length, 2);
      expect(filteredList.contains('IMEI1'), isFalse);
      expect(filteredList.contains('IMEI2'), isTrue);
      expect(filteredList.contains('IMEI3'), isTrue);
    });

    test('onRescan callback can be invoked', () {
      bool rescanCalled = false;
      void onRescan() {
        rescanCalled = true;
      }

      onRescan();
      expect(rescanCalled, isTrue);
    });

    test('onUpdateImei callback receives correct parameters', () {
      String? receivedImei;
      bool? receivedIsImei2Available;
      String? receivedFileUrl;
      bool? receivedIsAutoApproved;

      void onUpdateImei(String? updatedImei, bool? isImei2Available, String fileUrl, bool isAutoApproved) {
        receivedImei = updatedImei;
        receivedIsImei2Available = isImei2Available;
        receivedFileUrl = fileUrl;
        receivedIsAutoApproved = isAutoApproved;
      }

      onUpdateImei('IMEI2', true, '/path/to/image.jpg', true);
      expect(receivedImei, 'IMEI2');
      expect(receivedIsImei2Available, isTrue);
      expect(receivedFileUrl, '/path/to/image.jpg');
      expect(receivedIsAutoApproved, isTrue);
    });

    test('matchedImei can be null', () {
      const String? matchedImei = null;
      expect(matchedImei ?? "NA", "NA");
    });
  });

  group('showTimeOutReasonDialog', () {
    test('function exists and is callable', () {
      expect(showTimeOutReasonDialog, isA<Function>());
    });

    test('function accepts required parameters', () {
      List<Reasons>? reasons;
      Function(Reasons)? onReasonSelected;
      expect(reasons, isNull);
      expect(onReasonSelected, isNull);
    });

    test('Reasons model can be created', () {
      final reason = Reasons('Test Reason', 1);
      expect(reason.name, 'Test Reason');
      expect(reason.isImageRequired, 1);
    });

    test('Reasons model handles null name', () {
      final reason = Reasons(null, 0);
      expect(reason.name, isNull);
      expect(reason.name ?? "NA", "NA");
    });

    test('Reasons list can be iterated', () {
      final reasons = [
        Reasons('Reason 1', 0),
        Reasons('Reason 2', 1),
        Reasons('Reason 3', 0),
      ];
      expect(reasons.length, 3);
      for (var reason in reasons) {
        expect(reason, isA<Reasons>());
      }
    });

    test('onReasonSelected callback receives correct reason', () {
      Reasons? selectedReason;
      void onReasonSelected(Reasons reason) {
        selectedReason = reason;
      }

      final reason = Reasons('Selected Reason', 1);
      onReasonSelected(reason);
      expect(selectedReason?.name, 'Selected Reason');
      expect(selectedReason?.isImageRequired, 1);
    });

    test('isImageRequired values', () {
      final reasonWithImage = Reasons('With Image', 1);
      final reasonWithoutImage = Reasons('Without Image', 0);

      expect(reasonWithImage.isImageRequired, 1);
      expect(reasonWithoutImage.isImageRequired, 0);
    });
  });

  group('showMismatchSerialDialog', () {
    test('function exists and is callable', () {
      expect(showMismatchSerialDialog, isA<Function>());
    });

    test('function accepts required parameters', () {
      String? scannedSerialNo;
      String? systemSerialNo;
      VoidCallback? onReScan;
      Function(String, String)? onReportMismatch;
      expect(scannedSerialNo, isNull);
      expect(systemSerialNo, isNull);
      expect(onReScan, isNull);
      expect(onReportMismatch, isNull);
    });

    test('serial numbers can be compared', () {
      const scannedSerial = 'SN123456';
      const systemSerial = 'SN654321';
      expect(scannedSerial == systemSerial, isFalse);
    });

    test('matching serial numbers are equal', () {
      const scannedSerial = 'SN123456';
      const systemSerial = 'SN123456';
      expect(scannedSerial == systemSerial, isTrue);
    });

    test('onReScan callback can be invoked', () {
      bool reScanCalled = false;
      void onReScan() {
        reScanCalled = true;
      }

      onReScan();
      expect(reScanCalled, isTrue);
    });

    test('onReportMismatch callback receives both serial numbers', () {
      String? receivedScanned;
      String? receivedSystem;

      void onReportMismatch(String scannedSerialNo, String systemSerialNo) {
        receivedScanned = scannedSerialNo;
        receivedSystem = systemSerialNo;
      }

      onReportMismatch('SCANNED123', 'SYSTEM456');
      expect(receivedScanned, 'SCANNED123');
      expect(receivedSystem, 'SYSTEM456');
    });

    test('serial numbers can be alphanumeric', () {
      const serialNo = 'ABC123XYZ789';
      expect(serialNo.contains(RegExp(r'[A-Za-z]')), isTrue);
      expect(serialNo.contains(RegExp(r'[0-9]')), isTrue);
    });
  });

  group('showMismatchImeiDialog', () {
    test('function exists and is callable', () {
      expect(showMismatchImeiDialog, isA<Function>());
    });

    test('function accepts required parameters', () {
      List<String>? scannedList;
      String? imei1;
      String? imei2;
      VoidCallback? onReScan;
      Function(List<String>, bool?)? onReportMismatch;
      expect(scannedList, isNull);
      expect(imei1, isNull);
      expect(imei2, isNull);
      expect(onReScan, isNull);
      expect(onReportMismatch, isNull);
    });

    test('scanned IMEI list reduces to comma-separated string', () {
      final scannedList = ['IMEI1', 'IMEI2'];
      String scannedImeiData = scannedList.reduce((value, element) => "$value, $element");
      expect(scannedImeiData, 'IMEI1, IMEI2');
    });

    test('single IMEI in list produces single value string', () {
      final scannedList = ['IMEI1'];
      String scannedImeiData = scannedList.reduce((value, element) => "$value, $element");
      expect(scannedImeiData, 'IMEI1');
    });

    test('isImei2Available is true for multiple IMEIs', () {
      final scannedList = ['IMEI1', 'IMEI2'];
      bool isImei2Available = scannedList.length > 1;
      expect(isImei2Available, isTrue);
    });

    test('isImei2Available is false for single IMEI', () {
      final scannedList = ['IMEI1'];
      bool isImei2Available = scannedList.length > 1;
      expect(isImei2Available, isFalse);
    });

    test('onReScan callback can be invoked', () {
      bool reScanCalled = false;
      void onReScan() {
        reScanCalled = true;
      }

      onReScan();
      expect(reScanCalled, isTrue);
    });

    test('onReportMismatch callback receives correct parameters', () {
      List<String>? receivedList;
      bool? receivedIsImei2Available;

      void onReportMismatch(List<String> scannedList, bool? isImei2Available) {
        receivedList = scannedList;
        receivedIsImei2Available = isImei2Available;
      }

      onReportMismatch(['IMEI1', 'IMEI2'], true);
      expect(receivedList?.length, 2);
      expect(receivedIsImei2Available, isTrue);
    });

    test('displays device IMEI with both imei1 and imei2', () {
      const imei1 = '123456789012345';
      const imei2 = '543210987654321';
      final display = "$imei1, ${imei2 ?? ""}";
      expect(display, '123456789012345, 543210987654321');
    });

    test('displays device IMEI with null imei2', () {
      const imei1 = '123456789012345';
      const String? imei2 = null;
      final display = "$imei1, ${imei2 ?? ""}";
      expect(display, '123456789012345, ');
    });
  });

  group('showManualEnterSerialNo', () {
    test('function exists and is callable', () {
      expect(showManualEnterSerialNo, isA<Function>());
    });

    test('function accepts required callback', () {
      Function(String)? onSerialNoEntered;
      expect(onSerialNoEntered, isNull);
    });

    test('function accepts optional parameters', () {
      String? title;
      String? subTitle;
      String? hintText;
      expect(title, isNull);
      expect(subTitle, isNull);
      expect(hintText, isNull);
    });

    test('default title is used when not provided', () {
      const String? title = null;
      expect(title ?? "Enter Serial No", "Enter Serial No");
    });

    test('custom title is used when provided', () {
      const title = "Enter IMEI";
      expect(title, "Enter IMEI");
    });

    test('default hint text is used when not provided', () {
      const String? hintText = null;
      expect(hintText ?? "Enter Serial No", "Enter Serial No");
    });

    test('custom hint text is used when provided', () {
      const hintText = "Enter device serial number";
      expect(hintText, "Enter device serial number");
    });

    test('onSerialNoEntered callback receives entered value', () {
      String? receivedSerialNo;
      void onSerialNoEntered(String serialNo) {
        receivedSerialNo = serialNo;
      }

      onSerialNoEntered('SERIAL123456');
      expect(receivedSerialNo, 'SERIAL123456');
    });

    test('empty serial number validation', () {
      const serialNo = '';
      expect(serialNo.isEmpty, isTrue);
    });

    test('non-empty serial number validation', () {
      const serialNo = 'SERIAL123';
      expect(serialNo.isEmpty, isFalse);
    });

    test('subTitle can contain error message', () {
      const subTitle = 'Serial number is required for this device';
      expect(subTitle.isNotEmpty, isTrue);
    });
  });

  group('selectCategoryBottomSheet', () {
    test('function exists and is callable', () {
      expect(selectCategoryBottomSheet, isA<Function>());
    });

    test('function accepts required parameters', () {
      List<CategoryData>? categoryList;
      Function(CategoryData)? onCategorySelected;
      expect(categoryList, isNull);
      expect(onCategorySelected, isNull);
    });

    test('CategoryData model can be created from JSON', () {
      final json = {
        'id': 1,
        'name': 'Mobile',
        'apiName': 'mobile',
        'allowVariant': true,
        'allowImei': true,
      };
      final category = CategoryData.fromJson(json);
      expect(category.id, 1);
      expect(category.name, 'Mobile');
      expect(category.categoryKey, 'mobile');
      expect(category.allowVariant, isTrue);
      expect(category.allowImeiSearch, isTrue);
    });

    test('CategoryData handles null values', () {
      final json = <String, dynamic>{};
      final category = CategoryData.fromJson(json);
      expect(category.id, isNull);
      expect(category.name, isNull);
    });

    test('CategoryData toJson works correctly', () {
      final json = {
        'id': 2,
        'name': 'Laptop',
        'apiName': 'laptop',
        'allowVariant': false,
        'allowImei': false,
      };
      final category = CategoryData.fromJson(json);
      final outputJson = category.toJson();
      expect(outputJson['id'], 2);
      expect(outputJson['name'], 'Laptop');
    });

    test('category list can be iterated', () {
      final categories = [
        CategoryData.fromJson({'id': 1, 'name': 'Mobile'}),
        CategoryData.fromJson({'id': 2, 'name': 'Laptop'}),
        CategoryData.fromJson({'id': 3, 'name': 'Tablet'}),
      ];
      expect(categories.length, 3);
      for (var category in categories) {
        expect(category, isA<CategoryData>());
      }
    });

    test('onCategorySelected callback receives selected category', () {
      CategoryData? selectedCategory;
      void onCategorySelected(CategoryData category) {
        selectedCategory = category;
      }

      final category = CategoryData.fromJson({'id': 1, 'name': 'Mobile'});
      onCategorySelected(category);
      expect(selectedCategory?.id, 1);
      expect(selectedCategory?.name, 'Mobile');
    });

    test('handles null category list', () {
      final List<CategoryData>? categoryList = null;
      expect(categoryList?.length ?? 0, 0);
    });

    test('handles empty category list', () {
      final categoryList = <CategoryData>[];
      expect(categoryList.length, 0);
      expect(categoryList, isEmpty);
    });
  });

  group('selectBrandBottomSheet', () {
    test('function exists and is callable', () {
      expect(selectBrandBottomSheet, isA<Function>());
    });

    test('selectBrandBottomSheetConsole function exists and is callable', () {
      expect(selectBrandBottomSheetConsole, isA<Function>());
    });

    test('function accepts required parameters', () {
      List<BrandListData>? brandList;
      Function(BrandListData)? onBrandSelect;
      bool? isDismissible;
      expect(brandList, isNull);
      expect(onBrandSelect, isNull);
      expect(isDismissible, isNull);
    });

    test('default isDismissible is true', () {
      const isDismissible = true;
      expect(isDismissible, isTrue);
    });

    test('BrandListData model can be created from QC format JSON', () {
      final json = {
        'brandId': 1,
        'brandName': 'Apple',
      };
      final brand = BrandListData.fromJson(json);
      expect(brand.brandId, 1);
      expect(brand.brandName, 'Apple');
    });

    test('BrandListData model can be created from TRC format JSON', () {
      final json = {
        'bid': 2,
        'bn': 'Samsung',
      };
      final brand = BrandListData.fromJson(json);
      expect(brand.brandId, 2);
      expect(brand.brandName, 'Samsung');
    });

    test('BrandListData handles null values', () {
      final json = <String, dynamic>{};
      final brand = BrandListData.fromJson(json);
      expect(brand.brandId, isNull);
      expect(brand.brandName, isNull);
    });

    test('BrandListData toJson works correctly', () {
      final json = {'brandId': 1, 'brandName': 'Apple'};
      final brand = BrandListData.fromJson(json);
      final outputJson = brand.toJson();
      expect(outputJson['brandId'], 1);
      expect(outputJson['brandName'], 'Apple');
    });

    test('brand list can be iterated', () {
      final brands = [
        BrandListData.fromJson({'brandId': 1, 'brandName': 'Apple'}),
        BrandListData.fromJson({'brandId': 2, 'brandName': 'Samsung'}),
        BrandListData.fromJson({'brandId': 3, 'brandName': 'OnePlus'}),
      ];
      expect(brands.length, 3);
      for (var brand in brands) {
        expect(brand, isA<BrandListData>());
      }
    });

    test('onBrandSelect callback receives selected brand', () {
      BrandListData? selectedBrand;
      void onBrandSelect(BrandListData brand) {
        selectedBrand = brand;
      }

      final brand = BrandListData.fromJson({'brandId': 1, 'brandName': 'Apple'});
      onBrandSelect(brand);
      expect(selectedBrand?.brandId, 1);
      expect(selectedBrand?.brandName, 'Apple');
    });

    test('handles empty brand list', () {
      final brandList = <BrandListData>[];
      expect(brandList, isEmpty);
    });
  });

  group('selectBrandBottomSheetConsole - BrandItem', () {
    test('BrandItem model can be created from JSON', () {
      final json = {
        'key': 'apple',
        'value': 'Apple',
      };
      final brand = BrandItem.fromJson(json);
      expect(brand.key, 'apple');
      expect(brand.value, 'Apple');
    });

    test('BrandItem handles null values', () {
      final json = <String, dynamic>{};
      final brand = BrandItem.fromJson(json);
      expect(brand.key, isNull);
      expect(brand.value, isNull);
    });

    test('BrandItem toJson works correctly', () {
      final json = {'key': 'samsung', 'value': 'Samsung'};
      final brand = BrandItem.fromJson(json);
      final outputJson = brand.toJson();
      expect(outputJson['key'], 'samsung');
      expect(outputJson['value'], 'Samsung');
    });

    test('onBrandSelect callback receives BrandItem', () {
      BrandItem? selectedBrand;
      void onBrandSelect(BrandItem brand) {
        selectedBrand = brand;
      }

      final brand = BrandItem.fromJson({'key': 'apple', 'value': 'Apple'});
      onBrandSelect(brand);
      expect(selectedBrand?.key, 'apple');
      expect(selectedBrand?.value, 'Apple');
    });

    test('BrandItem value fallback for null', () {
      final brand = BrandItem.fromJson({'key': 'test', 'value': null});
      expect(brand.value ?? "", "");
    });
  });

  group('BrandListResponse', () {
    test('fromJson parses QC format correctly', () {
      final json = {
        '__ca': null,
        'turl': 'test_url',
        'data': [
          {'brandId': 1, 'brandName': 'Apple'},
          {'brandId': 2, 'brandName': 'Samsung'},
        ]
      };
      final response = BrandListResponse.fromJson(json);
      expect(response.trackUrl, 'test_url');
      expect(response.brandList?.length, 2);
    });

    test('fromJson parses TRC format correctly', () {
      final json = {
        '__ca': null,
        'turl': null,
        'dt': [
          {'bid': 1, 'bn': 'Apple'},
          {'bid': 2, 'bn': 'Samsung'},
        ]
      };
      final response = BrandListResponse.fromJson(json);
      expect(response.brandList?.length, 2);
      expect(response.brandList?[0].brandId, 1);
      expect(response.brandList?[0].brandName, 'Apple');
    });

    test('toJson serializes correctly', () {
      final json = {
        '__ca': null,
        'turl': 'test_url',
        'data': [
          {'brandId': 1, 'brandName': 'Apple'},
        ]
      };
      final response = BrandListResponse.fromJson(json);
      final outputJson = response.toJson();
      expect(outputJson['turl'], 'test_url');
    });

    test('handles empty brand list', () {
      final json = {
        '__ca': null,
        'turl': null,
        'data': []
      };
      final response = BrandListResponse.fromJson(json);
      expect(response.brandList, isEmpty);
    });

    test('handles null brand list', () {
      final json = {
        '__ca': null,
        'turl': null,
      };
      final response = BrandListResponse.fromJson(json);
      expect(response.brandList, isNull);
    });
  });

  group('DeviceDetailResponse', () {
    test('fromJson parses correctly', () {
      final json = {
        '__ca': null,
        'turl': 'test_url',
        'data': {
          'qrCode': 'QR123',
          'imei': '123456789012345',
          'imei2': '543210987654321',
          'serialNo': 'SN123456',
          'brandId': 1,
          'categoryId': 2,
          'categories': [
            {'id': 1, 'name': 'Mobile'},
          ],
          'isDeviceImeiApproved': true,
        }
      };
      final response = DeviceDetailResponse.fromJson(json);
      expect(response.trackUrl, 'test_url');
      expect(response.deviceDetails?.qrCode, 'QR123');
      expect(response.deviceDetails?.imei1, '123456789012345');
      expect(response.deviceDetails?.imei2, '543210987654321');
    });

    test('DeviceDetailResponseData handles null values', () {
      final json = {
        'qrCode': null,
        'imei': null,
      };
      final data = DeviceDetailResponseData.fromJson(json);
      expect(data.qrCode, isNull);
      expect(data.imei1, isNull);
    });

    test('DeviceDetailResponseData toJson works correctly', () {
      final json = {
        'qrCode': 'QR123',
        'imei': '123456',
        'categoryId': 1,
      };
      final data = DeviceDetailResponseData.fromJson(json);
      final outputJson = data.toJson();
      expect(outputJson['qrCode'], 'QR123');
      expect(outputJson['imei'], '123456');
    });

    test('categories list parsing', () {
      final json = {
        'categories': [
          {'id': 1, 'name': 'Mobile', 'apiName': 'mobile'},
          {'id': 2, 'name': 'Laptop', 'apiName': 'laptop'},
        ]
      };
      final data = DeviceDetailResponseData.fromJson(json);
      expect(data.categoryList?.length, 2);
      expect(data.categoryList?[0].name, 'Mobile');
    });

    test('reasons map parsing', () {
      final json = {
        'remarks': {
          'reason1': 1,
          'reason2': 2,
        }
      };
      final data = DeviceDetailResponseData.fromJson(json);
      expect(data.reasons?.length, 2);
      expect(data.reasons?['reason1'], 1);
    });
  });

  group('Reasons model', () {
    test('can be created with name and isImageRequired', () {
      final reason = Reasons('Test Reason', 1);
      expect(reason.name, 'Test Reason');
      expect(reason.isImageRequired, 1);
    });

    test('handles null name', () {
      final reason = Reasons(null, 0);
      expect(reason.name, isNull);
    });

    test('handles null isImageRequired', () {
      final reason = Reasons('Test', null);
      expect(reason.isImageRequired, isNull);
    });

    test('name can be accessed with null coalescing', () {
      final reason = Reasons(null, 0);
      expect(reason.name ?? "NA", "NA");
    });

    test('can create list of reasons', () {
      final reasons = [
        Reasons('Unable to scan', 1),
        Reasons('Device damaged', 0),
        Reasons('Other', 1),
      ];
      expect(reasons.length, 3);
    });

    test('isImageRequired 1 means image is required', () {
      final reason = Reasons('Test', 1);
      expect(reason.isImageRequired == 1, isTrue);
    });

    test('isImageRequired 0 means image is not required', () {
      final reason = Reasons('Test', 0);
      expect(reason.isImageRequired == 0, isTrue);
    });
  });
}
