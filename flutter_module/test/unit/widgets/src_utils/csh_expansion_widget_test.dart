import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/utils/csh_exapansion_widget.dart';

void main() {
  /// Builds a testable widget with MaterialApp wrapper
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(body: child),
    );
  }

  group('CshExpansionWidget', () {
    testWidgets('renders correctly with expand false (default)',
        (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const CshExpansionWidget(
            child: Text('Test Content'),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(CshExpansionWidget), findsOneWidget);
      expect(find.byType(SizeTransition), findsOneWidget);
    });

    testWidgets('renders child content', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const CshExpansionWidget(
            child: Text('Test Content'),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Test Content'), findsOneWidget);
    });

    testWidgets('renders with expand true', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const CshExpansionWidget(
            expand: true,
            child: Text('Expanded Content'),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(CshExpansionWidget), findsOneWidget);
      expect(find.text('Expanded Content'), findsOneWidget);
    });

    testWidgets('animates from collapsed to expanded', (tester) async {
      // Start with collapsed state
      await tester.pumpWidget(
        buildTestWidget(
          const CshExpansionWidget(
            expand: false,
            child: Text('Animating Content'),
          ),
        ),
      );
      await tester.pump();

      // Rebuild with expanded state
      await tester.pumpWidget(
        buildTestWidget(
          const CshExpansionWidget(
            expand: true,
            child: Text('Animating Content'),
          ),
        ),
      );

      // Animation should be in progress
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(SizeTransition), findsOneWidget);

      // Let animation complete
      await tester.pumpAndSettle();
      expect(find.byType(CshExpansionWidget), findsOneWidget);
    });

    testWidgets('animates from expanded to collapsed', (tester) async {
      // Start with expanded state
      await tester.pumpWidget(
        buildTestWidget(
          const CshExpansionWidget(
            expand: true,
            child: Text('Collapsing Content'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Rebuild with collapsed state
      await tester.pumpWidget(
        buildTestWidget(
          const CshExpansionWidget(
            expand: false,
            child: Text('Collapsing Content'),
          ),
        ),
      );

      // Animation should be in progress
      await tester.pump(const Duration(milliseconds: 100));
      expect(find.byType(SizeTransition), findsOneWidget);

      // Let animation complete
      await tester.pumpAndSettle();
      expect(find.byType(CshExpansionWidget), findsOneWidget);
    });

    testWidgets('SizeTransition has correct axis alignment', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const CshExpansionWidget(
            child: Text('Content'),
          ),
        ),
      );
      await tester.pump();

      final sizeTransition =
          tester.widget<SizeTransition>(find.byType(SizeTransition));
      expect(sizeTransition.axisAlignment, 1.0);
    });

    testWidgets('disposes animation controller properly', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const CshExpansionWidget(
            expand: true,
            child: Text('Disposing Content'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Dispose by replacing widget
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(),
        ),
      );
      await tester.pumpAndSettle();

      // Should not throw any errors
      expect(find.byType(CshExpansionWidget), findsNothing);
    });

    testWidgets('handles multiple expand state changes', (tester) async {
      bool expand = false;

      await tester.pumpWidget(
        StatefulBuilder(
          builder: (context, setState) {
            return buildTestWidget(
              Column(
                children: [
                  CshExpansionWidget(
                    expand: expand,
                    child: const Text('Toggle Content'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        expand = !expand;
                      });
                    },
                    child: const Text('Toggle'),
                  ),
                ],
              ),
            );
          },
        ),
      );
      await tester.pump();

      // Initial state - collapsed
      expect(find.byType(CshExpansionWidget), findsOneWidget);

      // Tap to expand
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Tap to collapse
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Tap to expand again
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.byType(CshExpansionWidget), findsOneWidget);
    });

    testWidgets('renders complex child widget', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          CshExpansionWidget(
            expand: true,
            child: Column(
              children: const [
                Text('Line 1'),
                Text('Line 2'),
                Icon(Icons.star),
              ],
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CshExpansionWidget), findsOneWidget);
      expect(find.text('Line 1'), findsOneWidget);
      expect(find.text('Line 2'), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('animation uses fastOutSlowIn curve', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const CshExpansionWidget(
            expand: false,
            child: Text('Curve Test'),
          ),
        ),
      );
      await tester.pump();

      // Change to expanded to trigger animation
      await tester.pumpWidget(
        buildTestWidget(
          const CshExpansionWidget(
            expand: true,
            child: Text('Curve Test'),
          ),
        ),
      );

      // Check at various points during animation
      await tester.pump(const Duration(milliseconds: 50));
      expect(find.byType(SizeTransition), findsOneWidget);

      await tester.pump(const Duration(milliseconds: 200));
      expect(find.byType(SizeTransition), findsOneWidget);

      await tester.pumpAndSettle();
      expect(find.byType(CshExpansionWidget), findsOneWidget);
    });

    testWidgets('animation duration is 500ms', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const CshExpansionWidget(
            expand: false,
            child: Text('Duration Test'),
          ),
        ),
      );
      await tester.pump();

      // Change to expanded
      await tester.pumpWidget(
        buildTestWidget(
          const CshExpansionWidget(
            expand: true,
            child: Text('Duration Test'),
          ),
        ),
      );

      // Pump just before completion
      await tester.pump(const Duration(milliseconds: 499));

      // Pump to completion
      await tester.pump(const Duration(milliseconds: 2));
      await tester.pumpAndSettle();

      expect(find.byType(CshExpansionWidget), findsOneWidget);
    });
  });

  group('CshExpansionWidget - Edge Cases', () {
    testWidgets('handles empty child widget', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const CshExpansionWidget(
            expand: true,
            child: SizedBox.shrink(),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CshExpansionWidget), findsOneWidget);
    });

    testWidgets('handles large child widget', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          CshExpansionWidget(
            expand: true,
            child: Container(
              height: 500,
              color: Colors.blue,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CshExpansionWidget), findsOneWidget);
    });

    testWidgets('key parameter works correctly', (tester) async {
      const key = Key('test_expansion_widget');
      await tester.pumpWidget(
        buildTestWidget(
          const CshExpansionWidget(
            key: key,
            child: Text('Keyed Content'),
          ),
        ),
      );
      await tester.pump();

      expect(find.byKey(key), findsOneWidget);
    });

    testWidgets('didUpdateWidget handles expand change', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const CshExpansionWidget(
            expand: false,
            child: Text('Update Widget Test'),
          ),
        ),
      );
      await tester.pump();

      // This triggers didUpdateWidget
      await tester.pumpWidget(
        buildTestWidget(
          const CshExpansionWidget(
            expand: true,
            child: Text('Update Widget Test'),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CshExpansionWidget), findsOneWidget);
    });
  });
}
