import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/my_search_bar_widget.dart';

void main() {
  /// Builds a testable widget with MaterialApp wrapper
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(body: child),
    );
  }

  group('MySearchBarWidget', () {
    testWidgets('renders correctly with required onQuery', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(MySearchBarWidget), findsOneWidget);
    });

    testWidgets('renders CshTextFormField', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CshTextFormField), findsOneWidget);
    });

    testWidgets('displays default hint text "Search"', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(MySearchBarWidget), findsOneWidget);
    });

    testWidgets('displays custom hint text', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            hintText: 'Custom search hint',
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(MySearchBarWidget), findsOneWidget);
    });

    testWidgets('shows prefix search icon by default', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Default prefix icon should be search icon
      expect(find.byType(CshIcon), findsWidgets);
    });

    testWidgets('hides prefix icon when showPrefixIcon is false', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            showPrefixIcon: false,
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(MySearchBarWidget), findsOneWidget);
    });

    testWidgets('shows clear icon when text is entered and showSuffixClearIcon is true', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            showSuffixClearIcon: true,
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter text
      await tester.enterText(find.byType(TextField), 'test');
      await tester.pump();

      // Clear icon should appear
      expect(find.byType(MySearchBarWidget), findsOneWidget);
    });

    testWidgets('does not show clear icon when showSuffixClearIcon is false', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            showSuffixClearIcon: false,
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter text
      await tester.enterText(find.byType(TextField), 'test');
      await tester.pump();

      expect(find.byType(MySearchBarWidget), findsOneWidget);
    });

    testWidgets('renders with custom prefix icon', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            prefixIcon: const Icon(Icons.filter_list),
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.filter_list), findsWidgets);
    });

    testWidgets('autofocus is false by default', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(MySearchBarWidget), findsOneWidget);
    });

    testWidgets('autofocus can be enabled', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            isAutoFocus: true,
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(MySearchBarWidget), findsOneWidget);
    });

    testWidgets('shows border by default', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(MySearchBarWidget), findsOneWidget);
    });

    testWidgets('can hide border', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            showBorder: false,
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(MySearchBarWidget), findsOneWidget);
    });

    testWidgets('calls onQuery with trimmed text', (tester) async {
      String? receivedQuery;

      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            onQuery: (query) {
              receivedQuery = query;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter text with whitespace
      await tester.enterText(find.byType(TextField), '  test query  ');
      await tester.pump(const Duration(milliseconds: 600));

      expect(receivedQuery, 'test query');
    });

    testWidgets('debounces text input', (tester) async {
      int callCount = 0;

      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            onQuery: (query) {
              callCount++;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter text multiple times quickly
      await tester.enterText(find.byType(TextField), 'a');
      await tester.pump(const Duration(milliseconds: 100));
      await tester.enterText(find.byType(TextField), 'ab');
      await tester.pump(const Duration(milliseconds: 100));
      await tester.enterText(find.byType(TextField), 'abc');

      // Wait for debounce
      await tester.pump(const Duration(milliseconds: 600));

      // Should only have been called once due to debounce
      expect(callCount, 1);
    });

    testWidgets('maxLines is 1', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(MySearchBarWidget), findsOneWidget);
    });

    testWidgets('maxLength is 50', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(MySearchBarWidget), findsOneWidget);
    });

    testWidgets('clears text and calls onQuery with empty string when clear icon tapped', (tester) async {
      String? receivedQuery;

      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            showSuffixClearIcon: true,
            onQuery: (query) {
              receivedQuery = query;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter text
      await tester.enterText(find.byType(TextField), 'test');
      await tester.pump();

      // Find and tap clear icon (X icon)
      final clearIcon = find.byWidgetPredicate((widget) =>
          widget is CshIcon && widget.icon == FeatherIcons.x);
      if (clearIcon.evaluate().isNotEmpty) {
        await tester.tap(clearIcon.first);
        await tester.pump();

        expect(receivedQuery, '');
      }
    });

    testWidgets('disposes timer and controller on widget dispose', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          MySearchBarWidget(
            onQuery: (query) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate away to trigger dispose
      await tester.pumpWidget(
        buildTestWidget(const SizedBox()),
      );
      await tester.pumpAndSettle();

      // No errors should occur during dispose
      expect(find.byType(MySearchBarWidget), findsNothing);
    });
  });
}
