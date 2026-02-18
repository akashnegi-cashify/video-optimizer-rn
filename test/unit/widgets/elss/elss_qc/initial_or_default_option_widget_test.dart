import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/initial_or_default_option_widget.dart';
import 'package:flutter_trc/src/modules/elss/common_models/channel_option_response.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_part.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';

void main() {
  group('InitialOrDefaultWidget', () {
    Widget buildTestWidget({
      ChannelOptionData? channelData,
      String channelTitle = 'Initial Suggestion',
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
            child: SingleChildScrollView(
              child: InitialOrDefaultWidget(
                channelData: channelData,
                channelTitle: channelTitle,
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('renders without error with null data', (tester) async {
      await tester.pumpWidget(buildTestWidget(channelData: null));
      await tester.pump();

      expect(find.byType(InitialOrDefaultWidget), findsOneWidget);
    });

    testWidgets('displays channel title', (tester) async {
      await tester.pumpWidget(
          buildTestWidget(channelTitle: 'Initial Platform Suggestion'));
      await tester.pump();

      expect(find.text('Initial Platform Suggestion'), findsOneWidget);
    });

    testWidgets('displays channel name when provided', (tester) async {
      final channelData = ChannelOptionData(
        channelName: 'Retail',
      );
      await tester.pumpWidget(buildTestWidget(channelData: channelData));
      await tester.pump();

      expect(find.text('Retail'), findsOneWidget);
    });

    testWidgets('displays price when channelOptionPrice is provided',
        (tester) async {
      final channelData = ChannelOptionData(
        channelOptionPrice: 1000.0,
      );
      await tester.pumpWidget(buildTestWidget(channelData: channelData));
      await tester.pump();

      expect(find.textContaining('Price'), findsOneWidget);
    });

    testWidgets('displays List of SKUs text when requestedParts is provided',
        (tester) async {
      final channelData = ChannelOptionData(
        requestedParts: [
          ElssPart(sku: 'SKU-001', partName: 'Screen'),
          ElssPart(sku: 'SKU-002', partName: 'Battery'),
        ],
      );
      await tester.pumpWidget(buildTestWidget(channelData: channelData));
      await tester.pump();

      expect(find.text('List Of SKUs'), findsOneWidget);
    });

    testWidgets('contains ExpansionTile when requestedParts is provided',
        (tester) async {
      final channelData = ChannelOptionData(
        requestedParts: [
          ElssPart(sku: 'SKU-001', partName: 'Screen'),
        ],
      );
      await tester.pumpWidget(buildTestWidget(channelData: channelData));
      await tester.pump();

      expect(find.byType(ExpansionTile), findsOneWidget);
    });

    testWidgets('hides ExpansionTile when requestedParts is null',
        (tester) async {
      final channelData = ChannelOptionData(
        requestedParts: null,
      );
      await tester.pumpWidget(buildTestWidget(channelData: channelData));
      await tester.pump();

      expect(find.byType(ExpansionTile), findsNothing);
    });

    testWidgets('hides ExpansionTile when requestedParts is empty',
        (tester) async {
      final channelData = ChannelOptionData(
        requestedParts: [],
      );
      await tester.pumpWidget(buildTestWidget(channelData: channelData));
      await tester.pump();

      expect(find.byType(ExpansionTile), findsNothing);
    });

    testWidgets('contains Container widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Container), findsWidgets);
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

    testWidgets('contains SizedBox for spacing', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('hides channel name when null', (tester) async {
      final channelData = ChannelOptionData(
        channelName: null,
      );
      await tester.pumpWidget(buildTestWidget(channelData: channelData));
      await tester.pump();

      expect(find.byType(InitialOrDefaultWidget), findsOneWidget);
    });

    testWidgets('hides price when channelOptionPrice is null', (tester) async {
      final channelData = ChannelOptionData(
        channelOptionPrice: null,
      );
      await tester.pumpWidget(buildTestWidget(channelData: channelData));
      await tester.pump();

      expect(find.byType(InitialOrDefaultWidget), findsOneWidget);
    });
  });
}
