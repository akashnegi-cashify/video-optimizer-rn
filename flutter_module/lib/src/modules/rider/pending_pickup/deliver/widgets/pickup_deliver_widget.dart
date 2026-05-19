import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/rider/l10n.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/deliver/providers/pickup_deliver_provider.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/deliver/widgets/pickup_deliver_list_widget.dart';
import 'package:provider/provider.dart';

class PickupDeliverWidget extends StatefulWidget {
  const PickupDeliverWidget({Key? key}) : super(key: key);

  @override
  State<PickupDeliverWidget> createState() => _PickupDeliverWidgetState();
}

class _PickupDeliverWidgetState extends State<PickupDeliverWidget> with AutomaticKeepAliveClientMixin {
  bool isUrgentRequest = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    L10n l10n = L10n(context);
    return ChangeNotifierProvider(create: (context) {
      return PickupDeliverProvider();
    }, builder: (context, child) {
      var provider = Provider.of<PickupDeliverProvider>(context, listen: false);
      return Column(
        children: [
          SearchBarWidget(
            hintText: l10n.search,
            onQuery: (query) {
              provider.searchQuery = query;
            },
          ),
          const Expanded(
            child: PickupDeliverListWidget(),
          )
        ],
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
