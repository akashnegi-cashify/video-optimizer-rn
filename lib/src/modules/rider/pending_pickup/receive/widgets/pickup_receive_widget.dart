import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/rider/engineer_card_widget.dart';
import 'package:flutter_trc/src/modules/rider/l10n.dart';
import 'package:flutter_trc/src/modules/rider/pending_pickup/receive/widgets/pickup_receive_engineer_parts_widget.dart';
import 'package:provider/provider.dart';
import '../providers/pickup_receive_provider.dart';

class PickupReceiveWidget extends StatefulWidget {
  const PickupReceiveWidget({Key? key}) : super(key: key);

  @override
  State<PickupReceiveWidget> createState() => _PickupReceiveWidgetState();
}

class _PickupReceiveWidgetState extends State<PickupReceiveWidget>
    with AutomaticKeepAliveClientMixin {
  bool isUrgentRequest = false;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    L10n l10n = L10n(context);

    return ChangeNotifierProvider(create: (context) {
      return PickupReceiveProvider((error) {
        CshSnackBar.error(
            context: context,
            message: ApiErrorHelper.getErrorMessage(error) ??
                l10n.somethingWentWrong);
      });
    }, builder: (context, child) {
      var provider = Provider.of<PickupReceiveProvider>(context, listen: false);
      return Column(
        children: [
          SearchBarWidget(
            hintText: l10n.search,
            onQuery: (query) {
              provider.searchQuery = query;
            },
          ),
          Expanded(child: Consumer<PickupReceiveProvider>(
              builder: (context, provider, widget) {
            var list = provider.displayList;
            if (list != null) {
              return CshList(
                rowCount: list.length,
                onRefresh: () {
                  provider.getData();
                },
                getRowWidget: (index) {
                  return GestureDetector(
                    child: EngineerCardWidget(detail: list[index]),
                    onTap: () {
                      Navigator.pushNamed(
                          context, PickupReceiveEngineerPartsWidget.route,
                          arguments: list[index]);
                    },
                  );
                },
              );
            } else {
              return const SizedBox.shrink();
            }
          }))
        ],
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
