import 'package:builder_project/builder_project.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:csh_annotation/annotation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';

import '../../../../app_builder/app_builder_groups/groups.dart';
import '../../common_models/add_device_media_comp_param.dart';
import '../../widgets/add_media_card.dart';
import '../l10n.dart';

part 'add_device_media_screen_trc.g.dart';

class AddDeviceMediaArgumentsTrc {
  final List<String>? partsImage;
  final Function(int, String)? onImageUploadCallback;

  AddDeviceMediaArgumentsTrc({this.onImageUploadCallback, this.partsImage});
}

@CshPage(
    key: AddDeviceMediaScreenTrc.pageKey,
    params: AddDeviceMediaCompParamKeys.values,
    pageGroup: PageGroup.addDeviceMediaPageKey)
class AddDeviceMediaScreenTrcArguments extends BaseArguments {
  final AddDeviceMediaArgumentsTrc? argumentsData;

  AddDeviceMediaScreenTrcArguments({this.argumentsData}) : super(AddDeviceMediaScreenTrc.pageKey);

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {};
    data[AddDeviceMediaCompParamKeys.addDeviceMediaArg.value] = argumentsData;
    return data;
  }
}

class AddDeviceMediaScreenTrc extends BaseScreen<AddDeviceMediaScreenTrcArguments> {
  static const String pageKey = "TRC_add_media_screen_trc";
  static const route = '/add_device_media_screen_trc';

  const AddDeviceMediaScreenTrc({super.key});

  @override
  Widget buildView(BuildContext context) {
    var args = getArguments(context);
    return PageWidget(
      pageKey: pageKey,
      initialValue: args?.toJson(),
    );
  }
}

class AddDeviceMedia extends StatefulWidget {
  final List<String>? listOfPartsImages;
  final Function(int, String)? setS3DataToParticularItem;

  const AddDeviceMedia({
    Key? key,
    this.setS3DataToParticularItem,
    this.listOfPartsImages,
  }) : super(key: key);

  @override
  State<AddDeviceMedia> createState() => _AddDeviceMediaState();
}

class _AddDeviceMediaState extends State<AddDeviceMedia> {
  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AddMediaCards(
                index: 0,
                imageUrl: widget.listOfPartsImages![0],
                setS3UrlToList: widget.setS3DataToParticularItem ?? (int index, String data) {},
              ),
            ),
            const SizedBox(width: Dimens.space_6),
            Expanded(
              child: AddMediaCards(
                index: 1,
                imageUrl: widget.listOfPartsImages![1],
                setS3UrlToList: widget.setS3DataToParticularItem ?? (int index, String data) {},
              ),
            ),
            const SizedBox(width: Dimens.space_6),
            Expanded(
              child: AddMediaCards(
                index: 2,
                imageUrl: widget.listOfPartsImages![2],
                setS3UrlToList: widget.setS3DataToParticularItem ?? (int index, String data) {},
              ),
            ),
          ],
        ),
        const SizedBox(height: Dimens.space_8),
        Row(
          children: [
            Expanded(
              child: AddMediaCards(
                index: 3,
                imageUrl: widget.listOfPartsImages![3],
                setS3UrlToList: widget.setS3DataToParticularItem ?? (int index, String data) {},
              ),
            ),
            const SizedBox(width: Dimens.space_6),
            Expanded(
              child: AddMediaCards(
                index: 4,
                imageUrl: widget.listOfPartsImages![4],
                setS3UrlToList: widget.setS3DataToParticularItem ?? (int index, String data) {},
              ),
            ),
            const SizedBox(width: Dimens.space_6),
            Expanded(
              child: AddMediaCards(
                index: 5,
                imageUrl: widget.listOfPartsImages![5],
                setS3UrlToList: widget.setS3DataToParticularItem ?? (int index, String data) {},
              ),
            ),
          ],
        ),
        const Expanded(
          child: SizedBox(),
        ),
        SizedBox(
          width: double.infinity,
          child: CshMediumButton(
            text: l10n.done,
            onPressed: () {
              Navigator.of(context).pop(true);
            },
          ),
        )
      ],
    );
    // return Scaffold(
    //   appBar: TrcHeader(l10n.captureImages),
    //   body: Padding(
    //     padding: const EdgeInsets.symmetric(vertical: Dimens.space_16, horizontal: Dimens.space_8),
    //     child: ,
    //   ),
    // );
  }
}
