import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:flutter_trc/qc/modules/data_wipe/components/data_wipe_list_component.dart';
import 'package:flutter_trc/qc/modules/data_wipe/providers/data_wipe_list_provider.dart';
import 'package:flutter_trc/qc/modules/data_wipe/widgets/data_wipe_list_widget.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

void main() {
  group('DataWipeListComponent', () {
    group('constants', () {
      test('has correct COMP_KEY', () {
        expect(DataWipeListComponent.COMP_KEY, 'QC_data_wipe_list_component');
      });
    });

    group('widget', () {
      test('DataWipeListComponent class exists', () {
        expect(DataWipeListComponent, isNotNull);
      });

      test('DataWipeListComponent can be instantiated with empty config', () {
        const component = DataWipeListComponent({});
        expect(component, isNotNull);
      });

      test('DataWipeListComponent can be instantiated with null values in config', () {
        const component = DataWipeListComponent({'key': null});
        expect(component, isNotNull);
      });

      test('DataWipeListComponent can be instantiated with key', () {
        const key = Key('data_wipe_list_component');
        const component = DataWipeListComponent({}, key: key);
        expect(component.key, equals(key));
      });
    });

    group('fromConfig', () {
      test('fromConfig returns NoneConfigModel.fromConfig', () {
        const component = DataWipeListComponent({});
        final fromConfig = component.fromConfig();
        expect(fromConfig, isNotNull);
        expect(fromConfig, NoneConfigModel.fromConfig);
      });
    });

    group('buildView', () {
      test('buildView method exists and is callable', () {
        const component = DataWipeListComponent({});
        expect(component.buildView, isNotNull);
        expect(component.buildView, isA<Function>());
      });

      testWidgets('buildView returns ChangeNotifierProvider wrapping DataWipeListWidget',
          (tester) async {
        const component = DataWipeListComponent({});
        Widget? builtWidget;

        await tester.pumpWidget(
          MaterialApp(
            home: Builder(
              builder: (context) {
                builtWidget = component.buildView(context, NoneConfigModel());
                // Return placeholder since widget makes API call on init
                return const SizedBox();
              },
            ),
          ),
        );

        await tester.pump();
        expect(builtWidget, isA<ChangeNotifierProvider<DataWipeListProvider>>());
      });

      test('DataWipeListWidget class exists and is StatefulWidget', () {
        expect(DataWipeListWidget, isNotNull);
        const widget = DataWipeListWidget();
        expect(widget, isA<StatefulWidget>());
      });

      test('DataWipeListProvider class exists and can be instantiated', () {
        expect(DataWipeListProvider, isNotNull);
        // Can instantiate directly since constructor doesn't make API calls
        final provider = DataWipeListProvider();
        expect(provider, isNotNull);
        expect(provider.forceHideBulkErase, false);
        expect(provider.bulkEraseStatusAllowed, isNull);
      });

      test('DataWipeListProvider.of static method exists', () {
        expect(DataWipeListProvider.of, isNotNull);
      });

      test('component structure is correct', () {
        const component = DataWipeListComponent({});
        expect(component.fromConfig(), equals(NoneConfigModel.fromConfig));
        expect(DataWipeListComponent.COMP_KEY, 'QC_data_wipe_list_component');
      });
    });
  });
}
