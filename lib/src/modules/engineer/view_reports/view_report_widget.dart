import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/view_reports/device/widget/view_report_device_widget.dart';
import 'package:flutter_trc/src/modules/engineer/view_reports/parts/widget/view_reports_parts_widget.dart';

class ViewReportScreen extends StatelessWidget {
  const ViewReportScreen({Key? key}) : super(key: key);
  static const route = "/engineer/view-reports";

  @override
  Widget build(BuildContext context) {
    return const ViewReportWidget();
  }
}

class ViewReportWidget extends StatefulWidget {
  const ViewReportWidget({Key? key}) : super(key: key);

  @override
  State<ViewReportWidget> createState() => _ViewReportWidgetState();
}

class _ViewReportWidgetState extends State<ViewReportWidget> with SingleTickerProviderStateMixin {
  late L10n l10n;

  late TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    l10n = L10n(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CshHeader(l10n.viewReport),
      body: Column(
        children: [
          CshTabBar(controller: controller, tabs: [
            CshTab(label: l10n.device),
            CshTab(label: l10n.parts),
          ]),
          Expanded(
            child: TabBarView(
              controller: controller,
              children: const [
                ViewReportDeviceWidget(),
                ViewReportsPartsWidget(),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
