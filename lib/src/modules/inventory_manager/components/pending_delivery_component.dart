import 'package:builder_component/builder_component.dart';
import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/pending_device_list_response.dart';
import 'package:flutter_trc/src/modules/inventory_manager/providers/pending_delivery_provider.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/pending_delivery_screen.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/pending_part_list_screen.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/pending_delivery_item_widget.dart';
import 'package:flutter_trc/src/screens/barcode_scanner_screen.dart';
import 'package:flutter_trc/src/utils/paginate_list_abstract.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../models/pending_delivery_comp_config.dart';
import '../models/pending_delivery_comp_param.dart';

part 'pending_delivery_component.g.dart';

@CshComponent(
    key: PendingDeliveryComponent.COMP_KEY,
    configModel: PendingDeliveryCompConfig,
    params: PendingDeliveryCompParamKeys.values,
    paramModel: PendingDeliveryCompParam,
    componentGroup: ComponentGroup.pendingDeliveryComponentKey)
class PendingDeliveryComponent extends StatelessComponent<PendingDeliveryCompConfig> {
  static const String COMP_KEY = "TRC_pending_delivery_comp";

  const PendingDeliveryComponent(super.jsonConfig, {super.key});

  @override
  Widget buildView(BuildContext context, configModel) {
    return paramBuilder((param) {
      return const _PendingDeliveryWidget();
    });
  }

  @override
  Function(Map<String, dynamic> data)? fromConfig() {
    return PendingDeliveryCompConfig.fromConfig;
  }
}

class _PendingDeliveryWidget extends StatelessWidget {
  const _PendingDeliveryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var arguments = ModalRoute.of(context)?.settings.arguments as PendingDeliveryScreenCompArguments;
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
  final TextInputDebounce _deBouncer = TextInputDebounce();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var provider = PendingDeliveryProvider.of(context);
    return Scaffold(
      appBar: CshHeader(
        l10n.requestedParts,
        showBackBtn: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(Dimens.space_8, Dimens.space_8, Dimens.space_8, 0),
            child: CshTextFormField(
              controller: _searchBarController,
              isBorderAllowed: true,
              hintText: l10n.searchItem,
              keyboardType: TextInputType.name,
              maxLength: 50,
              prefixIcon: CshIcon(
                FeatherIcons.search,
                padding: EdgeInsets.zero,
                iconColor: theme.primaryColor,
                iconSize: MobileIconSize.medium,
              ),
              suffixIcon: CshIcon.assets(
                "assets/images/ic_qr_scanner.png",
                padding: EdgeInsets.zero,
                iconSize: MobileIconSize.medium,
                onClick: () {
                  Navigator.of(context).pushNamed(BarcodeScanWidget.route, arguments: (String data) {
                    Navigator.of(context).pop();
                    provider.barcode = data.trim();
                    _searchBarController.text = data.trim();
                    resetAndRefreshScreen();
                    provider.barcode = "";
                  });
                },
              ),
              onChanged: (data) {
                _deBouncer.start(() {
                  if (data.isNotEmpty) {
                    provider.barcode = data.trim();
                    resetAndRefreshScreen();
                    provider.barcode = "";
                  } else {
                    provider.barcode = "";
                    resetAndRefreshScreen();
                  }
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8),
            child: GestureDetector(
              onTap: () {
                _showUrgentRequestOnly = !_showUrgentRequestOnly;
                provider.isUrgent = _showUrgentRequestOnly;
                setState(() {});
                resetAndRefreshScreen();
              },
              child: Row(
                children: [
                  CshCheckbox(
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
                      PendingPartListCompScreenArguments args = PendingPartListCompScreenArguments(
                          arguments: PendingPartListScreenArguments(
                        detailsModelData: item,
                        did: item.did!,
                      ));

                      Navigator.of(context).pushNamed(PendingPartListScreen.route, arguments: args);
                    } else {
                      CshSnackBar.error(context: context, message: l10n.noDidPresent);
                    }
                  },
                );
              },
              onRefresh: () async {},
              // separator: const SizedBox(height: Dimens.space_8),
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
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
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
