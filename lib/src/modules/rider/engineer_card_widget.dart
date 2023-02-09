import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/key_value_row_widget.dart';
import 'package:flutter_trc/src/modules/rider/l10n.dart';
import 'package:flutter_trc/src/modules/rider/pending_delivery/deliver/models/delivery_response.dart';

class EngineerCardWidget extends StatelessWidget {
  final EngineerDetail detail;

  const EngineerCardWidget({Key? key, required this.detail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return CshCard(
        child: Column(
      children: [
        KeyValueRowWidget(title: l10n.engineersName, value: detail.name ?? ""),
        KeyValueRowWidget(title: l10n.location, value: detail.location ?? ""),
      ],
    ));
  }
}
