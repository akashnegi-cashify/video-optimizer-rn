import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/modules/home/home_screen.dart';
import '../l10n.dart';
import '../providers/login_provider.dart';

class LoginWidget extends StatefulWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final TextEditingController _empIdController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  bool _isEmployeeIdValidated = false;
  bool _showPassword = false;
  bool _showPassActivated = false;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_20, horizontal: Dimens.space_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.login, style: theme.primaryTextTheme.headline1),
          const SizedBox(height: Dimens.space_2),
          Text(l10n.pleaseEnterYourEmployeeId, style: theme.primaryTextTheme.bodyText2),
          const SizedBox(height: Dimens.space_16),
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
                      if (_detailsVerification()) {
                        String empId = _empIdController.text.trim();
                        String pw = _passwordController.text.trim();
                        _submitLoginCredentials(empId, pw);
                      }
                    }
                  : () {
                      if (!Validator.isNullOrEmpty(_empIdController.text)) {
                        _isEmployeeIdValidated = true;
                        setState(() {});
                      } else {
                        CshSnackBar.error(context: context, message: "Please enter employee Id");
                      }
                    },
            ),
          ),
        ],
      ),
    );
  }

  bool _detailsVerification() {
    if (Validator.isNullOrEmpty(_passwordController.text)) {
      CshSnackBar.error(context: context, message: "Please enter password");
      return false;
    }
    return true;
  }

  _submitLoginCredentials(String employeeId, String password) {
    var provider = TRCLoginProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.userLogin(employeeId, password).then((value) {
      if (value) {
        CshSnackBar.success(context: context, message: "Logged in successfully");
        CshLoading().hideLoading(context);
        Navigator.of(context).pushReplacementNamed(HomeScreen.route);
      } else {
        CshSnackBar.error(context: context, message: "Something went wrong");
      }
      CshLoading().hideLoading(context);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
