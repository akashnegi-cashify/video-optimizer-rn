import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/manage_parts/pending_widget.dart';
import 'package:flutter_trc/src/modules/engineer/manage_parts/received_widget.dart';

import 'assigned_widget.dart';
import 'consumed_widget.dart';

class ManagePartsScreen extends StatelessWidget {
  const ManagePartsScreen({Key? key}) : super(key: key);
  static const route = "/engineer/manage-parts";

  @override
  Widget build(BuildContext context) {
    return const ManagePartsWidget();
  }
}

class ManagePartsWidget extends StatefulWidget {
  const ManagePartsWidget({Key? key}) : super(key: key);

  @override
  State<ManagePartsWidget> createState() => _ManagePartsWidgetState();
}

class _ManagePartsWidgetState extends State<ManagePartsWidget> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return Scaffold(
        appBar: CshHeader(l10n.manageParts),
        body: Column(
          children: [
            CshTabBar(
              isScrollable: true,
              controller: _controller,
              tabs: [
                CshTextNew(
                  l10n.received,
                ),
                CshTextNew(
                  l10n.consumed,
                ),
                CshTextNew(
                  l10n.pending,
                ),
                CshTextNew(
                  l10n.assigned,
                ),
              ],
            ),
            Expanded(
                child: TabBarView(
              controller: _controller,
              children: const [
                ReceivedWidget(),
                ConsumedWidget(),
                PendingWidget(),
                AssignedWidget(),
              ],
            ))
          ],
        ));
  }
}
