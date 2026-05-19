import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Actual widget import
import 'package:flutter_trc/qc/modules/dead_repair/widgets/accept_reject_remarks_widget.dart';

void main() {
  group('AcceptRejectRemarksWidget', () {
    test('AcceptRejectRemarksWidget class exists and is a StatelessWidget', () {
      expect(AcceptRejectRemarksWidget, isNotNull);
      const widget = AcceptRejectRemarksWidget();
      expect(widget, isA<StatelessWidget>());
    });

    test('AcceptRejectRemarksWidget can be instantiated with default constructor', () {
      const widget = AcceptRejectRemarksWidget();
      expect(widget, isNotNull);
      expect(widget.onRepairReject, isNull);
      expect(widget.onDeadAccept, isNull);
    });

    test('AcceptRejectRemarksWidget can be instantiated with onRepairReject callback', () {
      var callbackInvoked = false;
      final widget = AcceptRejectRemarksWidget(
        onRepairReject: () {
          callbackInvoked = true;
        },
      );
      expect(widget.onRepairReject, isNotNull);
      widget.onRepairReject!();
      expect(callbackInvoked, isTrue);
    });

    test('AcceptRejectRemarksWidget can be instantiated with onDeadAccept callback', () {
      var callbackInvoked = false;
      final widget = AcceptRejectRemarksWidget(
        onDeadAccept: () {
          callbackInvoked = true;
        },
      );
      expect(widget.onDeadAccept, isNotNull);
      widget.onDeadAccept!();
      expect(callbackInvoked, isTrue);
    });

    test('AcceptRejectRemarksWidget can be instantiated with both callbacks', () {
      var repairRejectCalled = false;
      var deadAcceptCalled = false;
      final widget = AcceptRejectRemarksWidget(
        onRepairReject: () {
          repairRejectCalled = true;
        },
        onDeadAccept: () {
          deadAcceptCalled = true;
        },
      );
      expect(widget.onRepairReject, isNotNull);
      expect(widget.onDeadAccept, isNotNull);
      
      widget.onRepairReject!();
      widget.onDeadAccept!();
      
      expect(repairRejectCalled, isTrue);
      expect(deadAcceptCalled, isTrue);
    });

    test('AcceptRejectRemarksWidget can be instantiated with a key', () {
      const key = Key('accept_reject_remarks_widget_key');
      const widget = AcceptRejectRemarksWidget(key: key);
      expect(widget.key, equals(key));
    });
  });
}
