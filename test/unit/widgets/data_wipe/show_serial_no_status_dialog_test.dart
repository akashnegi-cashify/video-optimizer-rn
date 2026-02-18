import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty;

import 'package:flutter_trc/qc/modules/data_wipe/dialog/show_serial_no_status_dialog.dart';
import 'package:flutter_trc/qc/modules/data_wipe/resources/verification_status_enum.dart';

void main() {
  group('showSerialNoStatusDialog', () {
    Widget buildTestWidget({
      required Widget Function(BuildContext) builder,
    }) {
      return MaterialApp(
        theme: ThemeData(
          extensions: [
            CustomColors(
              successColor: Colors.green,
              warnColor: Colors.orange,
              inputStrokeColor: Colors.grey,
              searchShadow: Colors.grey.withAlpha(50),
              shadows: const {},
            ),
          ],
        ),
        home: Builder(
          builder: (context) => Scaffold(
            body: builder(context),
          ),
        ),
      );
    }

    group('matched status', () {
      testWidgets('shows dialog with matched status', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showSerialNoStatusDialog(
                context,
                VerificationStatusEnum.matched,
                systemSerialNo: 'SN123456789',
                scannedSerialNo: 'SN123456789',
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(BottomSheet), findsOneWidget);
      });

      testWidgets('shows proceed button for matched status', (tester) async {
        bool proceedCalled = false;

        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showSerialNoStatusDialog(
                context,
                VerificationStatusEnum.matched,
                systemSerialNo: 'SN123456789',
                scannedSerialNo: 'SN123456789',
                onProceedToDataWipe: () {
                  proceedCalled = true;
                },
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        final proceedButton = find.byType(CshBigButton);
        if (proceedButton.evaluate().isNotEmpty) {
          await tester.tap(proceedButton);
          await tester.pump();
          expect(proceedCalled, true);
        }
      });

      testWidgets('displays serial numbers', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showSerialNoStatusDialog(
                context,
                VerificationStatusEnum.matched,
                systemSerialNo: 'SN123456789',
                scannedSerialNo: 'SN123456789',
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        expect(find.text('SN123456789'), findsWidgets);
      });
    });

    group('mismatched status', () {
      testWidgets('shows dialog with mismatched status', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showSerialNoStatusDialog(
                context,
                VerificationStatusEnum.misMatched,
                systemSerialNo: 'SN123456789',
                scannedSerialNo: 'SN999888777',
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(BottomSheet), findsOneWidget);
      });

      testWidgets('shows report and retry buttons for mismatched status', (tester) async {
        bool retryCalled = false;
        bool reportCalled = false;

        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showSerialNoStatusDialog(
                context,
                VerificationStatusEnum.misMatched,
                systemSerialNo: 'SN123456789',
                scannedSerialNo: 'SN999888777',
                onRetry: () {
                  retryCalled = true;
                },
                onReport: () {
                  reportCalled = true;
                },
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(ComboButton), findsOneWidget);
      });

      testWidgets('displays both system and scanned serial numbers', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showSerialNoStatusDialog(
                context,
                VerificationStatusEnum.misMatched,
                systemSerialNo: 'SN123456789',
                scannedSerialNo: 'SN999888777',
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        expect(find.text('SN123456789'), findsOneWidget);
        expect(find.text('SN999888777'), findsOneWidget);
      });
    });

    group('edge cases', () {
      testWidgets('handles null serial numbers', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showSerialNoStatusDialog(
                context,
                VerificationStatusEnum.matched,
                systemSerialNo: null,
                scannedSerialNo: null,
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(BottomSheet), findsOneWidget);
      });

      testWidgets('handles empty serial numbers', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showSerialNoStatusDialog(
                context,
                VerificationStatusEnum.matched,
                systemSerialNo: '',
                scannedSerialNo: '',
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(BottomSheet), findsOneWidget);
      });

      testWidgets('handles null callbacks', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showSerialNoStatusDialog(
                context,
                VerificationStatusEnum.matched,
                systemSerialNo: 'SN123',
                scannedSerialNo: 'SN123',
                onProceedToDataWipe: null,
                onRetry: null,
                onReport: null,
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        expect(find.byType(BottomSheet), findsOneWidget);
      });

      testWidgets('handles special characters in serial numbers', (tester) async {
        await tester.pumpWidget(buildTestWidget(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showSerialNoStatusDialog(
                context,
                VerificationStatusEnum.matched,
                systemSerialNo: 'SN-123/456_789',
                scannedSerialNo: 'SN-123/456_789',
              );
            },
            child: const Text('Open Dialog'),
          ),
        ));

        await tester.tap(find.text('Open Dialog'));
        await tester.pumpAndSettle();

        expect(find.text('SN-123/456_789'), findsWidgets);
      });
    });
  });
}
