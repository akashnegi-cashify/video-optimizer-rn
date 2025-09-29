import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/modules/login/resources/collector_user_controller.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';
import 'package:flutter_trc/src/resources/user_details.dart';

import '../l10n.dart';
import '../providers/login_provider.dart';

class TrcLoginWidget extends StatefulWidget {
  const TrcLoginWidget({Key? key}) : super(key: key);

  @override
  State<TrcLoginWidget> createState() => _TrcLoginWidgetState();
}

class _TrcLoginWidgetState extends State<TrcLoginWidget> {
  final TextEditingController _empIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool _isEmployeeIdValidated = false;
  bool _showPassword = false;
  bool _showPassActivated = false;

  @override
  void initState() {
    if (isDebug()) {
      _passwordController.text = "Cashify@123";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_20, horizontal: Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CshTextFormField(
            controller: _empIdController,
            keyboardType: TextInputType.name,
            maxLength: 10,
            counterText: "",
            hintText: l10n.employeeId,
          ),
          if (_isEmployeeIdValidated) ...[
            const SizedBox(height: Dimens.space_16),
            Stack(
              alignment: Alignment.centerRight,
              children: [
                CshTextFormField(
                  controller: _passwordController,
                  obscureText: !_showPassword,
                  maxLength: 100,
                  counterText: "",
                  hintText: l10n.password,
                  onFocusChange: (value) {
                    _showPassActivated = value;
                    setState(() {});
                  },
                ),
                Positioned(
                  top: Dimens.space_2,
                  child: GestureDetector(
                    onTap: () {
                      _showPassword = !_showPassword;
                      setState(() {});
                    },
                    child: CshIcon(
                      _showPassword ? FeatherIcons.eyeOff : FeatherIcons.eye,
                      iconColor: _showPassActivated ? theme.primaryColor : theme.shadowColor,
                      iconSize: MobileIconSize.medium,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: Dimens.space_16),
            CshTextFormField(
              controller: _locationController,
              maxLength: 100,
              counterText: "",
              suffixIcon: CshIcon(FeatherIcons.mapPin, iconSize: MobileIconSize.medium),
              hintText: l10n.location,
            ),
            const SizedBox(height: Dimens.space_16),
          ],
          Container(
            margin: const EdgeInsets.symmetric(horizontal: Dimens.space_12),
            width: double.infinity,
            child: CshMediumButton(
              text: _isEmployeeIdValidated ? l10n.continueStr : l10n.verify,
              onPressed: _isEmployeeIdValidated
                  ? () {
                      FocusManager.instance.primaryFocus?.unfocus();
                      if (_detailsVerification(l10n)) {
                        String empId = _empIdController.text.trim();
                        String pw = _passwordController.text.trim();
                        String location = _locationController.text.trim();
                        _submitLoginCredentials(
                            empId, pw, l10n.loggedInSuccessfully, l10n.somethingWentWrong, location);
                      }
                    }
                  : () {
                      if (!Validator.isNullOrEmpty(_empIdController.text)) {
                        _isEmployeeIdValidated = true;
                        setState(() {});
                      } else {
                        FocusManager.instance.primaryFocus?.unfocus();
                        CshSnackBar.error(
                            context: context,
                            message: l10n.pleaseEnterYourEmployeeId,
                            snackBarPosition: SnackBarPosition.TOP);
                      }
                    },
            ),
          ),
        ],
      ),
    );
  }

  bool _detailsVerification(L10n l10n) {
    if (Validator.isNullOrEmpty(_passwordController.text)) {
      CshSnackBar.error(context: context, message: l10n.pleaseEnterPassword, snackBarPosition: SnackBarPosition.TOP);
      return false;
    }
    return true;
  }

  _submitLoginCredentials(
    String employeeId,
    String password,
    String successMessage,
    String errorMessage,
    String location,
  ) {
    var provider = TRCLoginProvider.of(context, listen: false);

    CshLoading().showLoading(context);
    provider.userLogin(employeeId, password, location).then((_) {
      if (mounted) {
        CshLoading().hideLoading(context);
        CshSnackBar.success(context: context, message: successMessage, snackBarPosition: SnackBarPosition.TOP);
        UserRoles.navigateToUserRoleScreen(context, UserDetails().userDetailsData?.listOfRoles ?? [],
            loginType: LoginTypes.trcLogin);
      }
    }, onError: (error) {
      if (mounted) {
        CshLoading().hideLoading(context);
        CshSnackBar.error(context: context, message: error, snackBarPosition: SnackBarPosition.TOP);
      }
    });
  }
}
