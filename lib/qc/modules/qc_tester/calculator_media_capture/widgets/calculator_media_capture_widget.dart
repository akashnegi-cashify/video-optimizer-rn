import 'dart:async';

import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/screens/submit_device_quote_screen.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator_media_capture/providers/calculator_media_capture_provider.dart';

import '../../../../../src/utils/media_upload/widgets/image_upload_widget.dart';
import '../../../../../src/utils/media_upload/widgets/video_upload_card.dart';

class CalculatorMediaCaptureWidget extends StatefulWidget {
  const CalculatorMediaCaptureWidget({super.key});

  @override
  State<CalculatorMediaCaptureWidget> createState() => _CalculatorMediaCaptureWidgetState();
}

class _CalculatorMediaCaptureWidgetState extends State<CalculatorMediaCaptureWidget> {
  @override
  void initState() {
    scheduleMicrotask(
      () {
        var provider = CalculatorMediaCaptureProvider.of(context, listen: false);
        provider.getDeviceMedia(onMoveToNextScreen: () => _navigateToDeviceQuoteScreen());
      },
    );
    super.initState();
  }

  _navigateToDeviceQuoteScreen() {
    Navigator.pushReplacementNamed(context, SubmitDeviceQuoteScreen.route);
  }

  @override
  Widget build(BuildContext context) {
    var provider = CalculatorMediaCaptureProvider.of(context);
    var theme = Theme.of(context);
    if (Validator.isTrue(provider.isDataLoading)) {
      return const Center(
        child: SizedBox(
          height: Dimens.space_30,
          width: Dimens.space_30,
          child: CircularProgressIndicator(),
        ),
      );
    } else if (!Validator.isNullOrEmpty(provider.errorMessage)) {
      return Center(
        child: Row(
          children: [
            const SizedBox.shrink(),
            Expanded(
                child: Text(
              provider.errorMessage!,
              style: theme.primaryTextTheme.displaySmall,
              textAlign: TextAlign.center,
            ))
          ],
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
        child: Column(
          children: [
            if (!Validator.isListNullOrEmpty(provider.deviceMediaResponse?.imageList))
              Expanded(
                child: SingleChildScrollView(
                  child: Row(
                    children: [
                      const SizedBox.shrink(),
                      Expanded(
                        child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.spaceBetween,
                          runSpacing: Dimens.space_16,
                          children: List.generate(
                            provider.deviceMediaResponse!.imageList!.length,
                            (index) {
                              var item = provider.deviceMediaResponse!.imageList![index];
                              return Validator.isTrue(item.isVideo)
                                  ? VideoUploadOptimizerCard(
                                      dataModel: item,
                                      onMediaUploaded: (String? url) {
                                        item.mediaUrl = url;
                                        provider.notifyListeners();
                                        Logger.debug('mydebug------_CalculatorMediaCaptureWidgetState.build', [url]);
                                      },
                                    )
                                  : ImageUploadOptimizerCard(
                                      dataModel: item,
                                      onMediaUploaded: (String? url) {
                                        item.mediaUrl = url;
                                        provider.notifyListeners();
                                        Logger.debug('mydebug------_CalculatorMediaCaptureWidgetState.build', [url]);
                                      },
                                    );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (provider.isAllMediaUpLoaded()) ...[
              const SizedBox(height: Dimens.space_16),
              SizedBox(
                width: double.infinity,
                child: CshMediumButton(
                  text: "Done",
                  onPressed: () {
                    provider.saveMediaList();
                    if (Validator.isTrue(provider.isComingFromCalJourney)) {
                      _navigateToDeviceQuoteScreen();
                    } else {
                      CshLoading().showLoading(context);
                      provider.submitDeviceMedia().then((value) {
                        CshLoading().hideLoading(context);
                        CshSnackBar.success(context: context, message: "Media Updloaded Successfully");
                        Navigator.pop(context);
                      }, onError: (error) {
                        CshLoading().hideLoading(context);
                        CshSnackBar.error(context: context, message: error);
                      });
                    }
                  },
                ),
              )
            ],
          ],
        ),
      );
    }
  }
}
