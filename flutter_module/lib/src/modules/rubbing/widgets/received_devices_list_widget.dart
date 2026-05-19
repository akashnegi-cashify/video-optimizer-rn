import 'package:components/components.dart';
import 'package:components/resources/list/list_request.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/common/widgets/multiple_image_upload_screen.dart';
import 'package:flutter_trc/src/common/widgets/search_with_scanner_widget.dart';
import 'package:flutter_trc/src/common/widgets/title_value_row_widget.dart';
import 'package:flutter_trc/src/modules/rubbing/l10n.dart';
import 'package:flutter_trc/src/modules/rubbing/model/glass_change_fail_reason_response.dart';
import 'package:flutter_trc/src/modules/rubbing/model/rubbing_device_data.dart';
import 'package:flutter_trc/src/modules/rubbing/providers/received_devices_provider.dart';
import 'package:flutter_trc/src/modules/rubbing/resources/rubbing_module_role_type.dart';
import 'package:flutter_trc/src/resources/user_details.dart';
import 'package:flutter_trc/src/services/service_groups.dart';
import 'package:provider/provider.dart';

class ReceivedDevicesListWidget extends StatefulWidget {
  const ReceivedDevicesListWidget({super.key});

  @override
  State<ReceivedDevicesListWidget> createState() => _ReceivedDevicesListWidgetState();
}

class _ReceivedDevicesListWidgetState extends State<ReceivedDevicesListWidget> {
  final CshListController _listController = CshListController();
  FilterConfig? _filterConfig;
  int _updateCounter = 0;

  FilterConfig _getFilterConfig(BuildContext context) {
    var provider = Provider.of<ReceivedDevicesProvider>(context, listen: false);
    List<AdminFilterList> preSelectedFilters = [];

    // Add barcode filter if selected
    if (provider.searchQuery != null && provider.searchQuery?.isNotEmpty == true) {
      preSelectedFilters.add(
        AdminFilterList(
          type: CshFilterValueType.contains.value,
          field: "barcode",
          value: AdminFilterData(search: provider.searchQuery),
        ),
      );
    }
    return FilterConfig(initialFilter: preSelectedFilters, filterData: [
      // CshFilterData(
      //   label: "Search Device Barcode",
      //   field: 'deviceBarcode',
      //   crudFilter: 'barcode',
      //   filterType: CshFilterType.input,
      //   valueType: CshFilterValueType.contains,
      //   position: FilterPosition.top,
      //   keyboardType: TextInputType.text,
      //   filterGroup: FilterGroupType.multipleTypeSearch,
      // ),
      // CshFilterData(
      //   label: "Product Name",
      //   field: 'productTitle',
      //   crudFilter: 'productName',
      //   filterType: CshFilterType.input,
      //   valueType: CshFilterValueType.contains,
      //   position: FilterPosition.top,
      //   keyboardType: TextInputType.text,
      //   filterGroup: FilterGroupType.multipleTypeSearch,
      // ),
    ]);
  }

  void _refreshList() {
    _listController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    final roleType = UserDetails().getRubbingRoleType();
    final apiUrl = switch (roleType) {
      RubbingModuleRoleType.rubbing => "/rubbing/list",
      RubbingModuleRoleType.glassChange => "/glass-change/device/list",
      RubbingModuleRoleType.cameraCleaning => "/camera-cleaning/device/list",
    };
    var l10n = L10n(context);
    _filterConfig = _getFilterConfig(context);
    var provider = Provider.of<ReceivedDevicesProvider>(context);

    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(Dimens.space_16),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimens.space_4)),
          child: SearchWithScannerWidget(
            l10n.searchBarCode,
            onQuery: (query, isManualSearch) {
              provider.searchQuery = query;
              setState(() {
                _updateCounter++;
              });
              // provider.searchQuery = query;
            },
          ),
        ),
        Expanded(
          child: CshApiList<RubbingDeviceData>(
            key: ObjectKey(_updateCounter),
            apiConfig: ListApiConfig(
              apiUrl: apiUrl,
              serviceGroup: TRCServiceGroups.unifyTrc,
            ),
            filterConfig: _filterConfig,
            controller: _listController,
            itemFromJson: RubbingDeviceData.fromJson,
            shimmerLoaderWidget: const CshShimmer(height: Dimens.space_60),
            listPadding: EdgeInsets.zero,
            verticalRowSpacing: Dimens.space_16,
            isHideCoreFilterButton: true,
            getRowWidget: (item, index) {
              final data = item;
              return _ItemReceivedDevicesWidget(
                rubbingDeviceData: data!,
                onRubbingAction: _refreshList,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ItemReceivedDevicesWidget extends StatelessWidget {
  final VoidCallback onRubbingAction;
  final RubbingDeviceData rubbingDeviceData;

  const _ItemReceivedDevicesWidget({Key? key, required this.onRubbingAction, required this.rubbingDeviceData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReceivedDevicesProvider provider = Provider.of<ReceivedDevicesProvider>(context, listen: false);
    L10n l10n = L10n(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_8, horizontal: Dimens.space_16),
      child: CshCard(
        child: Column(
          children: [
            TitleValueRowWidget(title: l10n.deviceBarcode, value: rubbingDeviceData.deviceBarcode ?? ""),
            TitleValueRowWidget(title: l10n.deviceName, value: rubbingDeviceData.productTitle ?? ""),
            TitleValueRowWidget(title: l10n.deviceId, value: rubbingDeviceData.deviceId.toString()),
            const SizedBox(height: Dimens.space_16),
            ComboButton(
              firstBtnText: l10n.fail,
              padding: EdgeInsets.zero,
              secondBtnText: l10n.done,
              isFirstPrimary: true,
              firstBtnClick: Validator.isNullOrEmpty(rubbingDeviceData.deviceBarcode)
                  ? null
                  : () => markRubbing(provider, l10n, context, false),
              secondBtnClick: rubbingDeviceData.deviceBarcode != null
                  ? () => markRubbing(provider, l10n, context, true)
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  void markRubbing(ReceivedDevicesProvider provider, L10n l10n, BuildContext context, bool isDone,
      {String? partBarcode}) {
    if (provider.roleType != RubbingModuleRoleType.rubbing) {
      if (isDone) {
        _performRubbingApiCall(
          provider: provider,
          l10n: l10n,
          context: context,
          isDone: isDone,
          partBarcode: partBarcode,
          captureImage: provider.roleType != RubbingModuleRoleType.cameraCleaning,
        );
      } else {
        if (Validator.isListNullOrEmpty(provider.glassChangeFailReasonList)) {
          showErrorMessage("No Failed reasons found", context);
          return;
        }
        _showReasonDialog(
          context,
          provider.glassChangeFailReasonList!,
          onSelected: (selectedReason) {
            _performRubbingApiCall(
              provider: provider,
              l10n: l10n,
              context: context,
              isDone: isDone,
              partBarcode: partBarcode,
              captureImage: true,
              selectedReason: selectedReason,
            );
          },
        );
      }
    } else {
      _performRubbingApiCall(
        provider: provider,
        l10n: l10n,
        context: context,
        isDone: isDone,
        partBarcode: partBarcode,
        captureImage: false,
      );
    }
  }

  void _performRubbingApiCall({
    required ReceivedDevicesProvider provider,
    required L10n l10n,
    required BuildContext context,
    required bool isDone,
    String? partBarcode,
    required bool captureImage,
    String? selectedReason,
  }) {
    CshLoading().showLoading(context);
    provider.markRubbing(rubbingDeviceData.deviceBarcode!, isDone, partBarcode, selectedReason).then((res) {
      CshLoading().hideLoading(context);
      if (captureImage) {
        final mediaType = provider.roleType == RubbingModuleRoleType.cameraCleaning
            ? DeviceMediaType.cameraCleaning
            : DeviceMediaType.glassChange;
        _captureImage(context, rubbingDeviceData.deviceBarcode!, mediaType,
            isImageMarkingRequired: !isDone, onComplete: () {
          showSuccessMessage(res?.successMsg ?? "", context);
          onRubbingAction();
        });
      } else {
        showSuccessMessage(res?.successMsg ?? "", context);
        onRubbingAction();
      }
    }).catchError((e) {
      CshLoading().hideLoading(context);
      String errorMessage = ApiErrorHelper.getErrorMessage(e) ?? l10n.somethingWentWrong;
      showErrorMessage(errorMessage, context);
    });
  }

  _captureImage(BuildContext context, String deviceBarcode, DeviceMediaType mediaType,
      {bool isImageMarkingRequired = false, VoidCallback? onComplete}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MultipleImageUploadScreen(
          mediaType,
          deviceBarcode,
          isImageMarkingRequired: isImageMarkingRequired,
          callStatusUpdateApi: () {
            return Future.value();
          },
          onMediaUploaded: () {
            Navigator.pop(context); // dismiss MultipleImageUploadScreen screen
            CshSnackBar.success(context: context, message: "Images captured successfully");
            onComplete?.call();
          },
        ),
      ),
    );
  }

  _showReasonDialog(BuildContext context, List<GlassChangeFailReasonItem> glassChangeFailReasonList,
      {required Function(String selectedReason) onSelected}) {
    String? selectedReason;
    showCshBottomSheet(
      context: context,
      isDismissible: true,
      child: StatefulBuilder(builder: (_, setState) {
        return Container(
          padding: EdgeInsets.all(Dimens.space_16),
          height: MediaQuery.sizeOf(context).height * 0.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CshTextNew.h2("Select Failed Reason"),
              const SizedBox(height: Dimens.space_4),
              Divider(),
              const SizedBox(height: Dimens.space_16),
              Expanded(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    var item = glassChangeFailReasonList[index];
                    return InkWell(
                      onTap: () {
                        setState(() {
                          selectedReason = item.key;
                        });
                      },
                      child: Row(
                        children: [
                          CshRadio(
                            groupValue: selectedReason,
                            value: item.key,
                            onChanged: (value) {
                              setState(() {
                                selectedReason = item.key;
                              });
                            },
                          ),
                          CshTextNew.subTitle1(item.value ?? ""),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: Dimens.space_12);
                  },
                  itemCount: glassChangeFailReasonList.length,
                ),
              ),
              CshMediumButton(
                text: "Submit",
                onPressed: Validator.isNullOrEmpty(selectedReason)
                    ? null
                    : () {
                        Navigator.pop(context);
                        onSelected.call(selectedReason!);
                      },
              )
            ],
          ),
        );
      }),
    );
  }

  void showErrorMessage(String errorMessage, BuildContext context) =>
      CshSnackBar.error(context: context, message: errorMessage);

  void showSuccessMessage(String successMessage, BuildContext context) =>
      CshSnackBar.success(context: context, message: successMessage);
}
