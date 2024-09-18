import 'package:core_widgets/core_widgets.dart' hide iterate;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/providers/variant_list_provider.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/service_initialize_interface.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/variant_list_response.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/widgets/variant_list_item_widget.dart';
import 'package:flutter_trc/src/app_builder/app_headers/qc_general_header/widgets/qc_general_header.dart';
import 'package:flutter_trc/src/common/widgets/my_search_bar_widget.dart';
import 'package:flutter_trc/src/utils/paginate_list_abstract.dart';

class VariantListScreen extends StatefulWidget {
  final Function(VariantListData? variantItem) onVariantSelected;

  const VariantListScreen({required this.onVariantSelected, super.key});

  @override
  State<VariantListScreen> createState() => _VariantListScreenState();
}

class _VariantListScreenState extends PaginatedListState<VariantListData, VariantListScreen>
    implements ServiceInitializeInterface {
  @override
  void initState() {
    var provider = VariantListProvider.of(context, listen: false);
    provider.setServiceInitializedListener(this);
  }

  @override
  Widget build(BuildContext context) {
    var provider = VariantListProvider.of(context);
    return Scaffold(
      appBar: const QcGeneralHeader("Please select variant", showBackBtn: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.all(Dimens.space_16),
            child: MySearchBarWidget(
              hintText: "Search by variant name",
              onQuery: (query) {
                provider.searchQuery = query;
                resetAndRefreshScreen();
              },
            ),
          ),
          CshCard(
            margin: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
            cardWidth: double.infinity,
            child: CshTextNew.h3(provider.seriesName),
          ),
          const SizedBox(height: Dimens.space_16),
          Expanded(
            child: iterate(
              (item, index) {
                return VariantListItemWidget(item, onTap: widget.onVariantSelected);
              },
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
              separator: const SizedBox(height: Dimens.space_12),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void requestApi(int pageNo,
      {Function(List<VariantListData>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = VariantListProvider.of(context, listen: false);
    if (!provider.isPageInitializing) {
      provider.getVariantList(pageSize: pageSize, pageNo: pageNo).then((value) {
        onSuccess?.call(value);
      }, onError: (error) {
        onError?.call(error);
      });
    }
  }

  @override
  void initialize() {
    resetAndRefreshScreen();
  }
}
