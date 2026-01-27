import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/login/providers/login_provider.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/modules/login/widgets/console_login_widget.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';

class CombinedLoginWidget extends StatelessWidget {
  final LoginTypes? loginType;

  const CombinedLoginWidget({super.key, this.loginType});

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return ChangeNotifierProvider<TRCLoginProvider>(
      create: (_) => TRCLoginProvider(),
      lazy: false,
      builder: (BuildContext innerContext, __) {
        return Scaffold(
          appBar: TrcHeader(l10n.login, showBackBtn: false),
          resizeToAvoidBottomInset: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: Dimens.space_20),
              // _buildLoginHeading(context, loginType!),
              ConsoleLoginWidget(loginType!),
            ],
          ),
        );
      },
    );
  }
}
