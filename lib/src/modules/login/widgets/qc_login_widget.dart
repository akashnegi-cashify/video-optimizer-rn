import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_trc/src/modules/login/resources/login_types.dart';

import '../l10n.dart';
import '../providers/login_provider.dart';
import '../resources/notification_type.dart';

class QcLoginWidget extends StatefulWidget {
  final LoginTypes loginType;

  const QcLoginWidget({
    Key? key,
    required this.loginType,
  }) : super(key: key);

  @override
  State<QcLoginWidget> createState() => _QcLoginWidgetState();
}

class _QcLoginWidgetState extends State<QcLoginWidget> {
  final TextEditingController _mobileNumberController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var provider = TRCLoginProvider.of(context);
    var theme = Theme.of(context);
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CshTextFormField(
            controller: _mobileNumberController,
            keyboardType: TextInputType.phone,
            maxLines: 1,
            enabled: (provider.otpResponse != null) ? false : true,
            maxLength: 20,
            autofocus: false,
            hintText: l10n.mobileNumber,
            inputFormatters: [
              LengthLimitingTextInputFormatter(20),
              FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
            ],
          ),
          if (provider.otpResponse != null) ...[
            CshTextFormField(
              controller: _otpController,
              keyboardType: TextInputType.phone,
              maxLines: 1,
              maxLength: 10,
              autofocus: false,
              hintText: l10n.enterOtp,
              inputFormatters: [
                LengthLimitingTextInputFormatter(20),
                FilteringTextInputFormatter.allow(RegExp('[0-9]+')),
              ],
            ),
            ComboButton(
              firstBtnText: l10n.changeNo,
              secondBtnText: l10n.verifyOtp,
              buttonType: ButtonType.mini,
              isFirstPrimary: true,
              firstBtnClick: () {
                provider.resetSentOTPResponse();
                _otpController.clear();
                _mobileNumberController.clear();
                setState(() {});
              },
              secondBtnClick: () {
                if (!Validator.isNullOrEmpty(_otpController.text) &&
                    !Validator.isNullOrEmpty(provider.otpResponse?.requestId)) {
                  String otp = _otpController.text.trim();
                  _verifyEnteredOTP(_mobileNumberController.text.trim(), NotificationType.notificationTypeSMS.value,
                      otp, provider.otpResponse!.requestId!, widget.loginType == LoginTypes.shipexLogin ? false : true);
                } else {
                  CshSnackBar.error(context: context, message: l10n.pleaseEnterOtpSentToNumber);
                }
              },
            ),
            const SizedBox(height: Dimens.space_10),
            provider.isActiveResendOtp
                ? GestureDetector(
                    onTap: () {
                      String data = _mobileNumberController.text.trim();
                      _sendOtpToUser(data, NotificationType.notificationTypeSMS.value, l10n.otpSentSuccessfully,
                          isResendFlow: true);
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        l10n.resendOtp,
                        style: theme.primaryTextTheme.bodyLarge?.copyWith(color: theme.primaryColor),
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${l10n.resendOtp} | ',
                        style: theme.primaryTextTheme.bodyLarge,
                      ),
                      Text(
                        '${provider.start}',
                        style: theme.primaryTextTheme.bodyLarge,
                      ),
                    ],
                  ),
          ],
          if (provider.otpResponse == null)
            Container(
              margin: const EdgeInsets.symmetric(horizontal: Dimens.space_12),
              width: double.infinity,
              child: CshMediumButton(
                text: l10n.verify,
                onPressed: () {
                  if (!Validator.isNullOrEmpty(_mobileNumberController.text)) {
                    String mn = _mobileNumberController.text.trim();
                    _sendOtpToUser(mn, NotificationType.notificationTypeSMS.value, l10n.otpSentSuccessfully);
                    FocusScope.of(context).unfocus();
                  } else {
                    CshSnackBar.error(context: context, message: l10n.pleaseEnterMobileNumber);
                  }
                },
              ),
            ),
        ],
      ),
    );
  }

  _sendOtpToUser(String mobileNumber, String notificationType, String successMessage, {bool isResendFlow = false}) {
    var provider = TRCLoginProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.qcSendOTP(mobileNumber, notificationType, loginForShipex: widget.loginType == LoginTypes.shipexLogin).then(
        (value) {
      CshLoading().hideLoading(context);
      if (!Validator.isNullOrEmpty(value)) {
        if (isResendFlow) {
          provider.resetResendOtpButton();
        }
        FocusScope.of(context).unfocus();

        setState(() {});
        CshSnackBar.success(context: context, message: successMessage);
      }
    }, onError: (error) {
      Logger.debug('mydebug------_QcLoginWidgetState._sendOtpToUser', [error]);
      CshSnackBar.error(context: context, message: error);
      CshLoading().hideLoading(context);
    });
  }

  _verifyEnteredOTP(String mobileNumber, String notificationType, String otp, String referenceId, bool loginFromQC) {
    var provider = TRCLoginProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider
        .authenticateSentOTP(context, mobileNumber, notificationType, otp, referenceId, loginFromQC,
            loginForShipex: widget.loginType == LoginTypes.shipexLogin)
        .then((value) {
      if (!value) {
        CshSnackBar.error(context: context, message: "Unable to authenticate!!");
      }
      CshLoading().hideLoading(context);
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
