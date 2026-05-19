import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/part_details_button_widget.dart';

void main() {
  group('PartDetailsButtonWidget', () {
    test('is a StatefulWidget', () {
      const widget = PartDetailsButtonWidget(
        statusCode: 12,
      );
      expect(widget, isA<StatefulWidget>());
    });

    test('accepts statusCode parameter', () {
      const widget = PartDetailsButtonWidget(
        statusCode: 13,
      );
      expect(widget.statusCode, 13);
    });

    test('accepts cancelBtnOnPressed callback', () {
      bool wasCalled = false;
      final widget = PartDetailsButtonWidget(
        statusCode: 12,
        cancelBtnOnPressed: () => wasCalled = true,
      );
      widget.cancelBtnOnPressed?.call();
      expect(wasCalled, true);
    });

    test('accepts assignBtnOnPressed callback', () {
      bool wasCalled = false;
      final widget = PartDetailsButtonWidget(
        statusCode: 12,
        assignBtnOnPressed: () => wasCalled = true,
      );
      widget.assignBtnOnPressed?.call();
      expect(wasCalled, true);
    });

    test('accepts deadPartOnPressed callback', () {
      bool wasCalled = false;
      final widget = PartDetailsButtonWidget(
        statusCode: 12,
        deadPartOnPressed: () => wasCalled = true,
      );
      widget.deadPartOnPressed?.call();
      expect(wasCalled, true);
    });

    test('accepts alternatePartBtnOnPressed callback', () {
      bool wasCalled = false;
      final widget = PartDetailsButtonWidget(
        statusCode: 12,
        alternatePartBtnOnPressed: () => wasCalled = true,
      );
      widget.alternatePartBtnOnPressed?.call();
      expect(wasCalled, true);
    });

    test('accepts goBackBtnOnPressed callback', () {
      bool wasCalled = false;
      final widget = PartDetailsButtonWidget(
        statusCode: 12,
        goBackBtnOnPressed: () => wasCalled = true,
      );
      widget.goBackBtnOnPressed?.call();
      expect(wasCalled, true);
    });

    test('accepts null callbacks', () {
      const widget = PartDetailsButtonWidget(
        statusCode: 12,
        cancelBtnOnPressed: null,
        assignBtnOnPressed: null,
        deadPartOnPressed: null,
        alternatePartBtnOnPressed: null,
        goBackBtnOnPressed: null,
      );
      expect(widget.cancelBtnOnPressed, isNull);
      expect(widget.assignBtnOnPressed, isNull);
      expect(widget.deadPartOnPressed, isNull);
      expect(widget.alternatePartBtnOnPressed, isNull);
      expect(widget.goBackBtnOnPressed, isNull);
    });

    test('handles different status codes', () {
      for (int code in [10, 11, 12, 13, 14, 15]) {
        final widget = PartDetailsButtonWidget(statusCode: code);
        expect(widget.statusCode, code);
      }
    });
  });
}
