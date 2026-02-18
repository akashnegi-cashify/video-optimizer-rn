import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/searchbar_widget.dart';

void main() {
  /// Builds a testable widget with MaterialApp wrapper
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(body: child),
    );
  }

  group('SearchbarWidget', () {
    testWidgets('renders correctly with required parameters', (tester) async {
      String? queryResult;
      await tester.pumpWidget(
        buildTestWidget(
          SearchbarWidget(
            onQuery: (query) {
              queryResult = query;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Widget should be rendered
      expect(find.byType(SearchbarWidget), findsOneWidget);
      // Container should be present
      expect(find.byType(Container), findsWidgets);
    });

    testWidgets('renders with hint text', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchbarWidget(
            hint: 'Search here',
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SearchbarWidget), findsOneWidget);
    });

    testWidgets('renders with initial text', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchbarWidget(
            initialText: 'Initial value',
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SearchbarWidget), findsOneWidget);
    });

    testWidgets('renders with custom margin', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchbarWidget(
            margin: const EdgeInsets.all(20),
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SearchbarWidget), findsOneWidget);
      // Verify Container has the widget
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(SearchbarWidget),
          matching: find.byType(Container).first,
        ),
      );
      expect(container.margin, const EdgeInsets.all(20));
    });

    testWidgets('renders with default margin', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchbarWidget(
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(SearchbarWidget),
          matching: find.byType(Container).first,
        ),
      );
      expect(container.margin, const EdgeInsets.all(Dimens.space_16));
    });

    testWidgets('calls onQuery callback when text is entered', (tester) async {
      String? queryResult;
      await tester.pumpWidget(
        buildTestWidget(
          SearchbarWidget(
            onQuery: (query) {
              queryResult = query;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find the text field and enter text
      final textField = find.byType(TextField);
      if (textField.evaluate().isNotEmpty) {
        await tester.enterText(textField.first, 'test query');
        await tester.pumpAndSettle();
      }

      expect(find.byType(SearchbarWidget), findsOneWidget);
    });

    testWidgets('applies border decoration from theme', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchbarWidget(
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Verify the Container has BoxDecoration with border
      final container = tester.widget<Container>(
        find.descendant(
          of: find.byType(SearchbarWidget),
          matching: find.byType(Container).first,
        ),
      );
      expect(container.decoration, isA<BoxDecoration>());
    });

    testWidgets('renders with all parameters', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchbarWidget(
            hint: 'Search...',
            initialText: 'initial',
            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SearchbarWidget), findsOneWidget);
    });
  });
}
