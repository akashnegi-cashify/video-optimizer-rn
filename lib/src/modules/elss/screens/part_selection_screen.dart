import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/providers/elss_provider.dart';
import 'package:flutter_trc/src/modules/elss/widgets/part_selection_widget.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';

class PartSelectionScreen extends StatelessWidget {
  static const route = '/part_selection_screen';

  const PartSelectionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    String scannedBarcode = ModalRoute.of(context)?.settings.arguments as String;
    return ChangeNotifierProvider<ELssProvider>(
      create: (_) => ELssProvider(scannedBarcode),
      lazy: false,
      builder: (BuildContext innerContext, __) {
        var provider = ELssProvider.of(innerContext);

        return Scaffold(
          appBar: CshHeader(l10n.deviceDetails),
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
}

class _PartSelection extends StatelessWidget {
  final String scannedBarCode;

  const _PartSelection({
    Key? key,
    required this.scannedBarCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = ELssProvider.of(context);
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
