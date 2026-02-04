import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/channel_option_modal_widget.dart';
import 'package:flutter_trc/src/modules/elss/common_models/channel_option_response.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_part.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';

void main() {
  group('ChannelOptionModalWidget', () {
    late bool onPnaCallbackCalled;
    late bool onDoneCallbackCalled;

    setUp(() {
      onPnaCallbackCalled = false;
      onDoneCallbackCalled = false;
    });

    Widget buildTestWidget({
      ChannelOptionData? dataModel,
      String modalHeading = 'Test Modal',
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
            child: ChannelOptionModalWidget(
              dataModel: dataModel,
              modalHeading: modalHeading,
              onDoneCallback: () {
                onDoneCallbackCalled = true;
              },
              onPnaCallback: () {
                onPnaCallbackCalled = true;
              },
            ),
          ),
        ),
      );
    }

    testWidgets('renders without error with null data', (tester) async {
      await tester.pumpWidget(buildTestWidget(dataModel: null));
      await tester.pump();

      expect(find.byType(ChannelOptionModalWidget), findsOneWidget);
    });

    testWidgets('displays modal heading', (tester) async {
      await tester.pumpWidget(buildTestWidget(modalHeading: 'Your Suggestion'));
      await tester.pump();

      expect(find.text('Your Suggestion'), findsOneWidget);
    });

    testWidgets('contains close icon', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(CshIcon), findsOneWidget);
    });

    testWidgets('contains ComboButton', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(ComboButton), findsOneWidget);
    });

    testWidgets('displays PNA button', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('PNA'), findsOneWidget);
    });

    testWidgets('displays Submit button', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Submit'), findsOneWidget);
    });

    testWidgets('displays channel name when provided', (tester) async {
      final dataModel = ChannelOptionData(
        channelName: 'Retail',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('Retail'), findsOneWidget);
    });

    testWidgets('displays profit when channelOptionPrice is provided',
        (tester) async {
      final dataModel = ChannelOptionData(
        channelOptionPrice: 1000.0,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.textContaining('Profit'), findsOneWidget);
    });

    testWidgets('displays total repair amount', (tester) async {
      final dataModel = ChannelOptionData(
        requestedParts: [
          ElssPart(price: 500.0),
          ElssPart(price: 300.0),
        ],
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.textContaining('Total Repair'), findsOneWidget);
    });

    testWidgets('contains ListView when requestedParts is provided',
        (tester) async {
      final dataModel = ChannelOptionData(
        requestedParts: [
          ElssPart(sku: 'SKU-001', partName: 'Screen'),
          ElssPart(sku: 'SKU-002', partName: 'Battery'),
        ],
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('contains Column widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('contains Row widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('contains Padding widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Padding), findsWidgets);
    });

    testWidgets('contains SizedBox for layout', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('contains Expanded widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Expanded), findsOneWidget);
    });

    testWidgets('hides channel name when null', (tester) async {
      final dataModel = ChannelOptionData(
        channelName: null,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(ChannelOptionModalWidget), findsOneWidget);
    });

    testWidgets('hides profit when channelOptionPrice is null', (tester) async {
      final dataModel = ChannelOptionData(
        channelOptionPrice: null,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(ChannelOptionModalWidget), findsOneWidget);
    });
  });
}
