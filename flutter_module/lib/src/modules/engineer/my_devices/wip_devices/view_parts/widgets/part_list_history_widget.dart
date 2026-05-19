import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/title_value_row_widget.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/part_list_history_response.dart';

import '../../../../l10n.dart';

class ProductListWidget extends StatelessWidget {
  late final ValueNotifier<List<PartListHistoryData>> _queryList;
  final List<PartListHistoryData> partList;

  ProductListWidget(this.partList, {super.key}) {
    _queryList = ValueNotifier<List<PartListHistoryData>>(partList);
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, 0),
          child: SearchBarWidget(
            hintText: l10n.searchByPartName,
            onQuery: (query) {
              _queryList.value = Validator.isNullOrEmpty(query)
                  ? partList
                  : partList.where((element) => element.partName!.toLowerCase().contains(query.toLowerCase())).toList();
            },
          ),
        ),
        const SizedBox(height: Dimens.space_16),
        ValueListenableBuilder<List<PartListHistoryData>>(
            valueListenable: _queryList,
            builder: (BuildContext context, List<PartListHistoryData> value, Widget? child) {
              return Expanded(
                child: ListView.separated(
                    padding: const EdgeInsets.all(Dimens.space_16),
                    itemBuilder: (context, index) {
                      var item = value[index];
                      return _PartHistoryItem(
                        partName: item.partName ?? "",
                        alternatePart: item.alternatePartName,
                        sku: item.sku,
                        status: item.status,
                        updatedAt: item.updatedAt,
                        updatedBy: item.updatedBy,
                        statusCode: item.statusCode,
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: Dimens.space_12),
                    itemCount: value.length),
              );
            })
      ],
    );
  }
}

class _PartHistoryItem extends StatelessWidget {
  final String? partName;
  final String? sku;
  final int? updatedAt;
  final String? updatedBy;
  final String? status;
  final String? alternatePart;
  final int? statusCode;

  const _PartHistoryItem({
    Key? key,
    this.partName,
    this.sku,
    this.status,
    this.alternatePart,
    this.updatedAt,
    this.updatedBy,
    this.statusCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    var theme = Theme.of(context);
    return CshCard(
      child: Column(
        children: [
          TitleValueRowWidget(title: l10n.partName, value: partName ?? ""),
          TitleValueRowWidget(title: l10n.partSku, value: sku ?? ""),
          if (!Validator.isNullOrEmpty(alternatePart))
            TitleValueRowWidget(title: l10n.alternatePart, value: alternatePart ?? ""),
          if (!Validator.isNullOrEmpty(updatedBy)) TitleValueRowWidget(title: l10n.updatedBy, value: updatedBy ?? ""),
          if (updatedAt != null)
            TitleValueRowWidget(
                title: l10n.updatedAt,
                value: formatDate(timeStamp: updatedAt, pattern: DateFormats.dd_MMM_yyyy_HH_mm_ss.value)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CshTextNew.bodyText2(l10n.status),
              CshTextNew(
                "${status}",
                textStyle: getStatusStyle(statusCode),
              )
            ],
          )
        ],
      ),
    );
  }

  TextStyle getStatusStyle(int? statusCode) {
    if (statusCode == 12) {
      return const TextStyle(color: Colors.teal);
    } else if (statusCode == 13) {
      return const TextStyle(color: Colors.red);
    } else {
      return const TextStyle(color: Colors.black);
    }
  }
}
