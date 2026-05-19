import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/rider/l10n.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/deliver/providers/pickup_deliver_provider.dart';
import 'package:flutter_trc/src/services/service_groups.dart';
import 'package:provider/provider.dart';

import '../../../../../common/widgets/key_value_row_widget.dart';
import '../../../pending_delivery/receive/models/receive_response_model.dart';

class PickupDeliverListWidget extends StatefulWidget {
  const PickupDeliverListWidget({Key? key}) : super(key: key);

  @override
  State<PickupDeliverListWidget> createState() => _PickupDeliverListWidgetState();
}

class _PickupDeliverListWidgetState extends State<PickupDeliverListWidget> {
  final CshListController _listController = CshListController();
  late PickupDeliverProvider provider;
  late L10n l10n;

  @override
  void didChangeDependencies() {
    provider = Provider.of<PickupDeliverProvider>(context, listen: false);
    l10n = L10n(context);
    provider.addListener(() {
      _refreshList();
    });
    super.didChangeDependencies();
  }

  FilterConfig _getFilterConfig() {
    return FilterConfig(filterData: [
      CshFilterData(
        label: "Search Barcode",
        field: 'partBarcode',
        crudFilter: 'barcode',
        filterType: CshFilterType.input,
        valueType: CshFilterValueType.contains,
        position: FilterPosition.top,
        keyboardType: TextInputType.text,
        filterGroup: FilterGroupType.multipleTypeSearch,
      ),
    ]);
  }

  void _refreshList() {
    _listController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return CshApiList<Part>(
      apiConfig: ListApiConfig(
        apiUrl: "/rider/return/picked",
        serviceGroup: TRCServiceGroups.unifyTrc,
      ),
      filterConfig: _getFilterConfig(),
      controller: _listController,
      itemFromJson: Part.fromJson,
      shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
      listPadding: EdgeInsets.zero,
      verticalRowSpacing: Dimens.space_8,
      isHideCoreFilterButton: true,
      getRowWidget: (item, index) {
        final data = item;
        return _Item(part: data!);
      },
    );
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
            if (!Validator.isNullOrEmpty(part.partVariantName))
              KeyValueRowWidget(title: l10n.skuName, value: part.partVariantName!),
          ],
        ),
      ),
    );
  }
}
