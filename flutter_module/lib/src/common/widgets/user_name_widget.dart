import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/rubbing/l10n.dart';

import '../../resources/user_details.dart';

class UserNameWidget extends StatelessWidget {
  const UserNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    L10n l10n = L10n(context);
    return CshTextNew.bodyText2("${l10n.loggedInUser} : ${UserDetails().consoleUserDetail?.firstname}");
  }
}
