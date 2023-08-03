import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';
import '../providers/document_download_provider.dart';
import '../resources/doc_type_enum.dart';

class DocDownloaderWidget extends StatelessWidget {
  final String? courierAwb;
  final String? shipmentId;

  const DocDownloaderWidget({
    super.key,
    this.courierAwb,
    this.shipmentId,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return ChangeNotifierProvider<DocumentDownloadProvider>(
      create: (_) => DocumentDownloadProvider(),
      lazy: false,
      builder: (BuildContext insideContext, __) {
        var provider = DocumentDownloadProvider.of(insideContext);
        return Row(
          children: [
            Flexible(
              flex: 1,
              child: Text(
                "${l10n.docLinks}:- ",
                style: theme.primaryTextTheme.headlineMedium,
              ),
            ),
            const SizedBox(width: Dimens.space_8),
            Flexible(
              flex: 2,
              child: CshDropDown(
                selectedItem: DropDownItem(DocTypeEnum.awbInvoice.value, DocTypeEnum.awbInvoice.value),
                items: List.generate(
                  DocTypeEnum.values.length,
                  (index) => DropDownItem(DocTypeEnum.values[index].value, DocTypeEnum.values[index].value),
                ),
                onChanged: (DropDownItem data) {},
              ),
            ),
            const SizedBox(width: Dimens.space_8),
            CshMediumButton(
              text: l10n.download,
              onPressed: () {
                _getDownloadUrl(insideContext);
              },
            )
          ],
        );
      },
    );
  }

  _getDownloadUrl(BuildContext context) {
    CshLoading().showLoading(context);
    var provider = DocumentDownloadProvider.of(context, listen: false);
    provider.getDocumentDownloadLink(courierAwb: courierAwb, shipmentId: shipmentId).then((value) {
      CshLoading().hideLoading(context);
      //TODO apply download and open file code here;
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
