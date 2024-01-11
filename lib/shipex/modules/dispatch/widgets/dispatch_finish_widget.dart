import 'dart:io';

import 'package:calculator_ui/calculator_ui.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/shipex/modules/pending_dispatch/providers/complete_dispatch_provider.dart';
import 'package:flutter_trc/shipex/modules/shipex_home/screens/shipex_home_screen.dart';
import 'package:flutter_trc/src/common/widgets/my_search_bar_widget.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';
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
    var provider = CompleteDispatchProvider.of(context);

    if (provider.isLoading) {
      return const ShimmerListWidget();
    }

    if (!provider.isLoading && provider.screenErrorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              provider.screenErrorMessage!,
              style: theme.primaryTextTheme.bodyMedium?.copyWith(color: theme.colorScheme.error),
            ),
            const SizedBox(height: Dimens.space_16),
            CshMediumButton(
              text: l10n.retry,
              onPressed: () {
                provider.getAwbList(isRefresh: true);
              },
            )
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
      child: Column(
        children: [
          MySearchBarWidget(
              hintText: l10n.searchAwb,
              onQuery: (query) {
                provider.searchQuery = query;
              }),
          _getParentWidget(
            provider: provider,
            theme: theme,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: Dimens.space_8, horizontal: Dimens.space_12),
              itemBuilder: (_, index) {
                var item = provider.scannedAwbList?[index];
                return AWBDataCardWidget(
                  awbNumber: item?.awb ?? "",
                  onCrossedPressed: () {
                    CshLoading().showLoading(context);
                    provider.removeScannedAwbNumber(item!.awb!).then((_) {
                      CshLoading().hideLoading(context);
                    }, onError: (error) {
                      CshLoading().hideLoading(context);
                      CshSnackBar.error(context: context, message: error);
                    });
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: Dimens.space_8);
              },
              itemCount: provider.scannedAwbList?.length ?? 0,
            ),
          ),
          const SizedBox(height: Dimens.space_24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
          const SizedBox(height: Dimens.space_24),
          if (!Validator.isListNullOrEmpty(provider.listOfInvoicePicture)) ...[
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
                        provider.removeInvoiceFile(index);
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
            const Expanded(child: SizedBox.shrink()),
          ],
          SizedBox(
            width: double.infinity,
            child: CshMediumButton(
              text: l10n.finishDispatch,
              onPressed: !Validator.isListNullOrEmpty(provider.listOfInvoicePicture)
                  ? () {
                      _finishDispatch(provider);
                    }
                  : null,
            ),
          )
        ],
      ),
    );
  }

  _finishDispatch(CompleteDispatchProvider provider) {
    CshLoading().showLoading(context);
    provider.finishDispatch().then((value) {
      CshLoading().hideLoading(context);
      showAlertDialog(context, title: "Success", desc: "Dispatch Completed", onPosBtnPressed: (_) {
        Navigator.pop(context);
        Navigator.popUntil(context, (route) => route.settings.name == ShipexHomeScreen.route);
      });
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  _sendProofOfDispatch(bool isCsvUpload) {
    var provider = CompleteDispatchProvider.of(context, listen: false);
    CshLoading().showLoading(context);
    provider.sendPodInPdfOrInCsv(isCsvUpload: isCsvUpload).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        if (Validator.isTrue(isCsvUpload)) {
          CshSnackBar.success(context: context, message: "CSV sent successfully!!");
        } else {
          CshSnackBar.success(context: context, message: "PDF sent successfully!!");
        }
      }
    }, onError: (error) {
      CshLoading().hideLoading(context);
      CshSnackBar.error(context: context, message: error);
    });
  }

  Widget _getParentWidget(
      {required Widget child, required CompleteDispatchProvider provider, required ThemeData theme}) {
    if (Validator.isListNullOrEmpty(provider.listOfInvoicePicture)) {
      return Expanded(child: child);
    } else {
      return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.30,
        decoration: BoxDecoration(
          border: Border.all(color: theme.shadowColor),
          borderRadius: BorderRadius.circular(Dimens.space_8),
        ),
        child: child,
      );
    }
  }
}
