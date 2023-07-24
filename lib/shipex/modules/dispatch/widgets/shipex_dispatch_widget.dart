import 'package:calculator_ui/calculator_ui.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/dispatch/providers/shipex_dispatch_provider.dart';
import 'package:flutter_trc/shipex/modules/shipex_home/screens/shipex_home_screen.dart';
import 'package:provider/provider.dart';

import '../models/delivery_partner_list_response.dart';
import 'awb_scanner_widget.dart';
import 'dispatch_delivery_list_widget.dart';
import 'dispatch_finish_widget.dart';

class ShipexDispatchWidget extends StatelessWidget {
  ShipexDispatchWidget({super.key});

  final ValueNotifier<int> _pageIndex = ValueNotifier<int>(0);
  final PageController _pageController = PageController(initialPage: 0, keepPage: true);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        if (_pageIndex.value == 0) {
          return Future.value(true);
        }
        _showConfirmationPopup(context);
        return Future.value(false);
      },
      child: ChangeNotifierProvider<ShipexDispatchProvider>(
        create: (_) => ShipexDispatchProvider(),
        lazy: false,
        builder: (BuildContext insideContext, __) {
          var provider = ShipexDispatchProvider.of(insideContext);
          return Column(
            children: [
              ValueListenableBuilder(
                builder: (context, int value, __) {
                  return Expanded(
                    child: PageView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      onPageChanged: (index) => _pageIndex.value = index,
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return DispatchDeliveryListWidget(
                              onDeliveryPartnerClicked: (DeliveryPartnerListData? dataModel) {
                                provider.onDeliveryPartnerChanged(dataModel);
                                _pageIndex.value = 1;
                                _pageController.animateToPage(_pageIndex.value,
                                    duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                              },
                            );
                          case 1:
                            return AwbScannerWidget(
                              onSubmitPressed: () {
                                _pageIndex.value = 2;
                                _pageController.animateToPage(_pageIndex.value,
                                    duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                              },
                            );
                          case 2:
                            return const DispatchFinishedWidget();
                          default:
                            return const SizedBox.shrink();
                        }
                      },
                      itemCount: 3,
                      pageSnapping: true,
                      allowImplicitScrolling: false,
                    ),
                  );
                },
                valueListenable: _pageIndex,
              )
            ],
          );
        },
      ),
    );
  }

  _showConfirmationPopup(BuildContext context) {
    showPopup(context,
        title: "Are you sure?",
        desc: "The complete Progress will be lost.!!",
        actions: [
          CshMediumButton(
            text: "Yes",
            onPressed: () => Navigator.of(context).popUntil((route) => route.settings.name == ShipexHomeScreen.route),
          ),
          CshMediumButton(
            text: "No",
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
        barrierDismissible: false);
  }
}
