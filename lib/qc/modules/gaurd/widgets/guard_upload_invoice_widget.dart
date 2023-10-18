import 'dart:io';

import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/gaurd/providers/upload_invoice_provider.dart';
import 'package:flutter_trc/src/utils/image_util.dart';
import 'package:image_picker/image_picker.dart';

class GuardUploadInvoiceWidget extends StatelessWidget {
  const GuardUploadInvoiceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = UploadInvoiceProvider.of(context);
    return Padding(
      padding: const EdgeInsets.all(Dimens.space_16),
      child: Column(
        children: [
          CshTextNew.subTitle1("${provider.invoiceList?.length ?? 0} Image Captured"),
          const SizedBox(height: Dimens.space_16),
          CshTextNew.subTitle1("Capture invoice one by one and after that upload invoice"),
          if (!Validator.isListNullOrEmpty(provider.invoiceList))
            Expanded(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return CshCard(child: Image.file(provider.invoiceList![index]));
                  },
                  separatorBuilder: (context, index) => const SizedBox(height: Dimens.space_8),
                  itemCount: provider.invoiceList?.length ?? 0),
            ),
          const SizedBox(height: Dimens.space_16),
          Row(
            children: [
              Expanded(
                child: CshBigButton(
                  text: "Upload Invoice",
                  onPressed: !Validator.isListNullOrEmpty(provider.invoiceList)
                      ? () {
                          CshLoading().showLoading(context);
                          provider.submitInvoice().then((_) {
                            CshLoading().hideLoading(context);
                            CshSnackBar.success(context: context, message: "Invoice submitted successfully");
                          }, onError: (error) {
                            CshLoading().hideLoading(context);
                            CshSnackBar.error(context: context, message: error);
                          });
                        }
                      : null,
                ),
              ),
              const SizedBox(width: Dimens.space_16),
              Expanded(
                child: CshBigButton(
                  text: "Capture Invoice",
                  onPressed: () async {
                    final ImagePicker picker = ImagePicker();
                    XFile? xFile = await picker.pickImage(source: ImageSource.camera, requestFullMetadata: false);
                    if (xFile != null) {
                      var compressedFile = await ImageUtil.compressImage(File(xFile.path));
                      provider.addInvoiceImage(compressedFile);
                    }
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
