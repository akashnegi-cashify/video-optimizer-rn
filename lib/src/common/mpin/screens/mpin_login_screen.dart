import 'package:calculator_ui/calculator_ui.dart';
import 'package:components/auth/widget/pin_code_text_field/csh_pin_code_text_field.dart';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_actions/qc_action_screen.dart';
import 'package:flutter_trc/src/common/mpin/dialogs/show_fingerprint_not_enabled_dialog.dart';
import 'package:flutter_trc/src/common/mpin/resources/mpin_service.dart';
import 'package:flutter_trc/src/libraries/fingerprint_auth/finger_print_authentication.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:flutter_trc/src/modules/login/screens/trc_and_qc_login_screen.dart';
import 'package:flutter_trc/src/resources/user_details.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../l10n.dart';

class MPinLoginScreen extends StatefulWidget {
  static const String route = "/mpin_login_screen";

  const MPinLoginScreen({super.key});

  @override
  State<MPinLoginScreen> createState() => _MPinLoginScreenState();
}

class _MPinLoginScreenState extends State<MPinLoginScreen> with WidgetsBindingObserver {
  String? _mPin;
  bool _isDeviceSupportFingerprint = true;
  bool _isListenAppLifeCycle = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        _authentication();
      }
    });
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && _isListenAppLifeCycle) {
      _isListenAppLifeCycle = false;
      _authentication();
    }
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    var userDetailsData = UserDetails().userDetailsData;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        elevation: 0,
        leading: const SizedBox.shrink(),
      ),
      body: Stack(
        children: [
          Container(
            alignment: Alignment.topCenter,
            color: theme.primaryColor,
            height: 150,
            width: double.infinity,
            child: Image.asset("assets/images/ic_qc_logo.png"),
          ),
          CshCard(
            margin: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_100, Dimens.space_16, 0),
            padding: const EdgeInsets.all(Dimens.space_24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CshTextNew.h4("Welcome ${userDetailsData?.userName}"),
                const SizedBox(height: Dimens.space_8),
                CshTextNew.h5(l10n.enterSixDigitPin),
                const SizedBox(height: Dimens.space_8),
                CshPinCodeTextField(
                  length: 6,
                  autoDismissKeyboard: true,
                  textInputType: TextInputType.number,
                  isEnablePinFillColor: true,
                  textStyle: theme.textTheme.headlineSmall!.copyWith(color: theme.primaryColor),
                  shape: PinCodeFieldShape.circle,
                  obscureText: true,
                  enableAutoFill: false,
                  onCompleted: (value) {
                    _onMPinSubmit();
                  },
                  onChanged: (value) {
                    _mPin = value;
                  },
                ),
                const SizedBox(height: Dimens.space_12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => _showForgetMPinConfirmationDialog(),
                      child: Text(
                        l10n.changeUser,
                        style: theme.primaryTextTheme.labelSmall?.copyWith(color: theme.primaryColor),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => _showForgetMPinConfirmationDialog(),
                      child: Text(
                        l10n.forgetMPin,
                        style: theme.primaryTextTheme.labelSmall?.copyWith(color: theme.primaryColor),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: Dimens.space_24),
                SizedBox(width: double.infinity, child: CshBigButton(text: l10n.submit, onPressed: _onMPinSubmit)),
                const SizedBox(height: Dimens.space_40),
                Row(
                  children: [
                    Expanded(child: Container(height: 1, color: theme.dividerColor)),
                    const SizedBox(width: Dimens.space_8),
                    Text("OR", style: theme.primaryTextTheme.labelSmall),
                    const SizedBox(width: Dimens.space_8),
                    Expanded(child: Container(height: 1, color: theme.dividerColor)),
                  ],
                ),
                const SizedBox(height: Dimens.space_16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _isDeviceSupportFingerprint ? _authentication : null,
                      child: Padding(
                        padding: const EdgeInsets.all(Dimens.space_8),
                        child: Text(
                          l10n.loginUsingFingerprint,
                          style: theme.primaryTextTheme.headlineMedium?.copyWith(color: theme.primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _onMPinSubmit() {
    CshLoading().showLoading(context);
    MPinService.validateMPin(_mPin).listen((event) {
      CshLoading().hideLoading(context);
      if (Validator.isTrue(event.isSuccess)) {
        _moveToHomeScreen();
      } else {
        CshSnackBar.error(context: context, message: "MPin doesn't match", snackBarPosition: SnackBarPosition.TOP);
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(
          context: context,
          message: ApiErrorHelper.getErrorMessage(error).toString(),
          snackBarPosition: SnackBarPosition.TOP);
    });
  }

  _showForgetMPinConfirmationDialog() {
    showPopup(context,
        title: "Are you sure?",
        barrierDismissible: true,
        desc: "You need to setup again if you proceed.",
        actions: [
          CshMediumButton(
            text: 'Cancel',
            onPressed: () => Navigator.of(context).pop(),
          ),
          CshMediumButton(
            text: 'Proceed',
            onPressed: () {
              AppPreferences.qc.clear();
              AppPreferences.instance.resetAndClearAll();
              Navigator.of(context).pushNamedAndRemoveUntil(TrcAndQcLoginScreen.route, (route) => false);
            },
          ),
        ]);
  }

  _authentication() async {
    bool isSupported = await FingerPrintAuthentication().canAuthenticate();
    if (!isSupported) {
      setState(() {
        _isDeviceSupportFingerprint = false;
      });
      return;
    }

    var authentication = await FingerPrintAuthentication().getAvailableAuthenticationType();

    if (authentication == AuthenticationType.none) {
      showFingerprintNotEnabledDialog(
        context,
        onEnableSetting: () {
          Navigator.pop(context);
          _isListenAppLifeCycle = true;
        },
      );
      return;
    }

    FingerPrintAuthentication().checkForAuthenticate().then((value) {
      if (Validator.isTrue(value)) {
        _moveToHomeScreen();
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  _moveToHomeScreen() {
    Navigator.of(context).pushNamedAndRemoveUntil(QcActionScreen.route, (route) => false);
  }
}
