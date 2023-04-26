import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/rubbing/l10n.dart';
import 'package:flutter_trc/src/modules/rubbing/providers/received_devices_provider.dart';
import 'package:flutter_trc/src/modules/rubbing/widgets/received_devices_list_widget.dart';
import 'package:provider/provider.dart';

import '../../../common/widgets/searchbar_widget.dart';

class ReceivedRubbingDevicesWidget extends StatelessWidget {
  const ReceivedRubbingDevicesWidget({Key? key}) : super(key: key);
  static const route = "/rubbing/device/list";

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    String? searchQuery = ModalRoute.of(context)?.settings.arguments as String?;

    return ChangeNotifierProvider<ReceivedDevicesProvider>(
      create: (context) => ReceivedDevicesProvider(query: searchQuery),
      builder: (context, widget) {
        ReceivedDevicesProvider provider = Provider.of<ReceivedDevicesProvider>(context, listen: false);

        return Scaffold(
          appBar: TrcHeader(l10n.receivedDevice),
          body: SafeArea(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(Dimens.space_16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimens.space_4),
                      border: Border.all(color: Theme.of(context).secondaryHeaderColor)),
                  child: SearchbarWidget(
                    initialText: searchQuery,
                    hint: l10n.searchBarCode,
                    onQuery: (query) {
                      provider.searchQuery = query;
                    },
                  ),
                ),
                Selector<ReceivedDevicesProvider, String?>(builder: (context, query, widget) {
                  return Expanded(child: ReceivedDevicesListWidget(key: UniqueKey()));
                }, selector: (context, provider) {
                  return provider.searchQuery;
                })
              ],
            ),
          ),
        );
      },
    );
  }
}
