import 'package:core_widgets/core_widgets.dart' as core;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/providers/dispatch_lot_provider.dart';
import 'package:flutter_trc/qc/modules/dispatch_lot/widgets/index.dart';

import '../../../../src/utils/paginate_list_abstract.dart';
import '../resources/index.dart';
import '../screens/index.dart';
import '../l10n.dart';

class DispatchLotsWidget extends StatefulWidget {
  const DispatchLotsWidget({super.key});

  @override
  State<DispatchLotsWidget> createState() => _DispatchLotsWidgetState();
}

class _DispatchLotsWidgetState extends PaginatedListState<Lot, DispatchLotsWidget> {
  @override
  void initState() {
    super.initState();
    var provider = DispatchLotProvider.of(context: context, listen: false);
    provider.controller.stream.listen((event) {
      resetAndRefreshScreen();

    });
  }

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return iterate((item, index) => LotWidget(
          lot: item,
          index: index,
          onItemClick: () => _onItemClick(context, index: index,l10n:l10n),
        ));
  }

  @override
  void requestApi(int pageNo, {Function(List<Lot>? list)? onSuccess, Function(String errorMessage)? onError}) {
    var provider = DispatchLotProvider.of(context: context, listen: false);
    provider
        .getDataStream(
      pageNo,
      pageSize,
      searchQuery: provider.searchQuery,
      channelQuery: provider.channelQuery,
    )
        .listen(
      (value) {
        if (onSuccess != null) {
          onSuccess(core.ArrayUtil.removeNullItems(value?.lots ?? []));
        }
      },
      onError: (error) {
        if (onError != null) {
          onError(error);
        }
      },
    );
  }

  void _onItemClick(BuildContext context, {required int index,required L10n l10n}) {
    // navigate to scanner screen.
    InvoiceScanScreen.navigate(context).then((value) {
      if (value != null) {
        var provider = DispatchLotProvider.of(context: context, listen: false);
        core.CshLoading().showLoading(context);
        provider.initiateDispatchCompletion(value).then((value) {
          core.CshLoading().hideLoading(context);
          if (value?.isSuccess == true) {
            _showAlert(context, value?.errorMsg,l10n);
          } else {
            if (core.isNotEmpty(value?.errorMsg)) {
              core.CshSnackBar.error(context: context, message: value!.errorMsg!);
            }
          }
        }, onError: (error) {
          core.CshLoading().hideLoading(context);
          core.CshSnackBar.error(context: context, message: error);
        });
      }
    });
  }

  void _showAlert(BuildContext context, String? message,L10n l10n) {
    var theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: core.CshTextNew.h3(''),
          content: core.isNotEmpty(message) ? core.CshTextNew.h3(message!) : null,
          actions: <Widget>[
            TextButton(
              child: core.CshTextNew(
                l10n.ok,
                textStyle: theme.textTheme.displaySmall?.copyWith(color: theme.primaryColor),
              ),
              onPressed: () {
                Navigator.pop(context);
                resetAndRefreshScreen();
              },
            )
          ],
        );
      },
    );
  }
}
