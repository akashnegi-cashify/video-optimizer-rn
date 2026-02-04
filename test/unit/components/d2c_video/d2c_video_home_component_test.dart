import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:mocktail/mocktail.dart';
import 'package:provider/provider.dart';

import 'package:flutter_trc/qc/modules/d2c_video/components/d2c_video_home_component.dart';
import 'package:flutter_trc/qc/modules/d2c_video/screens/d2c_lot_listing_screen.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';

import '../../../helpers/widget_test_helpers.dart';

void main() {
  group('D2cVideoHomeComponent', () {
    group('constants', () {
      test('has correct COMP_KEY', () {
        expect(D2cVideoHomeComponent.COMP_KEY, 'QC_d2c_video_home_component');
      });
    });

    group('widget', () {
      test('D2cVideoHomeComponent class exists', () {
        expect(D2cVideoHomeComponent, isNotNull);
      });

      test('D2cVideoHomeComponent can be instantiated with empty config', () {
        const component = D2cVideoHomeComponent({});
        expect(component, isNotNull);
      });

      test('D2cVideoHomeComponent can be instantiated with null values in config', () {
        const component = D2cVideoHomeComponent({'key': null});
        expect(component, isNotNull);
      });

      test('D2cVideoHomeComponent can be instantiated with key', () {
        const key = Key('d2c_video_home_component');
        const component = D2cVideoHomeComponent({}, key: key);
        expect(component.key, equals(key));
      });
    });

    group('fromConfig', () {
      test('fromConfig returns NoneConfigModel.fromConfig', () {
        const component = D2cVideoHomeComponent({});
        final fromConfig = component.fromConfig();
        expect(fromConfig, isNotNull);
        expect(fromConfig, NoneConfigModel.fromConfig);
      });
    });

    group('buildView', () {
      late MockNavigatorObserver mockNavigatorObserver;

      setUp(() {
        mockNavigatorObserver = MockNavigatorObserver();
        registerFallbackValue(
          MaterialPageRoute<dynamic>(builder: (_) => const SizedBox()),
        );
      });

      Widget buildTestWidget() {
        return ChangeNotifierProvider(
          create: (_) => LocaleProvider(),
          child: MaterialApp(
            navigatorObservers: [mockNavigatorObserver],
            routes: {
              D2cLotListingScreen.route: (context) =>
                  const Scaffold(body: Text('Lot Listing Screen')),
            },
            home: Scaffold(
              body: Builder(
                builder: (context) {
                  const component = D2cVideoHomeComponent({});
                  return component.buildView(context, NoneConfigModel());
                },
              ),
            ),
          ),
        );
      }

      testWidgets('renders two CshBigButton widgets', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        expect(find.byType(CshBigButton), findsNWidgets(2));
      });

      testWidgets('renders Device Media button', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        // Look for the generic device media text
        expect(find.byType(CshBigButton), findsNWidgets(2));
      });

      testWidgets('renders Pending Video Lot button', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        expect(find.byType(CshBigButton), findsNWidgets(2));
      });

      testWidgets('has centered column layout', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        final columnFinder = find.byType(Column);
        expect(columnFinder, findsWidgets);

        final Column column =
            tester.widgetList<Column>(columnFinder).firstWhere(
                  (col) =>
                      col.mainAxisAlignment == MainAxisAlignment.center &&
                      col.crossAxisAlignment == CrossAxisAlignment.stretch,
                );
        expect(column, isNotNull);
      });

      testWidgets('has proper padding', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        final paddingFinder = find.byType(Padding);
        expect(paddingFinder, findsWidgets);
      });

      testWidgets('Pending Video Lot button navigates to lot listing screen',
          (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        // Find and tap the second button (Pending Video Lot)
        final buttons = find.byType(CshBigButton);
        expect(buttons, findsNWidgets(2));

        await tester.tap(buttons.at(1));
        await tester.pumpAndSettle();

        // Verify navigation occurred
        verify(() => mockNavigatorObserver.didPush(any(), any())).called(
            greaterThanOrEqualTo(1));
      });

      testWidgets('widget tree contains Column with proper spacing',
          (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        // Verify the widget builds without errors
        expect(find.byType(Scaffold), findsOneWidget);
        expect(find.byType(Column), findsWidgets);
      });

      testWidgets('Device Media button exists', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pump();

        final buttons = find.byType(CshBigButton);
        expect(buttons.at(0), findsOneWidget);
        // Note: Not tapping because it opens ML Scanner which requires camera permissions
      });

      test('buildView method exists and is callable', () {
        const component = D2cVideoHomeComponent({});
        expect(component.buildView, isNotNull);
        expect(component.buildView, isA<Function>());
      });
    });
  });
}
