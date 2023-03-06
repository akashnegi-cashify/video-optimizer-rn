import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import '../l10n.dart';
import '../../widgets/add_media_card.dart';

class AddDeviceMediaArgumentsTrc {
  final List<String>? partsImage;
  final Function(int, String)? onImageUploadCallback;

  AddDeviceMediaArgumentsTrc({this.onImageUploadCallback, this.partsImage});
}

class AddDeviceMediaScreenTrc extends StatelessWidget {
  static const route = '/add_device_media_screen_trc';

  const AddDeviceMediaScreenTrc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AddDeviceMediaArgumentsTrc args = ModalRoute.of(context)?.settings.arguments as AddDeviceMediaArgumentsTrc;
    return _AddDeviceMedia(
      listOfPartsImages: args.partsImage,
      setS3DataToParticularItem: args.onImageUploadCallback,
    );
  }
}

class _AddDeviceMedia extends StatefulWidget {
  final List<String>? listOfPartsImages;
  final Function(int, String)? setS3DataToParticularItem;

  const _AddDeviceMedia({
    Key? key,
    this.setS3DataToParticularItem,
    this.listOfPartsImages,
  }) : super(key: key);

  @override
  State<_AddDeviceMedia> createState() => _AddDeviceMediaState();
}

class _AddDeviceMediaState extends State<_AddDeviceMedia> {
  @override
  Widget build(BuildContext context) {
    var l10n = L10n(context);
    return Scaffold(
      appBar: CshHeader(l10n.captureImages),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: Dimens.space_16, horizontal: Dimens.space_8),
        child: Column(
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
        ),
      ),
    );
  }
}
