import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';
import '../models/pending_device_list_response.dart';
import '../providers/pending_part_list_provider.dart';
import '../widgets/pending_delivery_item_widget.dart';
import '../widgets/pending_part_list_item_widget.dart';

class PendingPartListScreenArguments {
  final PendingDeviceDetailData? detailsModelData;
  final int did;

  PendingPartListScreenArguments({
    this.detailsModelData,
    required this.did,
  });
}

class PendingPartListScreen extends StatefulWidget {
  static const String route = "/pending_part_list_screen";

  const PendingPartListScreen({Key? key}) : super(key: key);

  @override
  State<PendingPartListScreen> createState() => _PendingPartListScreenState();
}

class _PendingPartListScreenState extends State<PendingPartListScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var args = ModalRoute.of(context)?.settings.arguments as PendingPartListScreenArguments;

    return ChangeNotifierProvider<PendingPartListProvider>(
      create: (_) => PendingPartListProvider(args.did),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        return Scaffold(
          appBar: CshHeader(
            l10n.pendingPartListScreen,
            showBackBtn: true,
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(Dimens.space_8, Dimens.space_8, Dimens.space_8, 0),
                child: PendingDeliveryListItemWidget(
                  index: 0,
                  dataModel: args.detailsModelData,
                  showIndexingNumber: false,
                ),
              ),
              const SizedBox(height: Dimens.space_16),
              Expanded(
                child: _getWidget(insideContext, theme, args.detailsModelData),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _getWidget(BuildContext context, ThemeData theme, PendingDeviceDetailData? detailsModelData) {
    var provider = PendingPartListProvider.of(context);
    if (provider.isDataLoading) {
      return const Center(
        child: SizedBox(
          height: Dimens.space_30,
          width: Dimens.space_30,
          child: CircularProgressIndicator(),
        ),
      );
    } else if (provider.isDataLoading && !Validator.isNullOrEmpty(provider.errorMessage)) {
      return Center(
        child: Row(
          children: [
            const SizedBox.shrink(),
            Expanded(
              child: Text(
                provider.errorMessage,
                style: theme.primaryTextTheme.headline3,
              ),
            )
          ],
        ),
      );
    } else {
      if (!Validator.isListNullOrEmpty(provider.pendingPartListResponse?.partDataList)) {
        return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: Dimens.space_16, horizontal: Dimens.space_8),
            itemBuilder: (context, index) {
              return PendingPartListItemWidget(
                dataModel: provider.pendingPartListResponse!.partDataList![index],
                detailsModelData: detailsModelData,
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: Dimens.space_8);
            },
            itemCount: provider.pendingPartListResponse!.partDataList!.length);
      } else {
        return const SizedBox();
      }
    }
  }
}
