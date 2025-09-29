import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';
import 'package:flutter_trc/src/common/widgets/title_value_row_widget.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/models/engineer_device_info.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/part_detail/view_part_detail_widget.dart';

import '../../../../resources/engineer_api_service.dart';
import '../../models/engineer_part_info.dart';
import '../../models/parts_list_response.dart';

class AssignedPartListWidget extends StatefulWidget {
  final EngineerDeviceInfo deviceInfo;

  const AssignedPartListWidget({super.key, required this.deviceInfo});

  @override
  State<AssignedPartListWidget> createState() => AssignedPartListWidgetState();
}

class AssignedPartListWidgetState extends State<AssignedPartListWidget> {
  late Stream<PartsListResponse?> stream;

  @override
  void initState() {
    stream = EngineerAPIService.getAssignedParts(widget.deviceInfo.deviceId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PartsListResponse?>(
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerListWidget(height: 400);
        }
        if (asyncSnapshot.hasData && asyncSnapshot.data != null) {
          var list = asyncSnapshot.data!.partDataList;
          if (list != null) {
            return ListView.separated(
                primary: false,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  return ItemPartWidget(
                    part: list[index],
                    deviceInfo: widget.deviceInfo,
                    onBottomSheetClosed: refreshData,
                  );
                },
                separatorBuilder: (_, __) => const SizedBox(height: Dimens.space_16),
                itemCount: list.length);
          }
        }
        return const SizedBox.shrink();
      },
      stream: stream,
    );
  }

  void refreshData() {
    if (mounted) {
      setState(() {
        stream = EngineerAPIService.getAssignedParts(widget.deviceInfo.deviceId);
      });
    }
  }
}

class ItemPartWidget extends StatelessWidget {
  final EngineerPartInfo part;
  final EngineerDeviceInfo deviceInfo;
  final VoidCallback? onBottomSheetClosed;

  const ItemPartWidget({super.key, required this.part, required this.deviceInfo, this.onBottomSheetClosed});

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return GestureDetector(
      onTap: () {
        viewPartDetailBottomSheet(context, ViewPartDetailData(deviceInfo, part)).whenComplete(() {
          if (onBottomSheetClosed != null) onBottomSheetClosed!();
        });
      },
      child: CshCard(
        child: Column(
          children: [
            TitleValueRowWidget(title: l10n.partName, value: part.partName ?? ""),
            TitleValueRowWidget(title: l10n.partBarcode, value: part.partBarcode ?? ""),
            TitleValueRowWidget(title: l10n.partSku, value: part.sku ?? ""),
            if (!Validator.isNullOrEmpty(part.partVariantName))
              TitleValueRowWidget(title: l10n.skuName, value: part.partVariantName ?? ""),
            if (!Validator.isNullOrEmpty(part.action))
              TitleValueRowWidget(title: l10n.action, value: part.action ?? ""),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CshTextNew.bodyText2(l10n.status),
                CshTextNew(
                  "${part.status}",
                  textStyle: getStatusStyle(part.statusCode),
                )
              ],
            )
          ],
        ),
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
