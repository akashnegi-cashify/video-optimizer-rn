import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/rider/l10n.dart';
import 'package:provider/provider.dart';

import 'delivery_deliver_list_widget.dart';
import '../providers/delivery_deliver_provider.dart';

class DeliveryDeliverWidget extends StatefulWidget {
  const DeliveryDeliverWidget({Key? key}) : super(key: key);

  @override
  State<DeliveryDeliverWidget> createState() => _DeliveryDeliverWidgetState();
}

class _DeliveryDeliverWidgetState extends State<DeliveryDeliverWidget> with AutomaticKeepAliveClientMixin {
  bool isUrgentRequest = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    L10n l10 = L10n(context);

    return ChangeNotifierProvider(create: (context) {
      return DeliveryDeliverProvider((error) {
        String errorMessage = ApiErrorHelper.getErrorMessage(error) ?? l10.somethingWentWrong;
        CshSnackBar.error(context: context, message: errorMessage);
      });
    }, builder: (context, child) {
      var provider = Provider.of<DeliveryDeliverProvider>(context, listen: false);
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
                  isSelected: isUrgentRequest),
              CshTextNew.h4(l10.showUrgentRequestsOnly)
            ],
          ),
          const Expanded(
            child: DeliveryDeliverListWidget(),
          )
        ],
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
