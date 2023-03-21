import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';
import '../models/parts_details_response.dart';
import '../models/pending_device_list_response.dart';
import '../providers/alternate_part_list_provider.dart';

class AlternatePartArguments {
  final PendingDeviceDetailData? detailsModelData;
  final int prid;
  final PartDetailsData? itemDataModel;

  AlternatePartArguments({
    required this.prid,
    this.detailsModelData,
    this.itemDataModel,
  });
}

class AlternatePartScreen extends StatefulWidget {
  static const String route = "/alternate_part_screen";

  const AlternatePartScreen({Key? key}) : super(key: key);

  @override
  State<AlternatePartScreen> createState() => _AlternatePartScreenState();
}

class _AlternatePartScreenState extends State<AlternatePartScreen> {
  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)?.settings.arguments as AlternatePartArguments;
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return ChangeNotifierProvider<AlternatePartListProvider>(
      create: (_) => AlternatePartListProvider(arg.prid),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        var provider = AlternatePartListProvider.of(insideContext);
        if (provider.isDataLoading) {
          return const Scaffold(
            body: Center(
              child: SizedBox(
                width: Dimens.space_30,
                height: Dimens.space_30,
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else if (provider.isDataLoading == false && !Validator.isNullOrEmpty(provider.errorMessage)) {
          return Scaffold(
            appBar: CshHeader(
              l10n.alternatePartList,
              showBackBtn: true,
            ),
            body: Center(
              child: Row(
                children: [
                  const SizedBox.shrink(),
                  Expanded(
                    child: Text(
                      provider.errorMessage,
                      style: theme.primaryTextTheme.headline4,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: CshHeader(
              l10n.alternatePartList,
              showBackBtn: true,
            ),
            body: Text("Hello world"),
          );
        }
      },
    );
  }
}
