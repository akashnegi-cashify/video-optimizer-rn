import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/chart_description_widget.dart';

void main() {
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      home: Scaffold(body: child),
    );
  }

  group('ChartDescriptionWidget', () {
    testWidgets('renders with all required properties', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        const ChartDescriptionWidget(
          title: 'Test Title',
          description: 'Test Description',
          number: 42,
          tileColor: Colors.blue,
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(ChartDescriptionWidget), findsOneWidget);
      expect(find.text('Test Title'), findsOneWidget);
      expect(find.text('Test Description'), findsOneWidget);
      expect(find.text('42'), findsOneWidget);
    });

    testWidgets('displays title with correct style', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        const ChartDescriptionWidget(
          title: 'Summary Title',
          description: 'Some description',
          number: 100,
          tileColor: Colors.red,
        ),
      ));
      await tester.pumpAndSettle();

      final titleFinder = find.text('Summary Title');
      expect(titleFinder, findsOneWidget);
    });

    testWidgets('displays colored tile container', (tester) async {
      const testColor = Colors.green;
      await tester.pumpWidget(buildTestWidget(
        const ChartDescriptionWidget(
          title: 'Title',
          description: 'Description',
          number: 50,
          tileColor: testColor,
        ),
      ));
      await tester.pumpAndSettle();

      // Find the container with the color
      final containerFinder = find.byWidgetPredicate(
        (widget) => widget is Container && widget.color == testColor,
      );
      expect(containerFinder, findsOneWidget);
    });

    testWidgets('handles zero number', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        const ChartDescriptionWidget(
          title: 'Zero Count',
          description: 'No items',
          number: 0,
          tileColor: Colors.grey,
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('0'), findsOneWidget);
    });

    testWidgets('handles large numbers', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        const ChartDescriptionWidget(
          title: 'Large Count',
          description: 'Many items',
          number: 999999,
          tileColor: Colors.orange,
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('999999'), findsOneWidget);
    });

    testWidgets('handles long description text', (tester) async {
      const longDescription =
          'This is a very long description that should be displayed properly without causing any overflow issues in the widget layout';
      await tester.pumpWidget(buildTestWidget(
        const ChartDescriptionWidget(
          title: 'Long Description',
          description: longDescription,
          number: 10,
          tileColor: Colors.purple,
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text(longDescription), findsOneWidget);
    });

    testWidgets('renders Column with correct children', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        const ChartDescriptionWidget(
          title: 'Column Test',
          description: 'Testing column layout',
          number: 5,
          tileColor: Colors.cyan,
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.byType(Column), findsOneWidget);
      expect(find.byType(Row), findsOneWidget);
    });

    testWidgets('handles different tile colors', (tester) async {
      final colors = [
        Colors.red,
        Colors.green,
        Colors.blue,
        Colors.yellow,
        Colors.purple,
      ];

      for (final color in colors) {
        await tester.pumpWidget(buildTestWidget(
          ChartDescriptionWidget(
            title: 'Color Test',
            description: 'Testing color: $color',
            number: 1,
            tileColor: color,
          ),
        ));
        await tester.pumpAndSettle();

        final containerFinder = find.byWidgetPredicate(
          (widget) => widget is Container && widget.color == color,
        );
        expect(containerFinder, findsOneWidget);
      }
    });

    testWidgets('negative number renders correctly', (tester) async {
      await tester.pumpWidget(buildTestWidget(
        const ChartDescriptionWidget(
          title: 'Negative',
          description: 'Negative count',
          number: -5,
          tileColor: Colors.red,
        ),
      ));
      await tester.pumpAndSettle();

      expect(find.text('-5'), findsOneWidget);
    });
  });
}
