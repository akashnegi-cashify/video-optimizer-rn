import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';
import '../providers/add_part_list_provider.dart';
import '../widgets/add_part_list_widget.dart';

class AddPartScreen extends StatelessWidget {
  static const route = '/add_part_screen';

  const AddPartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var scannedBarcode = ModalRoute.of(context)?.settings.arguments as String;
    return ChangeNotifierProvider<AddPartListProvider>(
      create: (_) => AddPartListProvider(scannedBarcode),
      lazy: false,
      builder: (BuildContext innerContext, __) {
        var provider = AddPartListProvider.of(innerContext);

        return Scaffold(
          appBar: CshHeader(l10n.addPart),
          body: (provider.isPartListLoading)
              ? const Center(
                  child: SizedBox(
                    height: Dimens.space_30,
                    width: Dimens.space_30,
                    child: CircularProgressIndicator(),
                  ),
                )
              : const AddPartListWidget(),
        );
      },
    );
  }
}
