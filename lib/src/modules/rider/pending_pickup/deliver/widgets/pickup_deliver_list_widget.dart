import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/rider/l10n.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/deliver/providers/pickup_deliver_provider.dart';
import 'package:provider/provider.dart';

import '../../../../../common/widgets/key_value_row_widget.dart';
import '../../../../../common/widgets/paginated_listview.dart';
import '../../../pending_delivery/receive/models/receive_response_model.dart';

class PickupDeliverListWidget extends StatefulWidget {
  const PickupDeliverListWidget({Key? key}) : super(key: key);

  @override
  State<PickupDeliverListWidget> createState() => _PickupDeliverListWidgetState();
}

class _PickupDeliverListWidgetState extends PaginatedListState<Part, PickupDeliverListWidget> {
  late PickupDeliverProvider provider;

  late L10n l10n;

  @override
  void didChangeDependencies() {
    provider = Provider.of<PickupDeliverProvider>(context, listen: false);
    l10n = L10n(context);
    provider.addListener(() {
      resetAndRefreshScreen();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return this.iterate((item, index) {
      return _Item(part: item!);
    }, onRefresh: () async {});
  }

  @override
  void requestApi(int pageNo, int pageSize,
      {Function(List<Part>? list)? onSuccess, Function(String? errorMessage)? onError}) {
    provider.getDataStream(pageNo, pageSize, provider.searchQuery).listen((event) {
      if (onSuccess != null) onSuccess(event?.data?.partList);
    }).onError((e) {
      if (onError != null) onError(e);
      CshSnackBar.error(context: context, message: ApiErrorHelper.getError(e).message ?? l10n.somethingWentWrong);
    });
  }
}

class _Item extends StatelessWidget {
  final Part part;

  const _Item({Key? key, required this.part}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_8),
      child: CshCard(
          child: Column(
        children: [
          KeyValueRowWidget(title: l10n.partName, value: part.partName),
          KeyValueRowWidget(title: l10n.partBarcode, value: part.partBarcode),
          KeyValueRowWidget(title: l10n.partSku, value: part.partSku),
        ],
      )),
    );
  }
}
