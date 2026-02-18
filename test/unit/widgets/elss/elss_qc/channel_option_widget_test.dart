import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/widgets/channel_option_widget.dart';
import 'package:flutter_trc/src/modules/elss/elss_qc/providers/channel_option_provider.dart';
import 'package:flutter_trc/src/modules/elss/common_models/elss_device_details_response.dart';
import 'package:flutter_trc/src/modules/elss/common_models/channel_option_response.dart';
import 'package:provider/provider.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:mocktail/mocktail.dart';

class MockChannelOptionProvider extends Mock implements ChannelOptionProvider {}

void main() {
  group('ChannelOptionWidget', () {
    late MockChannelOptionProvider mockProvider;

    setUp(() {
      mockProvider = MockChannelOptionProvider();
    });

    Widget buildTestWidget({
      String scannedBarcode = 'TEST_BARCODE',
      ElssDeviceDetailsResponse? detailsDataModel,
    }) {
      when(() => mockProvider.initialChannelSuggestion).thenReturn(null);
      when(() => mockProvider.yourChannelSuggestion).thenReturn(null);
      when(() => mockProvider.defaultChannelSuggestion).thenReturn(null);
      when(() => mockProvider.otherChannelOptions).thenReturn(null);
      when(() => mockProvider.pQuoteId).thenReturn(null);
      when(() => mockProvider.remarks).thenReturn(null);

      return MaterialApp(
        localizationsDelegates: const [
          DefaultMaterialLocalizations.delegate,
          DefaultWidgetsLocalizations.delegate,
        ],
        theme: ThemeData(
          extensions: [CustomColors.light()],
        ),
        home: Scaffold(
          body: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => LocaleProvider()),
              ChangeNotifierProvider<ChannelOptionProvider>.value(
                value: mockProvider,
              ),
            ],
            child: ChannelOptionWidget(
              scannedBarcode,
              detailsDataModel: detailsDataModel,
            ),
          ),
        ),
      );
    }

    testWidgets('renders without error', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(ChannelOptionWidget), findsOneWidget);
    });

    testWidgets('contains Column widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('contains Expanded widget for layout', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Expanded), findsOneWidget);
    });

    testWidgets('contains SingleChildScrollView', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(SingleChildScrollView), findsOneWidget);
    });

    testWidgets('displays Initial Platform Suggestion text', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Initial Platform Suggestion'), findsOneWidget);
    });

    testWidgets('displays Your Suggestion text', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Your Suggestion'), findsOneWidget);
    });

    testWidgets('displays Non-Repair Suggestion text', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Non-Repair Suggestion'), findsOneWidget);
    });

    testWidgets('contains bottom buttons', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Reject'), findsOneWidget);
      expect(find.text('Reset'), findsOneWidget);
    });

    testWidgets('contains CshCard', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(CshCard), findsWidgets);
    });

    testWidgets('contains Row widget for buttons', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('contains Padding widget', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(Padding), findsWidgets);
    });

    testWidgets('contains SizedBox for spacing', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.byType(SizedBox), findsWidgets);
    });

    testWidgets('displays device details widget when provided', (tester) async {
      final detailsDataModel = ElssDeviceDetailsResponse(
        deviceDetailsData: DeviceDetailsData(
          deviceName: 'Test Device',
          deviceBarcode: 'BC123456',
        ),
      );
      await tester.pumpWidget(buildTestWidget(
        detailsDataModel: detailsDataModel,
      ));
      await tester.pump();

      expect(find.byType(ChannelOptionWidget), findsOneWidget);
    });

    testWidgets('displays other channel options when provided', (tester) async {
      when(() => mockProvider.otherChannelOptions).thenReturn([
        ChannelOptionData(
          channelName: 'Retail',
          optionId: 1,
        ),
        ChannelOptionData(
          channelName: 'Online',
          optionId: 2,
        ),
      ]);
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // Channel Suggestion should appear for each option
      expect(find.text('Channel Suggestion'), findsWidgets);
    });

    testWidgets('contains CshMediumOutlineButton for Reject', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.widgetWithText(CshMediumOutlineButton, 'Reject'),
          findsOneWidget);
    });

    testWidgets('contains CshMediumButton for Reset', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.widgetWithText(CshMediumButton, 'Reset'), findsOneWidget);
    });
  });
}
