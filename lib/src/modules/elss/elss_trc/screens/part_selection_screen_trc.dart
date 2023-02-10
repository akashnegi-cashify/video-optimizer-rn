import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../common_models/elss_device_details_response.dart';
import '../l10n.dart';
import '../providers/elss_provider_trc.dart';
import '../widgets/part_selection_widget_trc.dart';
import 'brand_details_listing_screen.dart';

class PartSelectionScreenTrc extends StatefulWidget {
  static const route = '/part_selection_screen_trc';

  const PartSelectionScreenTrc({Key? key}) : super(key: key);

  @override
  State<PartSelectionScreenTrc> createState() => _PartSelectionScreenTrcState();
}

class _PartSelectionScreenTrcState extends State<PartSelectionScreenTrc> {
  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    String scannedBarcode = ModalRoute.of(context)?.settings.arguments as String;
    return ChangeNotifierProvider<ELssProviderTrc>(
      create: (_) => ELssProviderTrc(scannedBarcode, onProductIdMissingCallback: _productIdNullHandlingCallback),
      lazy: false,
      builder: (BuildContext innerContext, __) {
        var provider = ELssProviderTrc.of(innerContext);

        return Scaffold(
          appBar: CshHeader(l10n.partSelection),
          resizeToAvoidBottomInset: false,
          body: (provider.isDetailsDataLoading)
              ? const Center(
                  child: SizedBox(
                    height: Dimens.space_30,
                    width: Dimens.space_30,
                    child: CircularProgressIndicator(),
                  ),
                )
              : (provider.isDetailsDataLoading == false && provider.elssDeviceDetails == null)
                  ? Center(
                      child: Text(
                        l10n.noDataFound,
                        style: theme.primaryTextTheme.headline3,
                      ),
                    )
                  : _PartSelection(scannedBarCode: scannedBarcode),
        );
      },
    );
  }

  _productIdNullHandlingCallback(String barcode, {ElssDeviceDetailsResponse? detailsData}) {
    BrandDetailsListingArguments args = BrandDetailsListingArguments(
      barcode: barcode,
      deviceDetailsResponse: detailsData,
    );
    Navigator.of(context).pushReplacementNamed(BrandsDetailsListingScreen.route, arguments: args);
  }
}

class _PartSelection extends StatelessWidget {
  final String scannedBarCode;

  const _PartSelection({
    Key? key,
    required this.scannedBarCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = ELssProviderTrc.of(context);
    var theme = Theme.of(context);
    if (!Validator.isNullOrEmpty(provider.elssDeviceDetails?.errorMessage)) {
      return Padding(
        padding: const EdgeInsets.all(Dimens.space_16),
        child: Center(
          child: Row(
            children: [
              const SizedBox(),
              Expanded(
                child: Text(
                  provider.elssDeviceDetails!.errorMessage!,
                  style: theme.primaryTextTheme.headline3,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return PartSelectionWidgetTrc(
      barcode: scannedBarCode,
    );
  }
}
