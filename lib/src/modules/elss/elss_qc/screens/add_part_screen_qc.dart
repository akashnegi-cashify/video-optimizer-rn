import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';
import '../providers/add_part_list_provider_qc.dart';
import '../widgets/add_part_list_widget_qc.dart';

class AddPartScreenQc extends StatelessWidget {
  static const route = '/add_part_screen_qc';

  const AddPartScreenQc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var scannedBarcode = ModalRoute.of(context)?.settings.arguments as String;
    return ChangeNotifierProvider<AddPartListProviderQc>(
      create: (_) => AddPartListProviderQc(scannedBarcode),
      lazy: false,
      builder: (BuildContext innerContext, __) {
        var provider = AddPartListProviderQc.of(innerContext);

        return Scaffold(
          appBar: TrcHeader(l10n.addPart),
          body: (provider.isPartListLoading)
              ? const Center(
                  child: SizedBox(
                    height: Dimens.space_30,
                    width: Dimens.space_30,
                    child: CircularProgressIndicator(),
                  ),
                )
              : const AddPartListWidgetQc(),
        );
      },
    );
  }
}
