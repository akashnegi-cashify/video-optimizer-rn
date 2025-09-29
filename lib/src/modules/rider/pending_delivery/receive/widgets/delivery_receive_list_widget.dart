import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/paginated_listview.dart';
import 'package:flutter_trc/src/modules/rider/l10n.dart';
import 'package:provider/provider.dart';

import '../models/receive_response_model.dart';
import '../providers/delivery_receive_provider.dart';
import 'item_delivery_receive_widget.dart';
import 'package:core/core.dart';

class DeliveryReceiveListWidget extends StatefulWidget {
  const DeliveryReceiveListWidget({Key? key}) : super(key: key);

  @override
  State<DeliveryReceiveListWidget> createState() => _DeliveryReceiveListWidgetState();
}

class _DeliveryReceiveListWidgetState extends PaginatedListState<Part, DeliveryReceiveListWidget> {
  late DeliveryReceiveProvider provider;
  late L10n l10;

  @override
  void didChangeDependencies() {
    provider = Provider.of<DeliveryReceiveProvider>(context, listen: false);
    l10 = L10n(context);
    provider.addListener(() {
      resetAndRefreshScreen();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return this.iterate((item, index) {
      return ItemDeliveryReceiveWidget(
        item: item!,
        onReceiveConfirm: resetAndRefreshScreen,
      );
    }, onRefresh: () async {});
  }

  @override
  void requestApi(int pageNo, int pageSize,
      {Function(List<Part>? list)? onSuccess, Function(String? errorMessage)? onError}) {
    provider.getDataStream(pageNo, pageSize, provider.isUrgent, provider.searchQuery).listen((event) {
      if (onSuccess != null) onSuccess(event?.data?.partList);
    }).onError((e) {
      CshSnackBar.error(context: context, message: ApiErrorHelper.getErrorMessage(e) ?? l10.somethingWentWrong);
    });
  }
}
