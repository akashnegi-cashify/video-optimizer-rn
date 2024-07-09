import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/store_out/providers/store_out_provider.dart';
import 'package:flutter_trc/qc/modules/store_out/widgets/index.dart';
import '../l10n.dart';

class StoreOutBinListWidget extends StatefulWidget {
  final Function(String? lotName)? onItemClick;

  const StoreOutBinListWidget({super.key, this.onItemClick});

  @override
  State<StoreOutBinListWidget> createState() => _StoreOutBinListWidgetState();
}

class _StoreOutBinListWidgetState extends State<StoreOutBinListWidget> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    var provider = StoreOutProvider.of(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider.fetchStoreOutBinList();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    var provider = StoreOutProvider.of(context);
    var isLoading = provider.binListDataState.status == RequestStatus.initial;
    var itemCount = isLoading ? 20 : provider.binListDataState.data?.binList?.length ?? 0;
    var l10n = L10n(context);

    return RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 1),(){
          provider.fetchStoreOutBinList();
        });
      },
      child: ListView.separated(
        padding: const EdgeInsets.all(Dimens.space_16),
        itemBuilder: (context, index) {
          var item = isLoading ? null : provider.binListDataState.data?.binList?[index];
          return CshShimmer(
            show: isLoading,
            child: isLoading
                ? Container(height: Dimens.space_40)
                : cshGestureDetector(
                    child: ListItemWidget(
                      l10n.lotName,
                      lotValue: item?.lotName,
                      noOfDevices: item?.totalCount?.toString(),
                    ),
                    onTap: () => isLoading ? null : widget.onItemClick?.call(item?.lotName)),
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: Dimens.space_8);
        },
        itemCount: itemCount,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
