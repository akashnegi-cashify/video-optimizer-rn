import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_trc/widgets/option_widget_trc.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_option_response.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';

void main() {
  group('PartSelectionOptionWidget', () {
    late int lastGroupValueChanged;
    late int lastApplicableKey;
    late bool lastIsGcs;
    late bool lastIsPna;
    late bool lastIsRub;

    setUp(() {
      lastGroupValueChanged = -1;
      lastApplicableKey = -1;
      lastIsGcs = false;
      lastIsPna = false;
      lastIsRub = false;
    });

    Widget buildTestWidget({
      required OptionResponse dataModel,
      required int keyValue,
      int groupValueKey = -1,
    }) {
      return MaterialApp(
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
          extensions: [CustomColors.light()],
        ),
        home: Scaffold(
          body: ChangeNotifierProvider(
            create: (_) => LocaleProvider(),
            child: PartSelectionOptionWidget(
              dataModel: dataModel,
              keyValue: keyValue,
              groupValueKey: groupValueKey,
              onGroupValueChanged: (value) {
                lastGroupValueChanged = value;
              },
              onApplicableReasonCallback: (key, isGcs, isPna, isRub, {bool isCc = false}) {
                lastApplicableKey = key;
                lastIsGcs = isGcs;
                lastIsPna = isPna;
                lastIsRub = isRub;
              },
            ),
          ),
        ),
      );
    }

    testWidgets('renders without error', (tester) async {
      final dataModel = OptionResponse(
        optionName: 'Option 1',
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        keyValue: 1,
      ));
      await tester.pump();

      expect(find.byType(PartSelectionOptionWidget), findsOneWidget);
    });

    testWidgets('displays option name', (tester) async {
      final dataModel = OptionResponse(
        optionName: 'Test Option',
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        keyValue: 1,
      ));
      await tester.pump();

      expect(find.text('Test Option'), findsOneWidget);
    });

    testWidgets('contains CshRadio widget', (tester) async {
      final dataModel = OptionResponse(
        optionName: 'Option 1',
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        keyValue: 1,
      ));
      await tester.pump();

      expect(find.byType(CshRadio<int>), findsOneWidget);
    });

    testWidgets('shows applicable reason options when selected and required',
        (tester) async {
      final dataModel = OptionResponse(
        optionName: 'Option 1',
        isApplicableReasonRequired: true,
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        keyValue: 1,
        groupValueKey: 1, // Selected
      ));
      await tester.pump();

      // When selected and applicable reason is required, show additional options
      expect(find.text('Rubbing Applicable'), findsOneWidget);
      expect(find.text('PNA Applicable'), findsOneWidget);
      expect(find.text('Glass Change Applicable'), findsOneWidget);
    });

    testWidgets('hides applicable reason options when not selected',
        (tester) async {
      final dataModel = OptionResponse(
        optionName: 'Option 1',
        isApplicableReasonRequired: true,
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        keyValue: 1,
        groupValueKey: 2, // Not selected
      ));
      await tester.pump();

      // When not selected, hide additional options
      expect(find.text('Rubbing Applicable'), findsNothing);
      expect(find.text('PNA Applicable'), findsNothing);
      expect(find.text('Glass Change Applicable'), findsNothing);
    });

    testWidgets(
        'hides applicable reason options when not required even if selected',
        (tester) async {
      final dataModel = OptionResponse(
        optionName: 'Option 1',
        isApplicableReasonRequired: false,
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        keyValue: 1,
        groupValueKey: 1, // Selected
      ));
      await tester.pump();

      // When not required, hide additional options
      expect(find.text('Rubbing Applicable'), findsNothing);
      expect(find.text('PNA Applicable'), findsNothing);
      expect(find.text('Glass Change Applicable'), findsNothing);
    });

    testWidgets('contains Padding widget', (tester) async {
      final dataModel = OptionResponse(
        optionName: 'Option 1',
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        keyValue: 1,
      ));
      await tester.pump();

      expect(find.byType(Padding), findsWidgets);
    });

    testWidgets('contains Column widget', (tester) async {
      final dataModel = OptionResponse(
        optionName: 'Option 1',
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        keyValue: 1,
      ));
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('contains Row widget for option layout', (tester) async {
      final dataModel = OptionResponse(
        optionName: 'Option 1',
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        keyValue: 1,
      ));
      await tester.pump();

      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('radio button triggers callback on change', (tester) async {
      final dataModel = OptionResponse(
        optionName: 'Option 1',
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        keyValue: 1,
        groupValueKey: 2,
      ));
      await tester.pump();

      // Tap the radio button
      await tester.tap(find.byType(CshRadio<int>));
      await tester.pump();

      expect(lastGroupValueChanged, 1);
    });

    testWidgets('displays option name with empty string', (tester) async {
      final dataModel = OptionResponse(
        optionName: '',
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        keyValue: 1,
      ));
      await tester.pump();

      expect(find.byType(PartSelectionOptionWidget), findsOneWidget);
    });

    testWidgets('displays option name with null', (tester) async {
      final dataModel = OptionResponse(
        optionName: null,
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        keyValue: 1,
      ));
      await tester.pump();

      expect(find.byType(PartSelectionOptionWidget), findsOneWidget);
    });
  });
}
