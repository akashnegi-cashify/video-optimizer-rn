import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/d2c_video/providers/d2c_lot_device_listing_provider.dart';
import 'package:flutter_trc/qc/modules/d2c_video/screens/d2c_video_screen.dart';
import 'package:flutter_trc/src/app_builder/app_headers/qc_general_header/widgets/qc_general_header.dart';
import 'package:flutter_trc/src/common/widgets/search_with_scanner_widget.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';
import 'package:provider/provider.dart';

class D2cLotDeviceListingScreen extends StatelessWidget {
  static final String route = "/d2c-lot-device-listing";
  final String? groupLotName;

  static navigate(BuildContext context, String groupLotName, {required Function(bool isRefreshLot) onBack}) {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return D2cLotDeviceListingScreen(
          groupLotName: groupLotName,
        );
      },
    )).then(
      (value) {
        if (value is bool && value) {
          onBack(true);
        } else {
          onBack(false);
        }
      },
    );
  }

  const D2cLotDeviceListingScreen({this.groupLotName, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: QcGeneralHeader("D2C Video Pending Lots"),
      body: ChangeNotifierProvider(
        create: (_) => D2cLotDeviceListingProvider(groupLotName ?? ""),
        builder: (innerContext, _) {
          var provider = D2cLotDeviceListingProvider.of(innerContext, listen: false);
          return FutureBuilder(
            future: provider.getLotDeviceList(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return ShimmerListWidget(itemHeight: Dimens.space_60);
              }
              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }
              return const _D2cLotDeviceListing();
            },
          );
        },
      ),
    );
  }
}

class _D2cLotDeviceListing extends StatelessWidget {
  const _D2cLotDeviceListing({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = D2cLotDeviceListingProvider.of(context);
    var list = provider.d2cLotDeviceList;
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, Dimens.space_4),
          child: SearchWithScannerWidget(
            "Search by barcode",
            onQuery: (query, isManual) {
              provider.searchQuery = query;
            },
          ),
        ),
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
                    return provider.getLotDeviceList(isNotify: true);
                  },
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.all(Dimens.space_16),
                    itemCount: list?.length ?? 0,
                    separatorBuilder: (__, _) => SizedBox(height: Dimens.space_16),
                    itemBuilder: (context, index) {
                      var item = list?[index];
                      return GestureDetector(
                        onTap: () {
                          D2CVideoScreen.navigate(context, item!.deviceBarcode);
                        },
                        child: CshCard(
                          child: Row(
                            children: [
                              CshTextNew.subTitle1("Barcode: ", isPrimary: false),
                              SizedBox(width: Dimens.space_24),
                              Expanded(child: CshTextNew.subTitle1(item?.deviceBarcode ?? "")),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ),
        Padding(
          padding: EdgeInsets.all(Dimens.space_16),
          child: CshBigButtonWithLoader(
            text: "Mark Complete",
            onPressed: (Validator.isListNullOrEmpty(list) && Validator.isNullOrEmpty(provider.searchQuery))
                ? (controller) {
                    controller.startLoading();
                    provider.moveLotToNextStatus().then((value) {
                      if (context.mounted) {
                        controller.stopLoading();
                        CshSnackBar.success(context: context, message: "Lot moved to next status");
                        Navigator.pop(context, true);
                      }
                    }, onError: (error) {
                      if (context.mounted) {
                        controller.stopLoading();
                        CshSnackBar.error(context: context, message: error);
                      }
                    });
                  }
                : null,
          ),
        )
      ],
    );
  }
}
