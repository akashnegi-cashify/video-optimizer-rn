import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/login/providers/login_provider.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/modules/login/widgets/console_login_widget.dart';
import 'package:flutter_trc/src/modules/login/widgets/trc_login_widget.dart';
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
              _buildLoginHeading(context, loginType!),
              loginType == LoginTypes.trcLogin ? const TrcLoginWidget() : ConsoleLoginWidget(loginType!),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoginHeading(BuildContext context, LoginTypes loginType) {
    if (loginType == LoginTypes.rmsLogin || loginType == LoginTypes.shipexLogin || loginType == LoginTypes.qcLogin) {
      return const SizedBox.shrink();
    }

    var l10n = L10n(context);
    var theme = Theme.of(context);
    String? heading;
    String description;
    heading = l10n.trcLogin;
    description = l10n.pleaseEnterYourEmployeeId;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(heading, style: theme.primaryTextTheme.displayLarge),
          const SizedBox(height: Dimens.space_2),
          Text(description, style: theme.primaryTextTheme.bodyMedium),
          const SizedBox(height: Dimens.space_16),
        ],
      ),
    );
  }
}
