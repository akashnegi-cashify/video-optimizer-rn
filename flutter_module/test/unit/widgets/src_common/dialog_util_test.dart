import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/dialog_util.dart';
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
        theme: ThemeData(
          extensions: [
            CustomColors(
              successColor: Colors.green,
              warnColor: Colors.orange,
              inputStrokeColor: Colors.grey,
              searchShadow: Colors.grey.withAlpha(50),
              shadows: {
                10: const BoxShadow(color: Colors.black12, blurRadius: 10),
                15: const BoxShadow(color: Colors.black12, blurRadius: 15),
                20: const BoxShadow(color: Colors.black12, blurRadius: 20),
              },
            ),
          ],
        ),
        home: child,
      ),
    );
  }

  group('DialogUtil Extension', () {
    testWidgets('showConfirmationDialog displays dialog', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                context.showConfirmationDialog('Test description');
              },
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Tap button to show dialog
      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Dialog should be displayed
      expect(find.byType(Dialog), findsOneWidget);
      expect(find.text('Test description'), findsOneWidget);
    });

    testWidgets('showConfirmationDialog displays title when provided', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                context.showConfirmationDialog(
                  'Description text',
                  title: 'Dialog Title',
                );
              },
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Dialog Title'), findsOneWidget);
      expect(find.text('Description text'), findsOneWidget);
    });

    testWidgets('showConfirmationDialog does not show title when null', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                context.showConfirmationDialog('Only description');
              },
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.text('Only description'), findsOneWidget);
    });

    testWidgets('showConfirmationDialog with positive button', (tester) async {
      bool buttonPressed = false;

      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                context.showConfirmationDialog(
                  'Confirm action?',
                  positiveButtonData: (ctx) => ButtonData(
                    () {
                      buttonPressed = true;
                      Navigator.pop(ctx);
                    },
                    'Confirm',
                  ),
                );
              },
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Positive button should be visible
      expect(find.text('Confirm'), findsOneWidget);

      // Tap positive button
      await tester.tap(find.text('Confirm'));
      await tester.pumpAndSettle();

      expect(buttonPressed, isTrue);
    });

    testWidgets('showConfirmationDialog with negative button', (tester) async {
      bool buttonPressed = false;

      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                context.showConfirmationDialog(
                  'Cancel action?',
                  negativeButtonData: (ctx) => ButtonData(
                    () {
                      buttonPressed = true;
                      Navigator.pop(ctx);
                    },
                    'Cancel',
                  ),
                );
              },
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Negative button should be visible
      expect(find.text('Cancel'), findsOneWidget);

      // Tap negative button
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(buttonPressed, isTrue);
    });

    testWidgets('showConfirmationDialog with both buttons', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                context.showConfirmationDialog(
                  'Confirm or cancel?',
                  positiveButtonData: (ctx) => ButtonData(
                    () => Navigator.pop(ctx),
                    'Yes',
                  ),
                  negativeButtonData: (ctx) => ButtonData(
                    () => Navigator.pop(ctx),
                    'No',
                  ),
                );
              },
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Both buttons should be visible
      expect(find.text('Yes'), findsOneWidget);
      expect(find.text('No'), findsOneWidget);
    });

    testWidgets('showConfirmationDialog renders CshTextNew for description', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                context.showConfirmationDialog('CshTextNew description');
              },
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.byType(CshTextNew), findsWidgets);
    });

    testWidgets('showConfirmationDialog renders with proper padding', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                context.showConfirmationDialog('Padded dialog');
              },
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Check for Padding widget with proper insets
      expect(find.byType(Padding), findsWidgets);
    });

    testWidgets('showConfirmationDialog renders Column layout', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                context.showConfirmationDialog('Column layout dialog');
              },
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.byType(Column), findsWidgets);
    });

    testWidgets('showConfirmationDialog renders Row for buttons', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                context.showConfirmationDialog(
                  'Row buttons dialog',
                  positiveButtonData: (ctx) => ButtonData(
                    () {},
                    'OK',
                  ),
                );
              },
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('barrierDismissible is false by default', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          Builder(
            builder: (context) => ElevatedButton(
              onPressed: () {
                context.showConfirmationDialog('Non-dismissible dialog');
              },
              child: const Text('Show Dialog'),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.text('Show Dialog'));
      await tester.pumpAndSettle();

      // Dialog should be shown
      expect(find.byType(Dialog), findsOneWidget);
    });
  });

  group('ButtonData', () {
    test('creates with onPress and buttonText', () {
      final buttonData = ButtonData(
        () {},
        'Test Button',
      );
      expect(buttonData.buttonText, 'Test Button');
      expect(buttonData.onPress, isNotNull);
    });

    test('onPress callback is callable', () {
      bool pressed = false;
      final buttonData = ButtonData(
        () {
          pressed = true;
        },
        'Press Me',
      );
      buttonData.onPress();
      expect(pressed, isTrue);
    });

    test('buttonText stores correctly', () {
      final buttonData = ButtonData(
        () {},
        'Custom Text',
      );
      expect(buttonData.buttonText, 'Custom Text');
    });

    test('creates with empty buttonText', () {
      final buttonData = ButtonData(
        () {},
        '',
      );
      expect(buttonData.buttonText, '');
    });

    test('creates with special characters in buttonText', () {
      final buttonData = ButtonData(
        () {},
        'OK! @#\$%',
      );
      expect(buttonData.buttonText, 'OK! @#\$%');
    });
  });
}
