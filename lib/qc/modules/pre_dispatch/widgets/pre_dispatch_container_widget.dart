import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../providers/pre_dispatch_provider.dart';
import 'index.dart';

class PreDispatchContainerWidget extends StatelessWidget {
  final String? lotGroupName;
  final int? lotId;

  const PreDispatchContainerWidget({super.key, this.lotGroupName, this.lotId});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);

    if (lotId == null) {
      return Center(child: CshTextNew.h3(l10n.lotGroupNotEmptyOrNull));
    }

    return ChangeNotifierProvider(
      create: (context) => PreDispatchProvider(lotGroupName, lotId!),
      child: const PreDispatchWidget(),
    );
  }
}
