import 'package:calculator_ui/calculator_ui.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/dispatch/providers/shipex_dispatch_provider.dart';
import 'package:flutter_trc/shipex/modules/shipex_home/screens/shipex_home_screen.dart';
import 'package:provider/provider.dart';

import '../../l10n.dart';
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
    var l10n = L10n(context);
    return WillPopScope(
      onWillPop: () {
        if (_pageIndex.value == 0) {
          return Future.value(true);
        }
        _showConfirmationPopup(context, l10n);
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
                                CshLoading().showLoading(context);
                                provider.partialDispatch().then((_) {
                                  CshLoading().hideLoading(context);
                                  CshSnackBar.success(context: context, message: l10n.requestSubmittedSuccessfully);
                                  Navigator.pop(context);
                                }, onError: (error) {
                                  CshLoading().hideLoading(context);
                                  CshSnackBar.error(context: context, message: error.toString());
                                });
                              },
                            );
                          default:
                            return const SizedBox.shrink();
                        }
                      },
                      itemCount: 2,
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

  _showConfirmationPopup(BuildContext context, L10n l10n) {
    showPopup(context,
        title: l10n.areYouSure,
        desc: l10n.allProgressWillBeLost,
        actions: [
          CshMediumButton(
            text: l10n.yes,
            onPressed: () => Navigator.of(context).popUntil((route) => route.settings.name == ShipexHomeScreen.route),
          ),
          CshMediumButton(
            text: l10n.no,
            onPressed: () => Navigator.of(context).pop(),
          )
        ],
        barrierDismissible: false);
  }
}
