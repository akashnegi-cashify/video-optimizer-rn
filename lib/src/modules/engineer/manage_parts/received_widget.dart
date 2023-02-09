import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';
import 'package:flutter_trc/src/modules/engineer/l10n.dart';
import 'package:flutter_trc/src/modules/engineer/manage_parts/item_manage_parts.dart';

import '../my_devices/wip_devices/models/parts_list_response.dart';
import '../resources/engineer_api_service.dart';

class ReceivedWidget extends StatefulWidget {
  const ReceivedWidget({Key? key}) : super(key: key);

  @override
  State<ReceivedWidget> createState() => _ReceivedWidgetState();
}

class _ReceivedWidgetState extends State<ReceivedWidget> {
  late L10n l10n;
  late Stream<PartsListResponse?> stream;

  @override
  void initState() {
    stream = EngineerAPIService.receivedParts();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    l10n = L10n(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PartsListResponse?>(
      builder: (context, asyncSnapshot) {
        if (asyncSnapshot.connectionState == ConnectionState.waiting) {
          return const ShimmerListWidget();
        }

        if (asyncSnapshot.data?.isSuccess == false) {
          CshSnackBar.error(context: context, message: asyncSnapshot.data?.errorMsg ?? l10n.somethingWentWrong);
        }

        if (asyncSnapshot.hasData && asyncSnapshot.data != null) {
          return CshList(
            rowCount: asyncSnapshot.data!.partDataList?.length ?? 0,
            onRefresh: refreshStream,
            getRowWidget: (index) {
              return ItemManageParts(
                partInfo: asyncSnapshot.data!.partDataList![index],
                showCancel: false,
                onActionDone: refreshStream,
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
      stream: stream,
    );
  }

  void refreshStream() {
    setState(() {
      stream = EngineerAPIService.receivedParts();
    });
  }
}
