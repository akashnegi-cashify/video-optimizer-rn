import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/title_value_row_widget.dart';

void main() {
  /// Builds a testable widget with MaterialApp wrapper
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(body: child),
    );
  }

  group('TitleValueRowWidget', () {
    testWidgets('renders correctly with title and value', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const TitleValueRowWidget(
            title: 'Test Title',
            value: 'Test Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TitleValueRowWidget), findsOneWidget);
      expect(find.text('Test Title:'), findsOneWidget);
      expect(find.text('Test Value'), findsOneWidget);
    });

    testWidgets('renders Row with start crossAxisAlignment', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const TitleValueRowWidget(
            title: 'Title',
            value: 'Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final row = tester.widget<Row>(find.byType(Row));
      expect(row.crossAxisAlignment, CrossAxisAlignment.start);
    });

    testWidgets('renders Row with spaceBetween mainAxisAlignment', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const TitleValueRowWidget(
            title: 'Title',
            value: 'Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final row = tester.widget<Row>(find.byType(Row));
      expect(row.mainAxisAlignment, MainAxisAlignment.spaceBetween);
    });

    testWidgets('appends colon to title', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const TitleValueRowWidget(
            title: 'My Title',
            value: 'Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Title should have colon appended
      expect(find.text('My Title:'), findsOneWidget);
      expect(find.text('My Title'), findsNothing);
    });

    testWidgets('renders value in Expanded widget', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const TitleValueRowWidget(
            title: 'Title',
            value: 'Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Expanded), findsOneWidget);
    });

    testWidgets('truncates long value text with ellipsis', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            width: 200,
            child: TitleValueRowWidget(
              title: 'Title',
              value: 'This is a very long value text that should be truncated to fit within the available space',
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      final text = tester.widget<Text>(find.text(
        'This is a very long value text that should be truncated to fit within the available space',
      ));
      expect(text.maxLines, 3);
      expect(text.overflow, TextOverflow.ellipsis);
    });

    testWidgets('allows up to 3 lines for value', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const TitleValueRowWidget(
            title: 'Title',
            value: 'Multi line value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final text = tester.widget<Text>(find.text('Multi line value'));
      expect(text.maxLines, 3);
    });

    testWidgets('renders with empty title', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const TitleValueRowWidget(
            title: '',
            value: 'Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TitleValueRowWidget), findsOneWidget);
      expect(find.text(':'), findsOneWidget); // Empty title with colon
      expect(find.text('Value'), findsOneWidget);
    });

    testWidgets('renders with empty value', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const TitleValueRowWidget(
            title: 'Title',
            value: '',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(TitleValueRowWidget), findsOneWidget);
      expect(find.text('Title:'), findsOneWidget);
    });

    testWidgets('renders SizedBox for spacing between title and value', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const TitleValueRowWidget(
            title: 'Title',
            value: 'Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final sizedBox = find.byWidgetPredicate((widget) =>
          widget is SizedBox && widget.width == Dimens.space_4);
      expect(sizedBox, findsOneWidget);
    });

    testWidgets('renders CshTextNew for title', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const TitleValueRowWidget(
            title: 'Title',
            value: 'Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CshTextNew), findsOneWidget);
    });

    testWidgets('renders with special characters', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const TitleValueRowWidget(
            title: 'Title: @#\$%',
            value: 'Value: &*()!',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Title: @#\$%:'), findsOneWidget);
      expect(find.text('Value: &*()!'), findsOneWidget);
    });

    testWidgets('renders with numeric values', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const TitleValueRowWidget(
            title: 'Count',
            value: '12345',
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Count:'), findsOneWidget);
      expect(find.text('12345'), findsOneWidget);
    });

    testWidgets('renders Text widget for value with theme style', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const TitleValueRowWidget(
            title: 'Title',
            value: 'Styled Value',
          ),
        ),
      );
      await tester.pumpAndSettle();

      final text = tester.widget<Text>(find.text('Styled Value'));
      expect(text.style, isNotNull);
    });
  });
}
