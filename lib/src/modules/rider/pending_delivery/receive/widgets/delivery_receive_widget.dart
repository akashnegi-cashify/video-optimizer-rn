import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/rider/l10n.dart';
import 'package:provider/provider.dart';

import '../providers/delivery_receive_provider.dart';
import 'delivery_receive_list_widget.dart';

class DeliveryReceiveWidget extends StatefulWidget {
  const DeliveryReceiveWidget({Key? key}) : super(key: key);

  @override
  State<DeliveryReceiveWidget> createState() => _DeliveryReceiveWidgetState();
}

class _DeliveryReceiveWidgetState extends State<DeliveryReceiveWidget> with AutomaticKeepAliveClientMixin {
  bool isUrgentRequest = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider(create: (context) {
      return DeliveryReceiveProvider();
    }, builder: (context, child) {
      var provider = Provider.of<DeliveryReceiveProvider>(context, listen: false);

      L10n l10 = L10n(context);
      return Column(
        children: [
          SearchBarWidget(
            hintText: l10.search,
            onQuery: (query) {
              provider.searchQuery = query;
            },
          ),
          Row(
            children: [
              CshCheckbox(
                onChanged: (check) {
                  setState(() {
                    isUrgentRequest = check ?? false;
                    provider.isUrgent = check ?? false;
                  });
                },
                isSelected: isUrgentRequest,
              ),
              CshTextNew.h4(l10.showUrgentRequestsOnly)
            ],
          ),
          const Expanded(
            child: DeliveryReceiveListWidget(),
          )
        ],
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
