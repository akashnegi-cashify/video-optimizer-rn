import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/packaging/providers/packaging_provider.dart';
import 'package:flutter_trc/shipex/modules/packaging/widgets/packaging_process_step_one_widget.dart';
import 'package:flutter_trc/shipex/modules/packaging/widgets/packaging_process_step_three_widget.dart';
import 'package:flutter_trc/shipex/modules/packaging/widgets/packaging_process_step_two_widget.dart';
import 'package:provider/provider.dart';

import '../models/group_list_repsonse_data_model.dart';

class PackagingProcessWidget extends StatelessWidget {
  final GroupListDataResponse? dataModel;

  PackagingProcessWidget({super.key, this.dataModel});

  final PageController _pageController = PageController(initialPage: 0);
  ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<PackagingProvider>(
      create: (_) => PackagingProvider(),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        var provider = PackagingProvider.of(insideContext);
        return ValueListenableBuilder(
          builder: (context, int value, __) {
            return Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return PackagingProcessStepOneWidget(
                          lotName: dataModel?.name,
                          quantity: dataModel?.quantity,
                          onProcessFinished: (String data) {
                            provider.awbNumber = data;
                            _currentIndex.value = 1;
                            _pageController.animateToPage(_currentIndex.value,
                                duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                          },
                        );
                      } else if (index == 1) {
                        return PackagingProcessStepTwoWidget(
                          lotName: dataModel?.name,
                          quantity: dataModel?.quantity,
                          onProcessFinished: (String data) {
                            provider.invoiceNumber = data;
                            _currentIndex.value = 2;
                            _pageController.animateToPage(_currentIndex.value,
                                duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
                          },
                        );
                      } else {
                        return PackagingProcessStepThreeWidget(
                          lotName: dataModel?.name,
                          quantity: dataModel?.quantity,
                          onProcessFinished: (String data) {},
                        );
                      }
                    },
                    itemCount: 3,
                    pageSnapping: true,
                    allowImplicitScrolling: false,
                  ),
                )
              ],
            );
          },
          valueListenable: _currentIndex,
        );
      },
    );
  }
}
