import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty;

// Actual widget import
import 'package:flutter_trc/qc/modules/data_wipe/widgets/filter_value_multi_type.dart';

void main() {
  group('FilterValueMultiType', () {
    group('unit tests', () {
      test('FilterValueMultiType class exists and is a StatelessWidget', () {
        expect(FilterValueMultiType, isNotNull);
        const widget = FilterValueMultiType('Title', false);
        expect(widget, isA<StatelessWidget>());
      });

      test('FilterValueMultiType can be instantiated with required parameters', () {
        const widget = FilterValueMultiType('Status Active', true);
        expect(widget, isNotNull);
        expect(widget.title, equals('Status Active'));
        expect(widget.isSelected, isTrue);
      });

      test('FilterValueMultiType can be instantiated in unselected state', () {
        const widget = FilterValueMultiType('Provider Option', false);
        expect(widget.isSelected, isFalse);
      });

      test('FilterValueMultiType can be instantiated in selected state', () {
        const widget = FilterValueMultiType('Filter Option', true);
        expect(widget.isSelected, isTrue);
      });

      test('FilterValueMultiType can be instantiated with onValueChanged callback', () {
        bool? changedValue;
        final widget = FilterValueMultiType(
          'Status',
          false,
          onValueChanged: (value) {
            changedValue = value;
          },
        );
        expect(widget.onValueChanged, isNotNull);
      });

      test('FilterValueMultiType can be instantiated without onValueChanged callback', () {
        const widget = FilterValueMultiType('Status', true);
        expect(widget.onValueChanged, isNull);
      });

      test('FilterValueMultiType can be instantiated with a key', () {
        const key = Key('filter_value_multi_type_key');
        const widget = FilterValueMultiType('Title', false, key: key);
        expect(widget.key, equals(key));
      });

      test('FilterValueMultiType stores all properties correctly', () {
        bool? receivedValue;
        final widget = FilterValueMultiType(
          'Erasure Provider - BLANCCO',
          true,
          onValueChanged: (value) {
            receivedValue = value;
          },
        );
        
        expect(widget.title, equals('Erasure Provider - BLANCCO'));
        expect(widget.isSelected, isTrue);
        expect(widget.onValueChanged, isNotNull);
      });

      test('FilterValueMultiType onValueChanged invokes with correct value', () {
        bool? receivedValue;
        final widget = FilterValueMultiType(
          'Option',
          false,
          onValueChanged: (value) {
            receivedValue = value;
          },
        );
        
        widget.onValueChanged!(true);
        expect(receivedValue, isTrue);
        
        widget.onValueChanged!(false);
        expect(receivedValue, isFalse);
      });

      test('FilterValueMultiType onValueChanged can receive null', () {
        bool? receivedValue = true;
        final widget = FilterValueMultiType(
          'Option',
          true,
          onValueChanged: (value) {
            receivedValue = value;
          },
        );
        
        widget.onValueChanged!(null);
        expect(receivedValue, isNull);
      });

      test('FilterValueMultiType with empty title', () {
        const widget = FilterValueMultiType('', false);
        expect(widget.title, isEmpty);
      });

      test('FilterValueMultiType title stores correctly', () {
        const widget = FilterValueMultiType('Pending Filter', false);
        expect(widget.title, equals('Pending Filter'));
      });

      test('FilterValueMultiType stores selected state correctly', () {
        const selectedWidget = FilterValueMultiType('Selected Option', true);
        const unselectedWidget = FilterValueMultiType('Unselected Option', false);
        
        expect(selectedWidget.isSelected, isTrue);
        expect(unselectedWidget.isSelected, isFalse);
      });

      test('FilterValueMultiType callback can toggle state', () {
        bool currentValue = false;
        final widget = FilterValueMultiType(
          'Toggle Option',
          currentValue,
          onValueChanged: (value) {
            currentValue = value ?? false;
          },
        );
        
        // Toggle to true
        widget.onValueChanged!(true);
        expect(currentValue, isTrue);
        
        // Toggle back to false
        widget.onValueChanged!(false);
        expect(currentValue, isFalse);
      });

      test('FilterValueMultiType handles special characters in title', () {
        const widget = FilterValueMultiType('Status: Active/Pending (2+)', true);
        expect(widget.title, 'Status: Active/Pending (2+)');
      });

      test('FilterValueMultiType handles unicode in title', () {
        const widget = FilterValueMultiType('状态选择', false);
        expect(widget.title, '状态选择');
      });
    });

    group('widget tests', () {
      testWidgets('renders without error', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: const FilterValueMultiType('Test Title', false),
            ),
          ),
        );
        
        expect(find.byType(FilterValueMultiType), findsOneWidget);
      });

      testWidgets('displays title text', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: const FilterValueMultiType('Status Filter', true),
            ),
          ),
        );
        
        expect(find.text('Status Filter'), findsOneWidget);
      });

      testWidgets('renders CshCheckbox widget', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: const FilterValueMultiType('Test', false),
            ),
          ),
        );
        
        expect(find.byType(CshCheckbox), findsOneWidget);
      });

      testWidgets('renders in selected state', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: const FilterValueMultiType('Selected Option', true),
            ),
          ),
        );
        
        expect(find.byType(FilterValueMultiType), findsOneWidget);
      });

      testWidgets('renders in unselected state', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: const FilterValueMultiType('Unselected Option', false),
            ),
          ),
        );
        
        expect(find.byType(FilterValueMultiType), findsOneWidget);
      });

      testWidgets('handles null onValueChanged gracefully', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: const FilterValueMultiType('Test', false),
            ),
          ),
        );
        
        // Widget should render without throwing
        expect(find.byType(FilterValueMultiType), findsOneWidget);
      });

      testWidgets('renders with empty title', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: const FilterValueMultiType('', false),
            ),
          ),
        );
        
        expect(find.byType(FilterValueMultiType), findsOneWidget);
      });

      testWidgets('renders multiple instances correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: const [
                  FilterValueMultiType('Option 1', true),
                  FilterValueMultiType('Option 2', false),
                  FilterValueMultiType('Option 3', true),
                ],
              ),
            ),
          ),
        );
        
        expect(find.byType(FilterValueMultiType), findsNWidgets(3));
        expect(find.text('Option 1'), findsOneWidget);
        expect(find.text('Option 2'), findsOneWidget);
        expect(find.text('Option 3'), findsOneWidget);
      });

      testWidgets('renders InkWell for title tap', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: FilterValueMultiType(
                'Tappable Title',
                false,
                onValueChanged: (value) {},
              ),
            ),
          ),
        );
        
        expect(find.byType(InkWell), findsWidgets);
      });
    });
  });
}
