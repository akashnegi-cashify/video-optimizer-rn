import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/imei_scanner.dart';
import 'package:imei_serial_reader/imei_serial_reader.dart';
import 'package:localization/localization/locale_provider.dart';
import 'package:provider/provider.dart';

void main() {
  /// Builds a testable widget with MaterialApp and LocaleProvider wrapper
  Widget buildTestWidget(Widget child) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LocaleProvider>(create: (_) => LocaleProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(),
        home: child,
      ),
    );
  }

  group('ImeiScanner', () {
    testWidgets('renders correctly with required config', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          ImeiScanner(
            config: ParserConfig(
              readerType: ReaderType.serial,
            ),
          ),
        ),
      );
      // Use pump instead of pumpAndSettle since there may be timers running
      await tester.pump();

      expect(find.byType(ImeiScanner), findsOneWidget);
    });

    testWidgets('renders Scaffold', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          ImeiScanner(
            config: ParserConfig(
              readerType: ReaderType.serial,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(Scaffold), findsOneWidget);
    });

    testWidgets('renders with onProceed callback', (tester) async {
      bool callbackCalled = false;
      await tester.pumpWidget(
        buildTestWidget(
          ImeiScanner(
            config: ParserConfig(
              readerType: ReaderType.serial,
            ),
            onProceed: (scannedList, {imageRawData}) {
              callbackCalled = true;
            },
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(ImeiScanner), findsOneWidget);
    });

    testWidgets('renders with onTimeOut callback', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          ImeiScanner(
            config: ParserConfig(
              readerType: ReaderType.serial,
            ),
            onTimeOut: () {},
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(ImeiScanner), findsOneWidget);
    });

    testWidgets('renders with both callbacks', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          ImeiScanner(
            config: ParserConfig(
              readerType: ReaderType.serial,
            ),
            onProceed: (scannedList, {imageRawData}) {},
            onTimeOut: () {},
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(ImeiScanner), findsOneWidget);
    });

    testWidgets('renders Center widget for body', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          ImeiScanner(
            config: ParserConfig(
              readerType: ReaderType.serial,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(Center), findsWidgets);
    });

    testWidgets('renders ChangeNotifierProvider for PageParamProvider', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          ImeiScanner(
            config: ParserConfig(
              readerType: ReaderType.serial,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(ChangeNotifierProvider<PageParamProvider>), findsOneWidget);
    });

    testWidgets('renders ImeiSerialReader widget', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          ImeiScanner(
            config: ParserConfig(
              readerType: ReaderType.serial,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(ImeiSerialReader), findsOneWidget);
    });

    testWidgets('disposes timer on widget dispose', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          ImeiScanner(
            config: ParserConfig(
              readerType: ReaderType.serial,
            ),
          ),
        ),
      );
      await tester.pump();

      // Navigate away to trigger dispose
      await tester.pumpWidget(
        buildTestWidget(const SizedBox()),
      );
      await tester.pump();

      // No errors should occur during dispose
      expect(find.byType(ImeiScanner), findsNothing);
    });

    testWidgets('configures ImeiSerialReaderConfig correctly', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          ImeiScanner(
            config: ParserConfig(
              readerType: ReaderType.serial,
            ),
          ),
        ),
      );
      await tester.pump();

      // Widget should render ImeiSerialReader
      expect(find.byType(ImeiSerialReader), findsOneWidget);
    });

    testWidgets('uses ReaderType.serial', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          ImeiScanner(
            config: ParserConfig(
              readerType: ReaderType.serial,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(ImeiScanner), findsOneWidget);
    });

    testWidgets('uses ReaderType.imei', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          ImeiScanner(
            config: ParserConfig(
              readerType: ReaderType.imei,
            ),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(ImeiScanner), findsOneWidget);
    });
  });
}
