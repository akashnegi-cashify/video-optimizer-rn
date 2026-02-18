import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/channel_options_card_widget.dart';
import 'package:flutter_trc/src/modules/elss/common_models/channel_option_response.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';

void main() {
  group('ChannelOptionCardWidget', () {
    late bool onCardTapCalled;

    setUp(() {
      onCardTapCalled = false;
    });

    Widget buildTestWidget({
      ChannelOptionData? dataModel,
      Function()? onCardTap,
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
            child: ChannelOptionCardWidget(
              dataModel: dataModel,
              onCardTap: onCardTap,
            ),
          ),
        ),
      );
    }

    testWidgets('renders SizedBox.shrink when dataModel is null',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(dataModel: null));
      await tester.pump();

      expect(find.byType(ChannelOptionCardWidget), findsOneWidget);
      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('renders SizedBox.shrink when channelOptionPrice is null',
        (tester) async {
      final dataModel = ChannelOptionData(
        channelOptionPrice: null,
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(CshCard), findsNothing);
    });

    testWidgets('renders SizedBox.shrink when channelName is null',
        (tester) async {
      final dataModel = ChannelOptionData(
        channelOptionPrice: 1000.0,
        channelName: null,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(CshCard), findsNothing);
    });

    testWidgets('renders card when both price and channelName are provided',
        (tester) async {
      final dataModel = ChannelOptionData(
        channelOptionPrice: 1000.0,
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(CshCard), findsOneWidget);
    });

    testWidgets('displays channel name when provided', (tester) async {
      final dataModel = ChannelOptionData(
        channelOptionPrice: 1000.0,
        channelName: 'Retail',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('Retail'), findsOneWidget);
    });

    testWidgets('displays Channel Suggestion Cost text', (tester) async {
      final dataModel = ChannelOptionData(
        channelOptionPrice: 1000.0,
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.textContaining('Channel Suggestion Cost'), findsOneWidget);
    });

    testWidgets('displays Repair Type text', (tester) async {
      final dataModel = ChannelOptionData(
        channelOptionPrice: 1000.0,
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.textContaining('Repair Type'), findsOneWidget);
    });

    testWidgets('contains GestureDetector', (tester) async {
      final dataModel = ChannelOptionData(
        channelOptionPrice: 1000.0,
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(GestureDetector), findsOneWidget);
    });

    testWidgets('onCardTap callback is triggered when tapped', (tester) async {
      final dataModel = ChannelOptionData(
        channelOptionPrice: 1000.0,
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        onCardTap: () {
          onCardTapCalled = true;
        },
      ));
      await tester.pump();

      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      expect(onCardTapCalled, true);
    });

    testWidgets('does not crash when onCardTap is null', (tester) async {
      final dataModel = ChannelOptionData(
        channelOptionPrice: 1000.0,
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        onCardTap: null,
      ));
      await tester.pump();

      await tester.tap(find.byType(GestureDetector));
      await tester.pump();

      expect(find.byType(ChannelOptionCardWidget), findsOneWidget);
    });

    testWidgets('contains CshIcon for chevron', (tester) async {
      final dataModel = ChannelOptionData(
        channelOptionPrice: 1000.0,
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(CshIcon), findsOneWidget);
    });

    testWidgets('contains Row widget', (tester) async {
      final dataModel = ChannelOptionData(
        channelOptionPrice: 1000.0,
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('contains Column widget', (tester) async {
      final dataModel = ChannelOptionData(
        channelOptionPrice: 1000.0,
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('contains Container widget', (tester) async {
      final dataModel = ChannelOptionData(
        channelOptionPrice: 1000.0,
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(Container), findsWidgets);
    });
  });
}
