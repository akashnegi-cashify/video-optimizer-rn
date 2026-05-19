import 'package:components/list_page/config/list_api_config.dart';
import 'package:components/list_page/controller/csh_list_controller.dart';
import 'package:components/list_page/widgets/csh_api_list.dart';
import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/d2c_video/providers/d2c_lot_listing_provider.dart';
import 'package:flutter_trc/qc/modules/d2c_video/resources/d2c_lot_list_response.dart';
import 'package:flutter_trc/qc/modules/d2c_video/screens/d2c_lot_device_listing_screen.dart';
import 'package:flutter_trc/src/app_builder/app_headers/qc_general_header/widgets/qc_general_header.dart';
import 'package:flutter_trc/src/common/widgets/my_search_bar_widget.dart';
import 'package:flutter_trc/src/services/service_groups.dart';
import 'package:provider/provider.dart';

class D2cLotListingScreen extends StatelessWidget {
  static final String route = "/d2c-lot-listing";

  const D2cLotListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QcGeneralHeader("D2C Video Pending Lots"),
      body: ChangeNotifierProvider(
        create: (_) => D2cLotListingProvider(),
        builder: (innerContext, _) {
          var provider = D2cLotListingProvider.of(innerContext, listen: false);
          return Padding(
            padding: const EdgeInsets.all(Dimens.space_8),
            child: _D2cLotListing(),
          );
        },
      ),
    );
  }
}

class _D2cLotListing extends StatelessWidget {
  final CshListController _listController = CshListController();

  _D2cLotListing();

  @override
  Widget build(BuildContext context) {
    var provider = D2cLotListingProvider.of(context);
    var list = provider.d2cLotList;
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // MySearchBarWidget(
        //   hintText: "Search by lot name",
        //   onQuery: (query) {
        //     provider.searchQuery = query;
        //   },
        // ),
        // const SizedBox(height: Dimens.space_16),
        Expanded(
          child: CshApiList<D2cLotListData>(
            apiConfig: ListApiConfig(
              apiUrl: "/device/recording/pending-lot-list",
              serviceGroup: TRCServiceGroups.qcConsole,
            ),
            controller: _listController,
            shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
            listPadding: const EdgeInsets.symmetric(vertical: Dimens.space_8, horizontal: Dimens.space_8),
            verticalRowSpacing: Dimens.space_16,
            itemFromJson: D2cLotListData.fromJson,
            getRowWidget: (item, index) {
              return GestureDetector(
                onTap: () {
                  if (item == null || item.lotId == null || item.groupLotName == null) return;
                  D2cLotDeviceListingScreen.navigate(
                    context,
                    item.lotId!,
                    item.groupLotName!,
                    onBack: (isRefreshLot) {
                      if (isRefreshLot) {
                        _listController.refresh();
                      }
                    },
                  );
                },
                child: CshCard(cardWidth: double.infinity, child: CshTextNew.subTitle1(item?.groupLotName ?? "")),
              );
            },
          ),
        )
      ],
    );
  }
}
