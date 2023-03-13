import 'dart:async';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../l10n.dart';
import '../providers/inventory_home_provider.dart';

class InventoryHomeWidget extends StatefulWidget {
  const InventoryHomeWidget({Key? key}) : super(key: key);

  @override
  State<InventoryHomeWidget> createState() => _InventoryHomeWidgetState();
}

class _InventoryHomeWidgetState extends State<InventoryHomeWidget> {
  @override
  void initState() {
    scheduleMicrotask(() {
      _selectLocationModal();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var provider = InventoryHomeProvider.of(context);
    return Column(
      children: [
        SizedBox(
          height: Dimens.space_50,
          child: AppBar(
            bottom: TabBar(
              tabs: [
                Text(l10n.pendingDelivery.toUpperCase()),
                Text(l10n.assigned),
              ],
            ),
          ),
        ),
        const Expanded(
          child: TabBarView(
            children: [
              Text("Hello world"),
              Text("Hello world 2"),
            ],
          ),
        )
      ],
    );
  }

  _selectLocationModal() {
    showCshBottomSheet(
      isDismissible: false,
      isScrollControlled: false,
      context: context,
      child: WillPopScope(
        onWillPop: () async {
          return Future.value(false);
        },
        child: const Text("Hello world"),
      ),
    );
  }
}
