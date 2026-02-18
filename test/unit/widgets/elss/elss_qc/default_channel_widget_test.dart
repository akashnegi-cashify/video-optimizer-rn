import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/default_channel_widget.dart';
import 'package:flutter_trc/src/modules/elss/common_models/channel_option_response.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';

void main() {
  group('DefaultChannelOptionWidget', () {
    Widget buildTestWidget({
      ChannelOptionData? dataModel,
      String title = 'Default Channel',
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
            child: DefaultChannelOptionWidget(
              dataModel: dataModel,
              title: title,
            ),
          ),
        ),
      );
    }

    testWidgets('renders SizedBox.shrink when dataModel is null',
        (tester) async {
      await tester.pumpWidget(buildTestWidget(dataModel: null));
      await tester.pump();

      expect(find.byType(DefaultChannelOptionWidget), findsOneWidget);
      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('displays title when dataModel is provided', (tester) async {
      final dataModel = ChannelOptionData(
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(
        dataModel: dataModel,
        title: 'Default Option',
      ));
      await tester.pump();

      expect(find.text('Default Option'), findsOneWidget);
    });

    testWidgets('displays grade when provided', (tester) async {
      final dataModel = ChannelOptionData(
        grade: 'A',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('A'), findsOneWidget);
    });

    testWidgets('displays channel name when provided', (tester) async {
      final dataModel = ChannelOptionData(
        channelName: 'Retail',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.text('Retail'), findsOneWidget);
    });

    testWidgets('displays price when channelOptionPrice is provided',
        (tester) async {
      final dataModel = ChannelOptionData(
        channelOptionPrice: 1000.0,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.textContaining('Price'), findsOneWidget);
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

    testWidgets('hides grade when null', (tester) async {
      final dataModel = ChannelOptionData(
        grade: null,
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(DefaultChannelOptionWidget), findsOneWidget);
    });

    testWidgets('hides channel name when null', (tester) async {
      final dataModel = ChannelOptionData(
        channelName: null,
        channelOptionPrice: 1000.0,
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(DefaultChannelOptionWidget), findsOneWidget);
    });

    testWidgets('hides price when channelOptionPrice is null', (tester) async {
      final dataModel = ChannelOptionData(
        channelOptionPrice: null,
        channelName: 'Online',
      );
      await tester.pumpWidget(buildTestWidget(dataModel: dataModel));
      await tester.pump();

      expect(find.byType(DefaultChannelOptionWidget), findsOneWidget);
    });
  });
}
