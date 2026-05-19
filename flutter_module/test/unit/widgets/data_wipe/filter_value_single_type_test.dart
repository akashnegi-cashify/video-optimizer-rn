import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:core_widgets/core_widgets.dart' hide isEmpty;

// Actual widget import
import 'package:flutter_trc/qc/modules/data_wipe/widgets/filter_value_single_type.dart';

void main() {
  group('FilterValueSingleType', () {
    group('unit tests', () {
      test('FilterValueSingleType class exists and is a StatelessWidget', () {
        expect(FilterValueSingleType, isNotNull);
        const widget = FilterValueSingleType('Title', 'value1', 'value1');
        expect(widget, isA<StatelessWidget>());
      });

      test('FilterValueSingleType can be instantiated with required parameters', () {
        const widget = FilterValueSingleType('Status', 'active', 'active');
        expect(widget, isNotNull);
        expect(widget.title, equals('Status'));
        expect(widget.value, equals('active'));
        expect(widget.groupValue, equals('active'));
      });

      test('FilterValueSingleType can be instantiated with unselected state', () {
        const widget = FilterValueSingleType('Provider', 'cashify', 'blancco');
        expect(widget.value, equals('cashify'));
        expect(widget.groupValue, equals('blancco'));
        expect(widget.value != widget.groupValue, isTrue);
      });

      test('FilterValueSingleType can be instantiated with onValueChanged callback', () {
        String? changedValue;
        final widget = FilterValueSingleType(
          'Status',
          'pending',
          'pending',
          onValueChanged: (value) {
            changedValue = value;
          },
        );
        expect(widget.onValueChanged, isNotNull);
      });

      test('FilterValueSingleType can be instantiated without onValueChanged callback', () {
        const widget = FilterValueSingleType('Status', 'active', 'active');
        expect(widget.onValueChanged, isNull);
      });

      test('FilterValueSingleType can be instantiated with a key', () {
        const key = Key('filter_value_single_type_key');
        const widget = FilterValueSingleType('Title', 'value', 'value', key: key);
        expect(widget.key, equals(key));
      });

      test('FilterValueSingleType stores all properties correctly', () {
        String? receivedValue;
        final widget = FilterValueSingleType(
          'Erasure Provider',
          'BLANCCO',
          'CASHIFY',
          onValueChanged: (value) {
            receivedValue = value;
          },
        );
        
        expect(widget.title, equals('Erasure Provider'));
        expect(widget.value, equals('BLANCCO'));
        expect(widget.groupValue, equals('CASHIFY'));
        expect(widget.onValueChanged, isNotNull);
      });

      test('FilterValueSingleType with matching value and groupValue indicates selection', () {
        const widget = FilterValueSingleType('Status', 'completed', 'completed');
        expect(widget.value == widget.groupValue, isTrue);
      });

      test('FilterValueSingleType with different value and groupValue indicates no selection', () {
        const widget = FilterValueSingleType('Status', 'pending', 'completed');
        expect(widget.value == widget.groupValue, isFalse);
      });

      test('FilterValueSingleType callback invokes with value', () {
        String? receivedValue;
        final widget = FilterValueSingleType(
          'Status',
          'active',
          'inactive',
          onValueChanged: (value) {
            receivedValue = value;
          },
        );
        
        widget.onValueChanged!('active');
        expect(receivedValue, equals('active'));
      });

      test('FilterValueSingleType can have empty title', () {
        const widget = FilterValueSingleType('', 'value', 'value');
        expect(widget.title, isEmpty);
      });

      test('FilterValueSingleType can have empty values', () {
        const widget = FilterValueSingleType('Title', '', '');
        expect(widget.value, isEmpty);
        expect(widget.groupValue, isEmpty);
      });

      test('FilterValueSingleType callback invokes with null', () {
        String? receivedValue = 'initial';
        final widget = FilterValueSingleType(
          'Status',
          'active',
          'inactive',
          onValueChanged: (value) {
            receivedValue = value;
          },
        );
        
        widget.onValueChanged!(null);
        expect(receivedValue, isNull);
      });

      test('FilterValueSingleType handles special characters in title', () {
        const widget = FilterValueSingleType('Status: Active/Pending', 'active', 'active');
        expect(widget.title, 'Status: Active/Pending');
      });

      test('FilterValueSingleType handles unicode in value', () {
        const widget = FilterValueSingleType('状态', '活动', '活动');
        expect(widget.title, '状态');
        expect(widget.value, '活动');
        expect(widget.groupValue, '活动');
      });
    });

    group('widget tests', () {
      testWidgets('renders without error', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: const FilterValueSingleType('Test Title', 'value1', 'value1'),
            ),
          ),
        );
        
        expect(find.byType(FilterValueSingleType), findsOneWidget);
      });

      testWidgets('displays title text', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: const FilterValueSingleType('Status Filter', 'active', 'active'),
            ),
          ),
        );
        
        expect(find.text('Status Filter'), findsOneWidget);
      });

      testWidgets('renders CshRadio widget', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: const FilterValueSingleType('Test', 'val', 'val'),
            ),
          ),
        );
        
        expect(find.byType(CshRadio<String>), findsOneWidget);
      });

      testWidgets('renders with different value and groupValue', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: const FilterValueSingleType('Provider', 'cashify', 'blancco'),
            ),
          ),
        );
        
        expect(find.byType(FilterValueSingleType), findsOneWidget);
        expect(find.text('Provider'), findsOneWidget);
      });

      testWidgets('handles null onValueChanged gracefully', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: const FilterValueSingleType('Test', 'value', 'value'),
            ),
          ),
        );
        
        // Widget should render without throwing
        expect(find.byType(FilterValueSingleType), findsOneWidget);
      });

      testWidgets('renders with empty title', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: const FilterValueSingleType('', 'value', 'value'),
            ),
          ),
        );
        
        expect(find.byType(FilterValueSingleType), findsOneWidget);
      });

      testWidgets('renders multiple instances correctly', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: Column(
                children: const [
                  FilterValueSingleType('Option 1', 'opt1', 'opt1'),
                  FilterValueSingleType('Option 2', 'opt2', 'opt1'),
                  FilterValueSingleType('Option 3', 'opt3', 'opt1'),
                ],
              ),
            ),
          ),
        );
        
        expect(find.byType(FilterValueSingleType), findsNWidgets(3));
        expect(find.text('Option 1'), findsOneWidget);
        expect(find.text('Option 2'), findsOneWidget);
        expect(find.text('Option 3'), findsOneWidget);
      });
    });
  });
}
