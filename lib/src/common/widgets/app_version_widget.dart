import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/rubbing/l10n.dart';

import '../../utils/app_util.dart';

class AppVersionWidget extends StatelessWidget {
  const AppVersionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return FutureBuilder<String?>(
      builder: (context, snapshot) {
        var appVersion = snapshot.data;
        return appVersion != null ? CshTextNew.bodyText2("${l10n.appVersion} : $appVersion") : const SizedBox.shrink();
      },
      future: AppUtil.getAppVersionName(),
    );
  }
}
