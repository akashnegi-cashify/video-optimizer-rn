import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/all_devices/widget/all_devices_widget.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/widgets/wip_tab.dart';

class MyDevicesWidget extends StatefulWidget {
  const MyDevicesWidget({Key? key}) : super(key: key);

  @override
  State<MyDevicesWidget> createState() => _MyDevicesWidgetState();
}

class _MyDevicesWidgetState extends State<MyDevicesWidget> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return Column(
      children: [
        CshTabBar(
          controller: _controller,
          tabs: [
            CshTextNew(
              l10n.allDevices,
            ),
            CshTextNew(
              l10n.wipDevices,
            )
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _controller,
            children: const [AllDevicesWidget(), WIPTab()],
          ),
        )
      ],
    );
  }
}
