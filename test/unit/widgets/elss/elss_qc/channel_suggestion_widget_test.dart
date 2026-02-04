import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/channel_suggestion_widget.dart';
import 'package:flutter_trc/src/modules/elss/common_models/channel_option_response.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_part.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';

void main() {
  group('ChannelSuggestionWidget', () {
    late bool onCardSelectedCalled;

    setUp(() {
      onCardSelectedCalled = false;
    });

    Widget buildTestWidget({
      ChannelOptionData? dataModel,
      String title = 'Test Title',
      bool? isCardElevated,
      Function()? onCardSelected,
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
              child: ChannelSuggestionWidget(
                dataModel: dataModel,
                title: title,
                isCardElevated: isCardElevated,
                onCardSelected: onCardSelected,
              ),
            ),
          ),
        ),
      );
    }

    testWidgets('renders SizedBox.shrink when dataModel is null',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(dataModel: null));
      await tester.pump();

      expect(find.byType(ChannelSuggestionWidget), findsOneWidget);
      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('displays title when dataModel is provided', (tester) async {
      final dataModel = ChannelOptionData(
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        title: 'Initial Platform Suggestion',
      ));
      await tester.pump();

      expect(find.text('Initial Platform Suggestion'), findsOneWidget);
    });

    testWidgets('displays channel name when provided', (tester) async {
      final dataModel = ChannelOptionData(
        channelName: 'Retail',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('Retail'), findsOneWidget);
    });

    testWidgets('displays grade when provided', (tester) async {
      final dataModel = ChannelOptionData(
        grade: 'A',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('A'), findsOneWidget);
    });

    testWidgets('displays repair type when provided', (tester) async {
      final dataModel = ChannelOptionData(
        repairType: 'Minor Repair',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('Minor Repair'), findsOneWidget);
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

    testWidgets('shows CshCard when isCardElevated is true', (tester) async {
      final dataModel = ChannelOptionData(
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        isCardElevated: true,
      ));
      await tester.pump();

      expect(find.byType(CshCard), findsOneWidget);
    });

    testWidgets('shows CshIcon when onCardSelected is provided',
        (tester) async {
      final dataModel = ChannelOptionData(
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        onCardSelected: () {
          onCardSelectedCalled = true;
        },
      ));
      await tester.pump();

      expect(find.byType(CshIcon), findsOneWidget);
    });

    testWidgets('hides CshIcon when onCardSelected is null', (tester) async {
      final dataModel = ChannelOptionData(
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        onCardSelected: null,
      ));
      await tester.pump();

      expect(find.byType(CshIcon), findsNothing);
    });

    testWidgets('onCardSelected callback is triggered when tapped',
        (tester) async {
      final dataModel = ChannelOptionData(
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        onCardSelected: () {
          onCardSelectedCalled = true;
        },
      ));
      await tester.pump();

      await tester.tap(find.byType(GestureDetector).first);
      await tester.pump();

      expect(onCardSelectedCalled, true);
    });

    testWidgets('displays list of SKUs when requestedParts is provided',
        (tester) async {
      final dataModel = ChannelOptionData(
        requestedParts: [
          ElssPart(sku: 'SKU-001', partName: 'Screen'),
          ElssPart(sku: 'SKU-002', partName: 'Battery'),
        ],
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('List Of SKUs'), findsOneWidget);
    });

    testWidgets('contains Container widget', (tester) async {
      final dataModel = ChannelOptionData(
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('contains Column widget', (tester) async {
      final dataModel = ChannelOptionData(
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('contains Row widget', (tester) async {
      final dataModel = ChannelOptionData(
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('contains Padding widget', (tester) async {
      final dataModel = ChannelOptionData(
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(Padding), findsWidgets);
    });

    testWidgets('contains SizedBox for spacing', (tester) async {
      final dataModel = ChannelOptionData(
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(SizedBox), findsWidgets);
    });
  });
}
