import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/login/providers/login_provider.dart';
import 'package:flutter_trc/src/modules/login/widgets/login_widget.dart';
import 'package:provider/provider.dart';
import '../l10n.dart';
import '../widgets/qc_login_widget.dart';

class LoginScreen extends StatefulWidget {
  static const route = '/login';

  const LoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isQCLoginMode = false;

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    return ChangeNotifierProvider<TRCLoginProvider>(
      create: (_) => TRCLoginProvider(),
      lazy: false,
      builder: (BuildContext innerContext, __) {
        return Scaffold(
          appBar: CshHeader(l10n.login, showBackBtn: false),
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
                        Text(_isQCLoginMode ? l10n.qcLogin : l10n.trcLogin, style: theme.primaryTextTheme.headline1),
                        const SizedBox(height: Dimens.space_2),
                        Text(_isQCLoginMode ? l10n.pleaseEnterYourMobileNumber : l10n.pleaseEnterYourEmployeeId,
                            style: theme.primaryTextTheme.bodyText2),
                        const SizedBox(height: Dimens.space_16),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l10n.qcLogin, style: theme.primaryTextTheme.headline4),
                        CshSwitch(
                          isSelected: _isQCLoginMode,
                          onChanged: (data) {
                            _isQCLoginMode = Validator.isTrue(data);
                            setState(() {});
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
              _isQCLoginMode ? const QcLoginWidget() : const LoginWidget(),
            ],
          ),
        );
      },
    );
  }
}
