import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';
import '../providers/add_part_list_provider_trc.dart';
import '../widgets/add_part_list_widget_trc.dart';

class AddPartScreenTrc extends StatelessWidget {
  static const route = '/add_part_screen_trc';

  const AddPartScreenTrc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var scannedBarcode = ModalRoute.of(context)?.settings.arguments as String;
    return ChangeNotifierProvider<AddPartListProviderTrc>(
      create: (_) => AddPartListProviderTrc(scannedBarcode),
      lazy: false,
      builder: (BuildContext innerContext, __) {
        var provider = AddPartListProviderTrc.of(innerContext);

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
              : (provider.isPartListLoading == false && provider.partDeviceListResponse == null)
                  ? Center(
                      child: Text(
                        l10n.noDataFound,
                        style: theme.primaryTextTheme.headline3,
                      ),
                    )
                  : const _AddPartList(),
        );
      },
    );
  }
}

class _AddPartList extends StatefulWidget {
  const _AddPartList({Key? key}) : super(key: key);

  @override
  State<_AddPartList> createState() => _AddPartListState();
}

class _AddPartListState extends State<_AddPartList> {
  @override
  Widget build(BuildContext context) {
    return const AddPartListWidgetTrc();
  }
}
