import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/widgets/pending_device_detail_tab.dart';
import 'package:flutter_trc/qc/modules/stock_transfer/widgets/pending_device_list_tab.dart';

class PendingLotDetailWidget extends StatefulWidget {
  const PendingLotDetailWidget({super.key});

  @override
  State<PendingLotDetailWidget> createState() => _PendingLotDetailWidgetState();
}

class _PendingLotDetailWidgetState extends State<PendingLotDetailWidget> {
  final PageController _controller = PageController(initialPage: 0, keepPage: false);
  int _currentPage = 0;
  GlobalKey<PendingDeviceListTabState> deviceListTabRef = GlobalKey();

  String? _scannedDevice;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_currentPage == 1) {
          _controller.animateToPage(0, duration: const Duration(milliseconds: 200), curve: Curves.ease);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: PageView.builder(
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
              return PendingDeviceListTab(
                key: deviceListTabRef,
                onDeviceScanned: (String scannedDevice) {
                  _scannedDevice = scannedDevice;
                  _controller.animateToPage(1, duration: const Duration(milliseconds: 500), curve: Curves.ease);
                },
              );
            case 1:
              return PendingDeviceDetailTab(
                _scannedDevice,
                onDeviceAdded: () {
                  _controller.animateToPage(0, duration: const Duration(milliseconds: 200), curve: Curves.ease);
                },
                onReject: () {
                  _controller.animateToPage(0, duration: const Duration(milliseconds: 200), curve: Curves.ease);
                  Future.delayed(
                      const Duration(milliseconds: 500), () => deviceListTabRef.currentState?.onAddButtonClicked());
                },
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}
