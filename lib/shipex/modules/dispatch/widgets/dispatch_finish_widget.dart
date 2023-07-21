import 'dart:io';

import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/dispatch/providers/shipex_dispatch_provider.dart';
import 'package:image_picker/image_picker.dart';

import '../../l10n.dart';
import 'awb_data_card_widget.dart';
import 'invoice_image_widget.dart';

class DispatchFinishedWidget extends StatefulWidget {
  const DispatchFinishedWidget({super.key});

  @override
  State<DispatchFinishedWidget> createState() => _DispatchFinishedWidgetState();
}

class _DispatchFinishedWidgetState extends State<DispatchFinishedWidget> {
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    var theme = Theme.of(context);
    var provider = ShipexDispatchProvider.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CshMediumButton(
                text: l10n.sendPdf,
                onPressed: () {
                  _sendProofOfDispatch(false);
                },
              ),
              const SizedBox(width: Dimens.space_8),
              CshMediumButton(
                text: l10n.sendCsv,
                onPressed: () {
                  _sendProofOfDispatch(true);
                },
              ),
            ],
          ),
          if (!Validator.isListNullOrEmpty(provider.scannedAwbNumber)) ...[
            const SizedBox(height: Dimens.space_20),
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.30,
              decoration: BoxDecoration(
                  border: Border.all(color: theme.shadowColor), borderRadius: BorderRadius.circular(Dimens.space_8)),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: Dimens.space_8, horizontal: Dimens.space_12),
                itemBuilder: (context, index) {
                  return AWBDataCardWidget(
                    awbNumber: provider.scannedAwbNumber[index],
                    onCrossedPressed: () {
                      provider.removeScannedAwbNumber(provider.scannedAwbNumber[index]);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: Dimens.space_8);
                },
                itemCount: provider.scannedAwbNumber.length,
              ),
            )
          ],
          const SizedBox(height: Dimens.space_16),
          Align(
            alignment: Alignment.center,
            child: CshMediumButton(
              text: l10n.takePictures,
              onPressed: () async {
                XFile? xfile = await _picker.pickImage(source: ImageSource.camera);
                if (xfile != null) {
                  provider.addInvoiceImageFile(File(xfile.path));
                }
              },
            ),
          ),
          if (!Validator.isListNullOrEmpty(provider.listOfInvoicePicture)) ...[
            const SizedBox(height: Dimens.space_16),
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              height: MediaQuery.of(context).size.height * 0.20,
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_20),
              decoration: BoxDecoration(
                  border: Border.all(color: theme.shadowColor), borderRadius: BorderRadius.circular(Dimens.space_8)),
              child: SizedBox(
                height: 120.0,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return InvoiceImageWidget(
                      imageFile: provider.listOfInvoicePicture[index],
                      onCrossedCallback: (File file) {
                        provider.removeInvoiceFile(file);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: Dimens.space_16);
                  },
                  itemCount: provider.listOfInvoicePicture.length,
                ),
              ),
            ),
          ],
          const Expanded(child: SizedBox.shrink()),
          SizedBox(
            width: double.infinity,
            child: CshMediumButton(
              text: l10n.finishDispatch,
              onPressed: () {},
            ),
          )
        ],
      ),
    );
  }

  _sendProofOfDispatch(bool isCsvUpload) {
    var provider = ShipexDispatchProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.sendPodInPdfOrInCsv(isCsvUpload: isCsvUpload).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        if (Validator.isTrue(isCsvUpload)) {
          CshSnackBar.success(context: context, message: "Sent in CSV successfully!!");
        } else {
          CshSnackBar.success(context: context, message: "Sent in PDF successfully!!");
        }
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }
}
