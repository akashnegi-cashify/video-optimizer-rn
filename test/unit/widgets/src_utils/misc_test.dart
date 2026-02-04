import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/utils/misc.dart';

void main() {
  group('mayBe function', () {
    test('returns function result when function succeeds', () {
      final result = mayBe(() => 'success');
      expect(result, 'success');
    });

    test('returns null when function throws and no default provided', () {
      final result = mayBe(() => throw Exception('error'));
      expect(result, isNull);
    });

    test('returns default value when function throws', () {
      final result = mayBe(() => throw Exception('error'), 'default');
      expect(result, 'default');
    });

    test('returns int value from function', () {
      final result = mayBe(() => 42);
      expect(result, 42);
    });

    test('returns default int when function throws', () {
      final result = mayBe(() => throw Exception('error'), 0);
      expect(result, 0);
    });

    test('returns list from function', () {
      final result = mayBe(() => [1, 2, 3]);
      expect(result, [1, 2, 3]);
    });

    test('returns default list when function throws', () {
      final result = mayBe(() => throw Exception('error'), <int>[]);
      expect(result, <int>[]);
    });

    test('returns map from function', () {
      final result = mayBe(() => {'key': 'value'});
      expect(result, {'key': 'value'});
    });

    test('returns bool from function', () {
      final result = mayBe(() => true);
      expect(result, true);
    });

    test('returns default false when function throws', () {
      final result = mayBe(() => throw Exception('error'), false);
      expect(result, false);
    });

    test('handles null return from function', () {
      final result = mayBe(() => null);
      expect(result, isNull);
    });

    test('handles complex object return', () {
      final result = mayBe(() => DateTime(2024, 1, 1));
      expect(result, isA<DateTime>());
      expect(result?.year, 2024);
    });

    test('catches any type of error', () {
      final result = mayBe(() => throw StateError('state error'), 'fallback');
      expect(result, 'fallback');
    });

    test('catches RangeError', () {
      final result = mayBe(() {
        final list = [1, 2, 3];
        return list[10]; // Out of range
      }, -1);
      expect(result, -1);
    });

    test('catches TypeError implicitly', () {
      dynamic value = 'not an int';
      final result = mayBe(() => value as int, 0);
      expect(result, 0);
    });
  });

  group('appendPath function', () {
    test('returns path2 when path1 is null', () {
      final result = appendPath(null, 'file.txt');
      expect(result, 'file.txt');
    });

    test('appends path2 when path1 ends with slash', () {
      final result = appendPath('/root/', 'file.txt');
      expect(result, '/root/file.txt');
    });

    test('appends path2 with slash when path1 does not end with slash', () {
      final result = appendPath('/root', 'file.txt');
      expect(result, '/root/file.txt');
    });

    test('handles empty path2', () {
      final result = appendPath('/root/', '');
      expect(result, '/root/');
    });

    test('handles empty path1 ending with slash', () {
      final result = appendPath('/', 'file.txt');
      expect(result, '/file.txt');
    });

    test('handles simple directory names', () {
      final result = appendPath('folder', 'subfolder');
      expect(result, 'folder/subfolder');
    });

    test('handles nested paths', () {
      final result = appendPath('/a/b/c/', 'd/e');
      expect(result, '/a/b/c/d/e');
    });

    test('handles paths with special characters', () {
      final result = appendPath('/path-with-dash/', 'file_name.txt');
      expect(result, '/path-with-dash/file_name.txt');
    });

    test('handles paths with spaces', () {
      final result = appendPath('/my folder/', 'my file.txt');
      expect(result, '/my folder/my file.txt');
    });

    test('handles windows-style path separators in path2', () {
      final result = appendPath('/root', 'sub\\file.txt');
      expect(result, '/root/sub\\file.txt');
    });

    test('handles URL-like paths', () {
      final result = appendPath('https://example.com/api/', 'endpoint');
      expect(result, 'https://example.com/api/endpoint');
    });

    test('handles URL-like paths without trailing slash', () {
      final result = appendPath('https://example.com/api', 'endpoint');
      expect(result, 'https://example.com/api/endpoint');
    });

    test('handles single character path1', () {
      final result = appendPath('a', 'b');
      expect(result, 'a/b');
    });

    test('handles single character path1 with slash', () {
      final result = appendPath('a/', 'b');
      expect(result, 'a/b');
    });
  });

  group('isScrollPositionMeet function', () {
    testWidgets('returns true when scroll position exceeds threshold',
        (tester) async {
      final scrollController = ScrollController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                final result = isScrollPositionMeet(scrollInfo, 0, 100);
                // When scrolled 150 pixels, should exceed 0 + 100 = 100
                if (scrollInfo.metrics.pixels == 150) {
                  expect(result, true);
                }
                return false;
              },
              child: ListView.builder(
                controller: scrollController,
                itemCount: 100,
                itemBuilder: (context, index) => ListTile(
                  title: Text('Item $index'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Scroll to trigger notification
      scrollController.jumpTo(150);
      await tester.pumpAndSettle();
    });

    testWidgets('returns false when scroll position is below threshold',
        (tester) async {
      final scrollController = ScrollController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                final result = isScrollPositionMeet(scrollInfo, 0, 100);
                // When scrolled 50 pixels, should not exceed 0 + 100 = 100
                if (scrollInfo.metrics.pixels == 50) {
                  expect(result, false);
                }
                return false;
              },
              child: ListView.builder(
                controller: scrollController,
                itemCount: 100,
                itemBuilder: (context, index) => ListTile(
                  title: Text('Item $index'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Scroll to trigger notification
      scrollController.jumpTo(50);
      await tester.pumpAndSettle();
    });

    testWidgets('returns false when scroll position equals threshold exactly',
        (tester) async {
      final scrollController = ScrollController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                final result = isScrollPositionMeet(scrollInfo, 0, 100);
                // When scrolled exactly 100 pixels, should NOT exceed 0 + 100 = 100 (> not >=)
                if (scrollInfo.metrics.pixels == 100) {
                  expect(result, false);
                }
                return false;
              },
              child: ListView.builder(
                controller: scrollController,
                itemCount: 100,
                itemBuilder: (context, index) => ListTile(
                  title: Text('Item $index'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Scroll to trigger notification
      scrollController.jumpTo(100);
      await tester.pumpAndSettle();
    });

    testWidgets('handles non-zero initial scroll offset', (tester) async {
      final scrollController = ScrollController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                // initialScrollOffset = 50, maxExtent = 100
                // threshold = 50 + 100 = 150
                final result = isScrollPositionMeet(scrollInfo, 50, 100);
                if (scrollInfo.metrics.pixels == 200) {
                  expect(result, true); // 200 > 150
                }
                if (scrollInfo.metrics.pixels == 100) {
                  expect(result, false); // 100 < 150
                }
                return false;
              },
              child: ListView.builder(
                controller: scrollController,
                itemCount: 100,
                itemBuilder: (context, index) => ListTile(
                  title: Text('Item $index'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      scrollController.jumpTo(200);
      await tester.pumpAndSettle();
    });

    testWidgets('handles zero maxExtent', (tester) async {
      final scrollController = ScrollController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                final result = isScrollPositionMeet(scrollInfo, 0, 0);
                // Any positive scroll should exceed 0 + 0 = 0
                if (scrollInfo.metrics.pixels > 0) {
                  expect(result, true);
                }
                return false;
              },
              child: ListView.builder(
                controller: scrollController,
                itemCount: 100,
                itemBuilder: (context, index) => ListTile(
                  title: Text('Item $index'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      scrollController.jumpTo(10);
      await tester.pumpAndSettle();
    });

    testWidgets('handles large scroll values', (tester) async {
      final scrollController = ScrollController();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NotificationListener<ScrollNotification>(
              onNotification: (scrollInfo) {
                final result = isScrollPositionMeet(scrollInfo, 1000, 500);
                if (scrollInfo.metrics.pixels == 2000) {
                  expect(result, true); // 2000 > 1500
                }
                return false;
              },
              child: ListView.builder(
                controller: scrollController,
                itemCount: 1000,
                itemBuilder: (context, index) => ListTile(
                  title: Text('Item $index'),
                ),
              ),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      scrollController.jumpTo(2000);
      await tester.pumpAndSettle();
    });
  });

  group('mayBe edge cases', () {
    test('handles nested function calls', () {
      final result = mayBe(() => mayBe(() => 'nested'));
      expect(result, 'nested');
    });

    test('handles async-like return (Future value)', () {
      // Note: mayBe is not async, but it can return any value including a Future
      final result = mayBe(() => Future.value('async'));
      expect(result, isA<Future<String>>());
    });

    test('handles null default value explicitly', () {
      final result = mayBe(() => throw Exception('error'), null);
      expect(result, isNull);
    });
  });
}
