import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/components/stock_in_product_detail_component.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/components/search_item_component.dart';
import 'package:flutter_trc/qc/modules/stock_in_module/components/media_file_upload_component.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('StockInProductDetailComponent', () {
    test('has correct COMP_KEY', () {
      expect(StockInProductDetailComponent.COMP_KEY, 'QC_qc_stock_in_product_detail_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = StockInProductDetailComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = StockInProductDetailComponent({});
      expect(component, isNotNull);
    });
  });

  group('SearchItemComponent', () {
    test('has correct COMP_KEY', () {
      expect(SearchItemComponent.COMP_KEY, 'QC_qc_search_item_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = SearchItemComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = SearchItemComponent({});
      expect(component, isNotNull);
    });
  });

  group('MediaFileUploadComponent', () {
    test('has correct COMP_KEY', () {
      expect(MediaFileUploadComponent.COMP_KEY, 'QC_qc_media_file_upload_component');
    });

    test('fromConfig returns NoneConfigModel.fromConfig', () {
      const component = MediaFileUploadComponent({});
      expect(component.fromConfig(), NoneConfigModel.fromConfig);
    });

    test('can be instantiated with empty config', () {
      const component = MediaFileUploadComponent({});
      expect(component, isNotNull);
    });
  });
}
