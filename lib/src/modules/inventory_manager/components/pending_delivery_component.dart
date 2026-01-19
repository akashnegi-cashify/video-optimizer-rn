import 'package:builder_component/builder_component.dart';
import 'package:components/components.dart';
import 'package:components/resources/list/list_request.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/app_builder/app_headers/general_app_header/models/none_config_model.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/modules/inventory_manager/models/pending_device_list_response.dart';
import 'package:flutter_trc/src/modules/inventory_manager/providers/pending_delivery_provider.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/pending_delivery_screen.dart';
import 'package:flutter_trc/src/modules/inventory_manager/screens/pending_part_list_screen.dart';
import 'package:flutter_trc/src/modules/inventory_manager/widgets/pending_delivery_item_widget.dart';
import 'package:flutter_trc/src/services/service_groups.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../models/pending_delivery_comp_param.dart';

part 'pending_delivery_component.g.dart';

@CshComponent(
    key: PendingDeliveryComponent.COMP_KEY,
    configModel: NoneConfigModel,
    params: PendingDeliveryCompParamKeys.values,
    paramModel: PendingDeliveryCompParam,
    componentGroup: ComponentGroup.pendingDeliveryComponentKey)
class PendingDeliveryComponent extends StatelessComponent<NoneConfigModel> {
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
    return NoneConfigModel.fromConfig;
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

class _PendingDeliveryScreenState extends State<_PendingDeliveryScreenBody> {
  final CshListController _listController = CshListController();
  final TextEditingController _searchBarController = TextEditingController();
  bool _showUrgentRequestOnly = false;
  final TextInputDebounce _deBouncer = TextInputDebounce();
  FilterConfig? _filterConfig;

  void refreshList() {
    _listController.refresh();
  }

  FilterConfig _getFilterConfig(PendingDeliveryProvider provider) {
    List<AdminFilterList> preSelectedFilters = [];

    if (provider.barcode.isNotEmpty) {
      preSelectedFilters.add(
        AdminFilterList(
          type: CshFilterValueType.contains.value,
          field: 'barcode',
          value: AdminFilterData(search: provider.barcode),
        ),
      );
    }

    if (provider.eid != null) {
      preSelectedFilters.add(
        AdminFilterList(
          type: CshFilterValueType.equality.value,
          field: 'engineer.id',
          value: AdminFilterData(search: provider.eid.toString()),
        ),
      );
    }

    if (Validator.isTrue(_showUrgentRequestOnly)) {
      preSelectedFilters.add(
        AdminFilterList(
          type: CshFilterValueType.equality.value,
          field: 'isUrgent',
          value: AdminFilterData(search: _showUrgentRequestOnly.toString()),
        ),
      );
    }

    return FilterConfig(initialFilter: preSelectedFilters);
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var provider = PendingDeliveryProvider.of(context);
    _filterConfig = _getFilterConfig(provider);
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
                  CshMlScannerUtil().openScanner(
                    context,
                    onScanned: (scannedData, controller) {
                      Navigator.of(context).pop(); // dismiss the scanner
                      provider.barcode = scannedData.trim();
                      _searchBarController.text = scannedData.trim();
                      setState(() {
                        _filterConfig = _getFilterConfig(provider);
                      });
                    },
                  );
                },
              ),
              onChanged: (data) {
                _deBouncer.start(() {
                  if (data.isNotEmpty) {
                    provider.barcode = data.trim();
                  } else {
                    provider.barcode = "";
                  }
                  setState(() {
                    _filterConfig = _getFilterConfig(provider);
                  });
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_8),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _showUrgentRequestOnly = !_showUrgentRequestOnly;
                  _filterConfig = _getFilterConfig(provider);
                });
              },
              child: Row(
                children: [
                  CshCheckbox(isSelected: _showUrgentRequestOnly),
                  Text(l10n.showUrgentRequestsOnly, style: theme.primaryTextTheme.headlineMedium)
                ],
              ),
            ),
          ),
          Expanded(
            child: Consumer<PendingDeliveryProvider>(
              builder: (context, provider, child) {
                return CshApiList<PendingDeviceDetailData>(
                  key: ObjectKey("${provider.barcode}-$_showUrgentRequestOnly"),
                  apiConfig: ListApiConfig(
                    apiUrl: "/inventory/list-pending-delivery-device-parts",
                    serviceGroup: TRCServiceGroups.unifyTrc,
                  ),
                  filterConfig: _filterConfig,
                  controller: _listController,
                  itemFromJson: PendingDeviceDetailData.fromJson,
                  shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
                  listPadding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
                  verticalRowSpacing: Dimens.space_16,
                  isHideCoreFilterButton: true,
                  getRowWidget: (item, index) {
                    final data = item;
                    return PendingDeliveryListItemWidget(
                      index: (index + 1),
                      dataModel: data,
                      onCardPressed: () {
                        if (data?.deviceId != null) {
                          PendingPartListCompScreenArguments args = PendingPartListCompScreenArguments(
                              arguments: PendingPartListScreenArguments(
                            detailsModelData: data,
                            did: data!.deviceId!,
                          ));

                          Navigator.of(context).pushNamed(PendingPartListScreen.route, arguments: args);
                        } else {
                          CshSnackBar.error(context: context, message: l10n.noDidPresent);
                        }
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _searchBarController.dispose();
    _deBouncer.stop();
  }
}
