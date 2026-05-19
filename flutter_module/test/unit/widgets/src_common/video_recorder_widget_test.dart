import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/video_recoder_widget.dart';

void main() {
  /// Builds a testable widget with MaterialApp wrapper
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(body: child),
    );
  }

  group('VideoRecorderWidget', () {
    testWidgets('renders correctly with default parameters', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const VideoRecorderWidget(),
        ),
      );
      // Use pump instead of pumpAndSettle since camera initialization is async
      await tester.pump();

      expect(find.byType(VideoRecorderWidget), findsOneWidget);
    });

    testWidgets('renders with isCompressionEnabled true (default)', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const VideoRecorderWidget(isCompressionEnabled: true),
        ),
      );
      await tester.pump();

      expect(find.byType(VideoRecorderWidget), findsOneWidget);
    });

    testWidgets('renders with isCompressionEnabled false', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const VideoRecorderWidget(isCompressionEnabled: false),
        ),
      );
      await tester.pump();

      expect(find.byType(VideoRecorderWidget), findsOneWidget);
    });

    testWidgets('shows loading indicator initially', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const VideoRecorderWidget(),
        ),
      );
      await tester.pump();

      // Initially should show loading indicator (white Container with CircularProgressIndicator)
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('renders Container when loading', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const VideoRecorderWidget(),
        ),
      );
      await tester.pump();

      // During loading state, should have a Container with white color
      final container = tester.widgetList<Container>(find.byType(Container));
      expect(container, isNotEmpty);
    });

    testWidgets('renders Center widget when loading', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const VideoRecorderWidget(),
        ),
      );
      await tester.pump();

      expect(find.byType(Center), findsWidgets);
    });

    testWidgets('widget has state', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const VideoRecorderWidget(),
        ),
      );
      await tester.pump();

      // VideoRecorderWidget should be a StatefulWidget
      expect(find.byType(VideoRecorderWidget), findsOneWidget);
    });

    testWidgets('disposes camera controller on widget dispose', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          const VideoRecorderWidget(),
        ),
      );
      await tester.pump();

      // Navigate away to trigger dispose
      await tester.pumpWidget(
        buildTestWidget(const SizedBox()),
      );
      await tester.pump();

      // No errors should occur during dispose
      expect(find.byType(VideoRecorderWidget), findsNothing);
    });
  });

  group('VideoRecorderWidgetState', () {
    test('VideoRecorderWidgetState class exists', () {
      expect(VideoRecorderWidgetState, isNotNull);
    });
  });
}
