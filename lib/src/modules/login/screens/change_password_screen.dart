import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/user/widget/logout_action_widget.dart';
import '../l10n.dart';

class ChangePasswordScreen extends StatefulWidget {
  static const String route = "/change_password_screen";

  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Scaffold(
      appBar: CshHeader(
        l10n.changePassword,
        showBackBtn: true,
        actions: [LogoutActionWidget()],
      ),
    );
  }
}
