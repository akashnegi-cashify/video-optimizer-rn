import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../providers/pre_dispatch_provider.dart';
import 'index.dart';

class PreDispatchContainerWidget extends StatelessWidget {
  final String? lotGroupName;

  const PreDispatchContainerWidget({super.key, this.lotGroupName,});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);

    if (isEmpty(lotGroupName)) {
      return Center(child: CshTextNew.h3(l10n.lotGroupNotEmptyOrNull));
    }

    return ChangeNotifierProvider(
      create: (context) => PreDispatchProvider(lotGroupName!),
      child: const PreDispatchWidget(),
    );
  }
}
