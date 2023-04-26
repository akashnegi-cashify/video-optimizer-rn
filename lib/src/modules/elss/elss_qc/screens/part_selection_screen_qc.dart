import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';
import '../providers/elss_provider_qc.dart';
import '../widgets/part_selection_widget.dart';

class PartSelectionScreenQc extends StatelessWidget {
  static const route = '/part_selection_screen_qc';

  const PartSelectionScreenQc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    String scannedBarcode = ModalRoute.of(context)?.settings.arguments as String;
    return ChangeNotifierProvider<ELssProviderQc>(
      create: (_) => ELssProviderQc(scannedBarcode),
      lazy: false,
      builder: (BuildContext innerContext, __) {
        var provider = ELssProviderQc.of(innerContext);

        return Scaffold(
          appBar: TrcHeader(l10n.deviceDetails),
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
                        (provider.detailsApiErrorMessage.isNotEmpty)
                            ? provider.detailsApiErrorMessage
                            : l10n.noDataFound,
                        textAlign: TextAlign.center,
                        style: theme.primaryTextTheme.headline3,
                      ),
                    )
                  : _PartSelection(scannedBarCode: scannedBarcode),
        );
      },
    );
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
    var provider = ELssProviderQc.of(context);
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

    return PartSelectionWidget(
      barcode: scannedBarCode,
    );
  }
}
