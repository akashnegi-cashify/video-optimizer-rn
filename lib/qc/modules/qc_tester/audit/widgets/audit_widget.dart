import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../l10n.dart';
import '../providers/audit_questions_provider.dart';
import '../screens/audit_barcode_scanner_screen.dart';
import 'audit_pager_widget.dart';

class AuditWidget extends StatelessWidget {
  final String scanData;

  const AuditWidget({
    Key? key,
    required this.scanData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = AuditQuestionsProvider.of(context);
    var l10n = L10n(context);
    var theme = Theme.of(context);

    return (provider.auditData != null && !Validator.isListNullOrEmpty(provider.auditData!.questionList))
        ? AuditQuestionBuilder(barcode: scanData)
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    provider.errMessage ?? l10n.noQuestionsFound,
                    style: theme.primaryTextTheme.displaySmall,
                  ),
                  const SizedBox(height: Dimens.space_20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CshMediumButton(
                      text: l10n.scanAnotherBarcode,
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(AuditBarcodeScannerScreen.route);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
