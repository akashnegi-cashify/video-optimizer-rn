import 'package:components/auth/widget/pin_code_text_field/csh_pin_code_text_field.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/app_builder/app_headers/qc_general_header/widgets/qc_general_header.dart';
import 'package:flutter_trc/src/common/mpin/dialogs/show_fingerprint_dialog.dart';
import 'package:flutter_trc/src/common/mpin/dialogs/show_fingerprint_not_enabled_dialog.dart';
import 'package:flutter_trc/src/common/mpin/dialogs/show_status_dialog.dart';
import 'package:flutter_trc/src/common/mpin/mpin_validation_state.dart';
import 'package:flutter_trc/src/common/mpin/providers/mpin_setup_provider.dart';
import 'package:flutter_trc/src/common/mpin/screens/mpin_registration_successful_screen.dart';
import 'package:flutter_trc/src/libraries/fingerprint_auth/finger_print_authentication.dart';
import 'package:flutter_trc/src/libraries/shared_preferences/app_preferences.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';

class MPinSetupScreen extends StatefulWidget {
  static const String route = "/mpin_setup_screen";

  const MPinSetupScreen({super.key});

  @override
  State<MPinSetupScreen> createState() => _MPinSetupScreenState();
}

class _MPinSetupScreenState extends State<MPinSetupScreen> with WidgetsBindingObserver {
  late bool isListenAppLifeCycle = false;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _onResume();
    }
  }

  _onResume() {
    if (isListenAppLifeCycle) {
      isListenAppLifeCycle = false;
      _askBiometricAuthentication(context);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return Scaffold(
      appBar: const QcGeneralHeader(""),
      body: ChangeNotifierProvider(
          create: (context) => MPinSetupProvider(),
          builder: (innerContext, _) {
            var provider = MPinSetupProvider.of(innerContext);
            return Padding(
              padding: const EdgeInsets.all(Dimens.space_16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CshTextNew.subTitle1(l10n.setMPin),
                  const SizedBox(height: Dimens.space_8),
                  CshTextNew.overLine(l10n.mPinDesc, isPrimary: false),
                  const SizedBox(height: Dimens.space_24),
                  CshTextNew.subTitle2(l10n.enterMPin),
                  const SizedBox(height: Dimens.space_6),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CshPinCodeTextField(
                      isUiLibraryUse: true,
                      length: 6,
                      autoDismissKeyboard: true,
                      textInputType: TextInputType.number,
                      isShowCross: true,
                      isEnablePinFillColor: true,
                      textStyle: theme.textTheme.headlineSmall!.copyWith(color: theme.primaryColor),
                      shape: PinCodeFieldShape.circle,
                      obscureText: true,
                      enableAutoFill: false,
                      onChanged: (value) {
                        provider.onMPinChanged(value);
                      },
                    ),
                  ),
                  const SizedBox(height: Dimens.space_16),
                  _MPinValidationWidget(l10n.consecutiveNumberDesc, state: provider.consecutiveState),
                  const SizedBox(height: Dimens.space_8),
                  _MPinValidationWidget(l10n.repetitiveNumberDesc, state: provider.repetitive),
                  const SizedBox(height: Dimens.space_24),
                  CshTextNew.subTitle2(l10n.confirmMPin),
                  const SizedBox(height: Dimens.space_8),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: CshPinCodeTextField(
                      isUiLibraryUse: true,
                      length: 6,
                      autoDismissKeyboard: true,
                      textInputType: TextInputType.number,
                      isEnablePinFillColor: true,
                      textStyle: theme.textTheme.headlineSmall!.copyWith(color: theme.primaryColor),
                      shape: PinCodeFieldShape.circle,
                      obscureText: true,
                      enableAutoFill: false,
                      onChanged: (value) {
                        provider.onConfirmPinChanged(value);
                      },
                    ),
                  ),
                  const Expanded(child: SizedBox.shrink()),
                  SizedBox(
                    width: double.infinity,
                    child: CshBigButton(
                      text: "Submit",
                      onPressed: provider.isEnableSubmitButton() ? () => _onSubmit(context, provider) : null,
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  _onSubmit(BuildContext context, MPinSetupProvider provider) {
    CshLoading().showLoading(context);
    provider.onSubmit().then((_) {
      CshLoading().hideLoading(context);
      showStatusDialog(context, true, onProceed: () {
        Navigator.of(context).pop();
        _askBiometricAuthentication(context);
      });
    }, onError: (error) {
      CshLoading().hideLoading(context);
      showStatusDialog(context, false, errorMessage: error.toString(), onProceed: () {
        Navigator.of(context).pop();
      });
    });
  }

  _askBiometricAuthentication(BuildContext context) async {
    bool isSupported = await FingerPrintAuthentication().canAuthenticate();
    if (!isSupported || kDebugMode) {
      Navigator.pushNamed(context, MPinRegistrationSuccessfulScreen.route);
      return;
    }

    var authentication = await FingerPrintAuthentication().getAvailableAuthenticationType();
    if (authentication == AuthenticationType.none) {
      showFingerprintNotEnabledDialog(
        context,
        onEnableSetting: () {
          Navigator.pop(context); // pop dialog
          isListenAppLifeCycle = true;
        },
      );
    } else {
      showFingerprintDialog(
        context,
        onEnable: () {
          Navigator.pop(context); // pop dialog
          FingerPrintAuthentication().checkForAuthenticate().then((value) {
            if (Validator.isTrue(value)) {
              AppPreferences.qc.setIsBioMetricEnabled(true);
              Navigator.pushNamed(context, MPinRegistrationSuccessfulScreen.route);
            }
          });
        },
      );
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class _MPinValidationWidget extends StatelessWidget {
  final MPinValidationState state;
  final String text;

  const _MPinValidationWidget(this.text, {this.state = MPinValidationState.idle, super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var customColor = theme.extension<CustomColors>() as CustomColors;
    var color = _getColor(theme, customColor, state);
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: CshIcon(
              FeatherIcons.checkCircle,
              padding: const EdgeInsets.only(right: Dimens.space_4),
              iconSize: MobileIconSize.xsmall,
              iconColor: color,
            ),
          ),
          TextSpan(text: text, style: theme.textTheme.bodySmall?.copyWith(color: color)),
        ],
      ),
    );
  }

  _getColor(ThemeData theme, CustomColors customColor, MPinValidationState state) {
    switch (state) {
      case MPinValidationState.idle:
        return theme.textTheme.bodySmall?.color;
      case MPinValidationState.success:
        return customColor.successColor;
      case MPinValidationState.error:
        return theme.colorScheme.error;
    }
  }
}
