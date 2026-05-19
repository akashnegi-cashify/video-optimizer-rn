import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/audit/screens/audit_question_screen.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';

import '../l10n.dart';
import '../providers/audit_questions_provider.dart';
import 'audit_pager_widget.dart';

class AuditWidget extends StatelessWidget {
  final String scanData;

  const AuditWidget({super.key, required this.scanData});

  @override
  Widget build(BuildContext context) {
    var provider = AuditQuestionsProvider.of(context);
    var l10n = L10n(context);
    var theme = Theme.of(context);

    return (provider.auditData != null && !Validator.isListNullOrEmpty(provider.auditData!.auditQuestionList))
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
                        CshMlScannerUtil().openScanner(
                          context,
                          onScanned: (scannedData, controller) {
                            Navigator.pop(context); // Close the scanner screen
                            AuditQuestionsScreenArguments args =
                                AuditQuestionsScreenArguments(scannedBarcode: scannedData.trim());
                            Navigator.of(context).pushReplacementNamed(AuditQuestionsScreen.route, arguments: args);
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
