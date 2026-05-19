import 'package:builder_project/builder_project.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator/resources/media_submit_request.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator_media_capture/models/calculator_media_capture_comp_param.dart';
import 'package:flutter_trc/qc/modules/qc_tester/calculator_media_capture/resources/journey_type.dart';
import 'package:flutter_trc/src/app_builder/app_builder_groups/groups.dart';

part 'calculator_media_capture_screen.g.dart';

class CalculatorMediaCaptureScreenArg extends BaseArguments {
  final String deviceBarcode;
  final int? categoryId;
  final JourneyType journeyType;
  final Function(List<MediaSubmitRequest> mediaList)? onMediaListUpdated;

  CalculatorMediaCaptureScreenArg(this.deviceBarcode,
      {this.categoryId, this.onMediaListUpdated, required this.journeyType})
      : super(CalculatorMediaCaptureScreen.pageKey);

  Map<String, dynamic> toJson() {
    return {
      CalculatorMediaCaptureParamKeys.journeyType.value: journeyType,
      CalculatorMediaCaptureParamKeys.deviceBarcode.value: deviceBarcode,
      CalculatorMediaCaptureParamKeys.categoryId.value: categoryId,
      CalculatorMediaCaptureParamKeys.onMediaListUpdated.value: onMediaListUpdated,
    };
  }
}

@CshPage(
  key: CalculatorMediaCaptureScreen.pageKey,
  pageGroup: PageGroup.calculatorMediaCapturePageKey,
  params: CalculatorMediaCaptureParamKeys.values,
)
class CalculatorMediaCaptureScreen extends BaseScreen<CalculatorMediaCaptureScreenArg> {
  static const String pageKey = "calculator_media_capture";
  static const String route = "/calculator_media_capture_screen";

  const CalculatorMediaCaptureScreen({super.key});

  @override
  Widget buildView(BuildContext context) {
    var arg = getArguments(context);
    return PageWidget(pageKey: pageKey, initialValue: arg?.toJson());
  }

  static navigateTo(BuildContext context, String deviceBarcode,
      {JourneyType journeyType = JourneyType.generic,
      int? categoryId,
      Function(List<MediaSubmitRequest> mediaList)? onMediaListUpdated}) {
    Navigator.of(context).pushNamed(
      route,
      arguments: CalculatorMediaCaptureScreenArg(
        deviceBarcode,
        categoryId: categoryId,
        journeyType: journeyType,
        onMediaListUpdated: onMediaListUpdated,
      ),
    );
  }
}
