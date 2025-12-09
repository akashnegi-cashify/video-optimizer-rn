import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/d2c_video/providers/d2c_lot_listing_provider.dart';
import 'package:flutter_trc/qc/modules/d2c_video/screens/d2c_lot_device_listing_screen.dart';
import 'package:flutter_trc/src/app_builder/app_headers/qc_general_header/widgets/qc_general_header.dart';
import 'package:flutter_trc/src/common/widgets/my_search_bar_widget.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';
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
          return FutureBuilder(
            future: provider.getLotList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ShimmerListWidget(itemHeight: Dimens.space_60);
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              return Padding(
                padding: const EdgeInsets.all(Dimens.space_16),
                child: const _D2cLotListing(),
              );
            },
          );
        },
      ),
    );
  }
}

class _D2cLotListing extends StatelessWidget {
  const _D2cLotListing();

  @override
  Widget build(BuildContext context) {
    var provider = D2cLotListingProvider.of(context);
    var list = provider.d2cLotList;
    var theme = Theme.of(context);
    return Column(
      children: [
        MySearchBarWidget(
          hintText: "Search by lot name",
          onQuery: (query) {
            provider.searchQuery = query;
          },
        ),
        const SizedBox(height: Dimens.space_16),
        Expanded(
          child: Validator.isListNullOrEmpty(list)
              ? Center(
                  child: Text(
                    "No data found",
                    style: theme.primaryTextTheme.titleMedium?.copyWith(color: theme.colorScheme.error),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () {
                    return provider.getLotList(isNotify: true);
                  },
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: list?.length ?? 0,
                    separatorBuilder: (__, _) => SizedBox(height: Dimens.space_16),
                    itemBuilder: (context, index) {
                      var item = list?[index];
                      return GestureDetector(
                        onTap: () {
                          if (item == null || item.lotId == null || item.groupLotName == null) return;
                          D2cLotDeviceListingScreen.navigate(
                            context,
                            item.lotId!,
                            item.groupLotName!,
                            onBack: (isRefreshLot) {
                              if (isRefreshLot) {
                                provider.getLotList(isNotify: true);
                              }
                            },
                          );
                        },
                        child: CshCard(child: CshTextNew.subTitle1(item?.groupLotName ?? "")),
                      );
                    },
                  ),
                ),
        )
      ],
    );
  }
}
