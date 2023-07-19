import 'package:builder_project/builder_project.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/login/providers/login_provider.dart';
import 'package:flutter_trc/src/modules/login/widgets/login_widget.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../models/login_comp_param.dart';
import '../widgets/qc_login_widget.dart';

part 'login_screen.g.dart';

@CshPage(key: LoginScreen.pageKey, pageGroup: PageGroup.loginPageKey, params: LoginCompParamKeys.values)
class LoginScreenArguments extends BaseArguments {
  final bool? isLoginFromQc;

  LoginScreenArguments({this.isLoginFromQc}) : super(LoginScreen.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[LoginCompParamKeys.isLoginFromQC.value] = isLoginFromQc;
    return data;
  }
}

class LoginScreen extends BaseScreen<LoginScreenArguments> {
  static const String pageKey = "TRC_Login_screen";
  static const String route = "/login_screen";

  const LoginScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}

class CombinedLoginWidget extends StatefulWidget {
  final bool? isLoginFromQC;

  const CombinedLoginWidget({
    Key? key,
    this.isLoginFromQC,
  }) : super(key: key);

  @override
  State<CombinedLoginWidget> createState() => _CombinedLoginWidgetState();
}

class _CombinedLoginWidgetState extends State<CombinedLoginWidget> {
  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Validator.isTrue(widget.isLoginFromQC) ? l10n.qcLogin : l10n.trcLogin,
                            style: theme.primaryTextTheme.headline1),
                        const SizedBox(height: Dimens.space_2),
                        Text(
                            Validator.isTrue(widget.isLoginFromQC)
                                ? l10n.pleaseEnterYourMobileNumber
                                : l10n.pleaseEnterYourEmployeeId,
                            style: theme.primaryTextTheme.bodyText2),
                        const SizedBox(height: Dimens.space_16),
                      ],
                    ),
                  ],
                ),
              ),
              Validator.isTrue(widget.isLoginFromQC) ? const QcLoginWidget() : const LoginWidget(),
            ],
          ),
        );
      },
    );
  }
}
