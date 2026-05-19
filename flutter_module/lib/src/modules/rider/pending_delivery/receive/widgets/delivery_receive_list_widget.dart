import 'package:components/components.dart';
import 'package:components/resources/list/list_request.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/rider/l10n.dart';
import 'package:flutter_trc/src/services/service_groups.dart';
import 'package:provider/provider.dart';

import '../models/receive_response_model.dart';
import '../providers/delivery_receive_provider.dart';
import 'item_delivery_receive_widget.dart';

class DeliveryReceiveListWidget extends StatefulWidget {
  const DeliveryReceiveListWidget({Key? key}) : super(key: key);

  @override
  State<DeliveryReceiveListWidget> createState() => _DeliveryReceiveListWidgetState();
}

class _DeliveryReceiveListWidgetState extends State<DeliveryReceiveListWidget> {
  final CshListController _listController = CshListController();
  late DeliveryReceiveProvider provider;
  late L10n l10;
  FilterConfig? _filterConfig;
  var _listRefreshCounter = 0;
  bool _isListenerAdded = false;

  @override
  void didChangeDependencies() {
    provider = Provider.of<DeliveryReceiveProvider>(context, listen: false);
    l10 = L10n(context);
    if (!_isListenerAdded) {
      _isListenerAdded = true;
      provider.addListener(_refreshList);
    }
    super.didChangeDependencies();
  }

  FilterConfig _getFilterConfig() {
    return FilterConfig(initialFilter: [
      if (!Validator.isNullOrEmpty(provider.searchQuery))
        AdminFilterList(
          type: CshFilterValueType.contains.value,
          field: 'partStock.barcode',
          value: AdminFilterData(search: provider.searchQuery),
        ),
    ]);
  }

  void _refreshList() {
    setState(() {
      _listRefreshCounter++;
      _filterConfig = _getFilterConfig();
    });
  }

  @override
  void dispose() {
    provider.removeListener(_refreshList);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _filterConfig ??= _getFilterConfig();
    return CshApiList<Part>(
      key: ObjectKey(_listRefreshCounter),
      apiConfig: ListApiConfig(
        apiUrl: "/rider/delivery/pickup/pending",
        serviceGroup: TRCServiceGroups.unifyTrc,
      ),
      filterConfig: _filterConfig,
      controller: _listController,
      itemFromJson: Part.fromJson,
      shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
      listPadding: EdgeInsets.zero,
      verticalRowSpacing: Dimens.space_8,
      isHideCoreFilterButton: true,
      getRowWidget: (item, index) {
        final data = item;
        return ItemDeliveryReceiveWidget(
          item: data!,
          onReceiveConfirm: _refreshList,
        );
      },
    );
  }
}
