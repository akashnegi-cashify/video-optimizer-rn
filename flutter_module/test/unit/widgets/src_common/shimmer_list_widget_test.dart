import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';

void main() {
  /// Builds a testable widget with MaterialApp wrapper
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(body: child),
    );
  }

  group('ShimmerListWidget', () {
    testWidgets('renders correctly with default parameters', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            height: 500,
            child: ShimmerListWidget(),
          ),
        ),
      );
      // Use pump instead of pumpAndSettle because shimmer has continuous animations
      await tester.pump();

      expect(find.byType(ShimmerListWidget), findsOneWidget);
      expect(find.byType(ListView), findsOneWidget);
    });

    testWidgets('renders with custom itemCount', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            height: 500,
            child: ShimmerListWidget(itemCount: 3),
          ),
        ),
      );
      // Use pump instead of pumpAndSettle because shimmer has continuous animations
      await tester.pump();

      expect(find.byType(ShimmerListWidget), findsOneWidget);
      expect(find.byType(CshShimmer), findsNWidgets(3));
    });

    testWidgets('renders with custom itemHeight', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            height: 500,
            child: ShimmerListWidget(
              itemHeight: 80,
              itemCount: 2,
            ),
          ),
        ),
      );
      // Use pump instead of pumpAndSettle because shimmer has continuous animations
      await tester.pump();

      expect(find.byType(ShimmerListWidget), findsOneWidget);
      // Verify shimmer height
      final shimmer = tester.widget<CshShimmer>(find.byType(CshShimmer).first);
      expect(shimmer.height, 80);
    });

    testWidgets('renders with custom itemWidth', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            height: 500,
            width: 300,
            child: ShimmerListWidget(
              itemWidth: 200,
              itemCount: 1,
            ),
          ),
        ),
      );
      // Use pump instead of pumpAndSettle because shimmer has continuous animations
      await tester.pump();

      expect(find.byType(ShimmerListWidget), findsOneWidget);
      final shimmer = tester.widget<CshShimmer>(find.byType(CshShimmer).first);
      expect(shimmer.width, 200);
    });

    testWidgets('renders with custom itemPadding', (tester) async {
      const customPadding = EdgeInsets.symmetric(vertical: 10, horizontal: 20);
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            height: 500,
            child: ShimmerListWidget(
              itemPadding: customPadding,
              itemCount: 2,
            ),
          ),
        ),
      );
      // Use pump instead of pumpAndSettle because shimmer has continuous animations
      await tester.pump();

      expect(find.byType(ShimmerListWidget), findsOneWidget);
      final padding = tester.widget<Padding>(find.byType(Padding).first);
      expect(padding.padding, customPadding);
    });

    testWidgets('uses LayoutBuilder for calculating items', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            height: 500,
            child: ShimmerListWidget(),
          ),
        ),
      );
      // Use pump instead of pumpAndSettle because shimmer has continuous animations
      await tester.pump();

      expect(find.byType(LayoutBuilder), findsOneWidget);
    });

    testWidgets('renders ListView with shrinkWrap true', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            height: 500,
            child: ShimmerListWidget(),
          ),
        ),
      );
      // Use pump instead of pumpAndSettle because shimmer has continuous animations
      await tester.pump();

      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.shrinkWrap, isTrue);
    });

    testWidgets('renders Align widget for each shimmer item', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            height: 500,
            child: ShimmerListWidget(itemCount: 2),
          ),
        ),
      );
      // Use pump instead of pumpAndSettle because shimmer has continuous animations
      await tester.pump();

      expect(find.byType(Align), findsNWidgets(2));
    });

    testWidgets('renders with custom height parameter', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            height: 800,
            child: ShimmerListWidget(
              height: 400,
              itemCount: 2,
            ),
          ),
        ),
      );
      // Use pump instead of pumpAndSettle because shimmer has continuous animations
      await tester.pump();

      expect(find.byType(ShimmerListWidget), findsOneWidget);
    });

    testWidgets('throws exception when itemCount cannot fit', (tester) async {
      // This should throw because we're trying to fit more items than possible
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            height: 100, // Very small height
            child: ShimmerListWidget(
              itemCount: 50, // Too many items
              itemHeight: 100,
            ),
          ),
        ),
      );

      expect(tester.takeException(), isA<Exception>());
    });

    testWidgets('renders with default itemHeight', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            height: 500,
            child: ShimmerListWidget(itemCount: 1),
          ),
        ),
      );
      // Use pump instead of pumpAndSettle because shimmer has continuous animations
      await tester.pump();

      final shimmer = tester.widget<CshShimmer>(find.byType(CshShimmer).first);
      expect(shimmer.height, Dimens.space_120);
    });

    testWidgets('renders with default itemWidth (double.infinity)', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            height: 500,
            child: ShimmerListWidget(itemCount: 1),
          ),
        ),
      );
      // Use pump instead of pumpAndSettle because shimmer has continuous animations
      await tester.pump();

      final shimmer = tester.widget<CshShimmer>(find.byType(CshShimmer).first);
      expect(shimmer.width, double.infinity);
    });

    testWidgets('renders with default itemPadding', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            height: 500,
            child: ShimmerListWidget(itemCount: 1),
          ),
        ),
      );
      // Use pump instead of pumpAndSettle because shimmer has continuous animations
      await tester.pump();

      final padding = tester.widget<Padding>(find.byType(Padding).first);
      expect(
        padding.padding,
        const EdgeInsets.symmetric(vertical: Dimens.space_8, horizontal: Dimens.space_16),
      );
    });

    testWidgets('calculates maxItems based on available height', (tester) async {
      // With 500 height and default item height (120) + padding (8*2), should fit 3 items
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            height: 500,
            child: ShimmerListWidget(),
          ),
        ),
      );
      // Use pump instead of pumpAndSettle because shimmer has continuous animations
      await tester.pump();

      // Should render based on calculated maxItems
      expect(find.byType(CshShimmer), findsWidgets);
    });

    testWidgets('renders with null itemCount (uses maxItems)', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            height: 500,
            child: ShimmerListWidget(itemCount: null),
          ),
        ),
      );
      // Use pump instead of pumpAndSettle because shimmer has continuous animations
      await tester.pump();

      expect(find.byType(ShimmerListWidget), findsOneWidget);
      expect(find.byType(CshShimmer), findsWidgets);
    });

    testWidgets('renders multiple shimmer items correctly', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const SizedBox(
            height: 600,
            child: ShimmerListWidget(
              itemCount: 4,
              itemHeight: 100,
              itemPadding: EdgeInsets.all(8),
            ),
          ),
        ),
      );
      // Use pump instead of pumpAndSettle because shimmer has continuous animations
      await tester.pump();

      expect(find.byType(CshShimmer), findsNWidgets(4));
    });
  });
}
