import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/widgets/pending_device_list_tab.dart';

class PendingLotDetailWidget extends StatefulWidget {
  const PendingLotDetailWidget({super.key});

  @override
  State<PendingLotDetailWidget> createState() => _PendingLotDetailWidgetState();
}

class _PendingLotDetailWidgetState extends State<PendingLotDetailWidget> {
  final PageController _controller = PageController(initialPage: 0, keepPage: false);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _controller,
      itemCount: 2,
      onPageChanged: (value) {
        setState(() {
          _currentPage = value;
        });
      },
      physics: const NeverScrollableScrollPhysics(),
      pageSnapping: true,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return PendingDeviceListTab();
          case 1:
            return Container();
          default:
            return Container();
        }
      },
    );
  }
}
