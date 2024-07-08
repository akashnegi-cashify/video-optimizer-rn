import 'package:components/auth/providers/login_provider.dart';
import 'package:components/auth/types.dart';
import 'package:components/auth/widget/login/login_widget.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RmsLoginWidget extends StatefulWidget {
  const RmsLoginWidget({super.key});

  @override
  State<RmsLoginWidget> createState() => _RmsLoginWidgetState();
}

class _RmsLoginWidgetState extends State<RmsLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginProvider(false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
        child: LoginWidget(
          serviceName: ServiceGroups.console.value,
          serviceVersion: "v1",
          enterMobileNumberTitle : "RMS Login",
          mfaBypassClientId: "sales-rms:epoch",
          versionNumber: "",
          loginType: LoginType.mobile,
          onSubmit: (userAuth, mobileNumber, mode, pin, {companyKey}) {

          },
        ),
      ),
    );
  }
}
