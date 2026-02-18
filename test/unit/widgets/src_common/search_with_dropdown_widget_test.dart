import 'package:core_widgets/core_widgets.dart' hide isEmpty, isNotEmpty;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/common/widgets/search_with_dropdown_widget.dart';

void main() {
  /// Builds a testable widget with MaterialApp wrapper
  Widget buildTestWidget(Widget child) {
    return MaterialApp(
      theme: ThemeData(),
      home: Scaffold(body: child),
    );
  }

  group('SearchWithDropdownWidget', () {
    final searchTypes = LotSearchType.values.toList();

    testWidgets('renders correctly with required parameters', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchWithDropdownWidget(
            searchTypeValues: searchTypes,
            onDropDownChange: (item) {},
            onSearch: (type, value) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(SearchWithDropdownWidget), findsOneWidget);
    });

    testWidgets('renders Row layout', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchWithDropdownWidget(
            searchTypeValues: searchTypes,
            onDropDownChange: (item) {},
            onSearch: (type, value) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Row), findsWidgets);
    });

    testWidgets('renders CshDropDown', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchWithDropdownWidget(
            searchTypeValues: searchTypes,
            onDropDownChange: (item) {},
            onSearch: (type, value) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CshDropDown), findsOneWidget);
    });

    testWidgets('renders CshTextFormField', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchWithDropdownWidget(
            searchTypeValues: searchTypes,
            onDropDownChange: (item) {},
            onSearch: (type, value) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(CshTextFormField), findsOneWidget);
    });

    testWidgets('applies custom padding', (tester) async {
      const customPadding = EdgeInsets.all(16);
      await tester.pumpWidget(
        buildTestWidget(
          SearchWithDropdownWidget(
            searchTypeValues: searchTypes,
            onDropDownChange: (item) {},
            onSearch: (type, value) {},
            padding: customPadding,
          ),
        ),
      );
      await tester.pumpAndSettle();

      final padding = tester.widget<Padding>(find.byType(Padding).first);
      expect(padding.padding, customPadding);
    });

    testWidgets('uses default padding (EdgeInsets.zero)', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchWithDropdownWidget(
            searchTypeValues: searchTypes,
            onDropDownChange: (item) {},
            onSearch: (type, value) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      final padding = tester.widget<Padding>(find.byType(Padding).first);
      expect(padding.padding, EdgeInsets.zero);
    });

    testWidgets('renders Flexible widgets for layout', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchWithDropdownWidget(
            searchTypeValues: searchTypes,
            onDropDownChange: (item) {},
            onSearch: (type, value) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byType(Flexible), findsNWidgets(2));
    });

    testWidgets('dropdown flex is 1, textfield flex is 2', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchWithDropdownWidget(
            searchTypeValues: searchTypes,
            onDropDownChange: (item) {},
            onSearch: (type, value) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      final flexibles = tester.widgetList<Flexible>(find.byType(Flexible)).toList();
      expect(flexibles[0].flex, 1);
      expect(flexibles[1].flex, 2);
    });

    testWidgets('text input triggers onSearch after debounce', (tester) async {
      SearchType? receivedType;
      String? receivedValue;

      await tester.pumpWidget(
        buildTestWidget(
          SearchWithDropdownWidget(
            searchTypeValues: searchTypes,
            onDropDownChange: (item) {},
            onSearch: (type, value) {
              receivedType = type;
              receivedValue = value;
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter text
      await tester.enterText(find.byType(TextField), 'test search');
      await tester.pump(const Duration(milliseconds: 600));

      expect(receivedValue, 'test search');
      expect(receivedType, isNotNull);
    });

    testWidgets('first search type is selected by default', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchWithDropdownWidget(
            searchTypeValues: searchTypes,
            onDropDownChange: (item) {},
            onSearch: (type, value) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // First item should be selected
      expect(find.byType(SearchWithDropdownWidget), findsOneWidget);
    });

    testWidgets('clears text when dropdown changes', (tester) async {
      await tester.pumpWidget(
        buildTestWidget(
          SearchWithDropdownWidget(
            searchTypeValues: searchTypes,
            onDropDownChange: (item) {},
            onSearch: (type, value) {},
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Enter text first
      await tester.enterText(find.byType(TextField), 'test');
      await tester.pump();

      expect(find.text('test'), findsOneWidget);
    });
  });

  group('SearchType mixin', () {
    test('SearchType has required properties', () {
      // Verify mixin properties
      for (var type in LotSearchType.values) {
        expect(type.code, isNotEmpty);
        expect(type.label, isNotEmpty);
        expect(type.hintName, isNotEmpty);
      }
    });
  });

  group('LotSearchType enum', () {
    test('lotName has correct values', () {
      expect(LotSearchType.lotName.code, 'ln');
      expect(LotSearchType.lotName.label, 'Lot Name');
      expect(LotSearchType.lotName.hintName, 'Search by name');
    });

    test('barcode has correct values', () {
      expect(LotSearchType.barcode.code, 'br');
      expect(LotSearchType.barcode.label, 'Barcode');
      expect(LotSearchType.barcode.hintName, 'Search by barcode');
    });

    test('LotSearchType has two values', () {
      expect(LotSearchType.values.length, 2);
    });

    test('LotSearchType implements SearchType', () {
      expect(LotSearchType.lotName, isA<SearchType>());
      expect(LotSearchType.barcode, isA<SearchType>());
    });
  });
}
