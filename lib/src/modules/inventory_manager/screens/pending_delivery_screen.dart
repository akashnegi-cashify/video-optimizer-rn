import 'dart:async';
import 'package:core_widgets/core_widgets.dart' as core;
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/pending_part_list_screen.dart';
import 'package:provider/provider.dart';
import '../../../screens/barcode_scanner_screen.dart';
import '../../../utils/paginate_list_abstract.dart';
import '../l10n.dart';
import '../models/pending_device_list_response.dart';
import '../providers/pending_delivery_provider.dart';
import '../widgets/pending_delivery_item_widget.dart';

class PendingDeliveryScreenArguments {
  final int id;

  PendingDeliveryScreenArguments({required this.id});
}

class PendingDeliveryScreen extends StatelessWidget {
  static const String route = "/pending_delivery_screen";

  const PendingDeliveryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)?.settings.arguments as PendingDeliveryScreenArguments;
    return ChangeNotifierProvider(
      create: (_) => PendingDeliveryProvider(arguments.id),
      lazy: false,
      child: const _PendingDeliveryScreenBody(),
    );
  }
}

class _PendingDeliveryScreenBody extends StatefulWidget {
  const _PendingDeliveryScreenBody({Key? key}) : super(key: key);

  @override
  State<_PendingDeliveryScreenBody> createState() => _PendingDeliveryScreenState();
}

class _PendingDeliveryScreenState extends PaginatedListState<PendingDeviceDetailData, _PendingDeliveryScreenBody> {
  _PendingDeliveryScreenState() : super(initialScrollOffset: 10, pageSize: 10);
  final TextEditingController _searchBarController = TextEditingController();
  bool _showUrgentRequestOnly = false;
  final core.TextInputDebounce _deBouncer = core.TextInputDebounce();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var provider = PendingDeliveryProvider.of(context);
    return Scaffold(
      appBar: core.CshHeader(
        l10n.requestedParts,
        showBackBtn: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(core.Dimens.space_8, core.Dimens.space_8, core.Dimens.space_8, 0),
            child: core.CshTextFormField(
              controller: _searchBarController,
              isBorderAllowed: true,
              hintText: l10n.searchItem,
              keyboardType: TextInputType.name,
              maxLength: 50,
              prefixIcon: core.CshIcon(
                FeatherIcons.search,
                padding: EdgeInsets.zero,
                iconColor: theme.primaryColor,
                iconSize: core.MobileIconSize.medium,
              ),
              suffixIcon: core.CshIcon.assets(
                "assets/images/ic_qr_scanner.png",
                padding: EdgeInsets.zero,
                iconSize: core.MobileIconSize.medium,
                onClick: () {
                  Navigator.of(context).pushNamed(BarcodeScanWidget.route, arguments: (String data) {
                    Navigator.of(context).pop();
                    provider.barcode = data.trim();
                    _searchBarController.text = data.trim();
                    resetAndRefreshScreen(pageNumber: 0);
                    provider.barcode = "";
                  });
                },
              ),
              onChanged: (data) {
                _deBouncer.start(() {
                  if (data.isNotEmpty) {
                    provider.barcode = data.trim();
                    resetAndRefreshScreen(pageNumber: 0);
                    provider.barcode = "";
                  } else {
                    provider.barcode = "";
                    resetAndRefreshScreen(pageNumber: 0);
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: core.Dimens.space_8),
            child: GestureDetector(
              onTap: () {
                _showUrgentRequestOnly = !_showUrgentRequestOnly;
                provider.isUrgent = _showUrgentRequestOnly;
                setState(() {});
                resetAndRefreshScreen(pageNumber: 0);
              },
              child: Row(
                children: [
                  core.CshCheckbox(
                    isSelected: _showUrgentRequestOnly,
                  ),
                  Text(
                    l10n.showUrgentRequestsOnly,
                    style: theme.primaryTextTheme.headline4,
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: iterate(
              (item, index) {
                return PendingDeliveryListItemWidget(
                  index: (index + 1),
                  dataModel: item,
                  onCardPressed: () {
                    if (item.did != null) {
                      PendingPartListScreenArguments arguments = PendingPartListScreenArguments(
                        detailsModelData: item,
                        did: item.did!,
                      );
                      Navigator.of(context).pushNamed(PendingPartListScreen.route, arguments: arguments);
                    } else {
                      core.CshSnackBar.error(context: context, message: l10n.noDidPresent);
                    }
                  },
                );
              },
              onRefresh: () async {},
              separator: const SizedBox(height: core.Dimens.space_8),
              onNoDataFound: () {
                return Center(
                  child: Text(
                    l10n.noDataFound,
                    style: theme.primaryTextTheme.subtitle1,
                    textAlign: TextAlign.center,
                  ),
                );
              },
              onError: (String error) {
                return Center(
                  child: Row(
                    children: [
                      const SizedBox.shrink(),
                      Expanded(
                        child: Text(
                          error,
                          style: theme.primaryTextTheme.headline3,
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                );
              },
              padding: const EdgeInsets.symmetric(horizontal: core.Dimens.space_16),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void requestApi(int pageNo,
      {Function(List<PendingDeviceDetailData>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = PendingDeliveryProvider.of(context, listen: false);
    provider.getPendingDeviceList(pageNo++).then((value) {
      if (onSuccess != null) {
        onSuccess(value.data?.dataList);
      }
    }, onError: (error) {
      if (onError != null) {
        onError(error);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _searchBarController.dispose();
    _deBouncer.stop();
  }
}
