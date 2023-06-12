import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/all_devices/widget/all_devices_widget.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/widgets/wip_tab.dart';

class MyDevicesScreen extends StatelessWidget {
  const MyDevicesScreen({Key? key}) : super(key: key);
  static const route = '/engineer/my-devices';

  @override
  Widget build(BuildContext context) {
    return const _MyDevicesWidget();
  }
}

class _MyDevicesWidget extends StatefulWidget {
  const _MyDevicesWidget({Key? key}) : super(key: key);

  @override
  State<_MyDevicesWidget> createState() => _MyDevicesWidgetState();
}

class _MyDevicesWidgetState extends State<_MyDevicesWidget> with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    _controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return Scaffold(
      appBar: TrcHeader(l10n.myDevices),
      body: Column(
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
          ))
        ],
      ),
    );
  }
}
