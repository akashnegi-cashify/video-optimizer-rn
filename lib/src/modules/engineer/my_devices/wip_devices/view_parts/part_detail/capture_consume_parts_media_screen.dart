import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/utils/media_upload/models/image_upload_service_type_enum.dart';
import 'package:flutter_trc/src/utils/media_upload/providers/image_upload_provider.dart';
import 'package:flutter_trc/src/utils/media_upload/widgets/general_image_upload_card.dart';
import 'package:provider/provider.dart';
import '../../../../l10n.dart';

enum CapturePartMediaType { consumed, retrieved }

class CaptureConsumePartMediaArg {
  final int? retrievedPartsMediaCount;
  final Function(Map<CapturePartMediaType, List<String>> urlsMap, String? retrievedPartBarcode) onImageUploaded;

  const CaptureConsumePartMediaArg({required this.onImageUploaded, this.retrievedPartsMediaCount = 0});
}

class CaptureConsumePartsMediaScreen extends StatefulWidget {
  static String route = "/capture_consume_parts_media_screen";

  const CaptureConsumePartsMediaScreen({super.key});

  @override
  State<CaptureConsumePartsMediaScreen> createState() => _CaptureConsumePartsMediaScreenState();
}

class _CaptureConsumePartsMediaScreenState extends State<CaptureConsumePartsMediaScreen> {
  List<String>? _consumedPartsUrls;
  List<String>? _retrievedPartsUrls;

  final _barcodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)?.settings.arguments as CaptureConsumePartMediaArg;
    var theme = Theme.of(context);
    L10n l10n = L10n(context);
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: TrcHeader(l10n.captureConsumedPartsMedia, showBackBtn: true),
        body: Padding(
          padding: const EdgeInsets.all(Dimens.space_16),
          child: Column(
            children: [
              _CaptureMediaModule(
                  key: const ValueKey("Consumed Parts"),
                  title: l10n.consumedPartsMedia,
                  onImageUploaded: (urls) {
                    setState(() {
                      _consumedPartsUrls = urls;
                    });
                  }),
              const SizedBox(height: Dimens.space_16),
              if ((arg.retrievedPartsMediaCount ?? 0) > 0) ...[
                const Divider(),
                const SizedBox(height: Dimens.space_16),
                _CaptureMediaModule(
                    key: const ValueKey("Retrieved Parts"),
                    imageCount: arg.retrievedPartsMediaCount!,
                    title: l10n.retrievedPartsMedia,
                    onImageUploaded: (urls) {
                      setState(() {
                        _retrievedPartsUrls = urls;
                      });
                    }),
                const SizedBox(height: Dimens.space_16),
                CshTextFormField(
                  hintText: l10n.retrievedPartsBarcode,
                  hintStyle: theme.textTheme.labelSmall?.copyWith(color: theme.disabledColor),
                  controller: _barcodeController,
                  suffixIcon: InkWell(
                    child: const Icon(Icons.qr_code_2),
                    onTap: () {
                      CshMlScannerUtil().openScanner(context, onScanned: (scannedData, controller) {
                        Navigator.pop(context); // close scanner
                        setState(() {
                          _barcodeController.text = scannedData;
                        });
                      });
                    },
                  ),
                  onChanged: (value) {
                    setState(() {
                      _barcodeController.text = value;
                    });
                  },
                ),
              ],
              const Expanded(child: SizedBox.shrink()),
              CshBigButton(
                text: l10n.proceed,
                onPressed: _canProceed(arg.retrievedPartsMediaCount ?? 0)
                    ? () {
                        Map<CapturePartMediaType, List<String>> urlsMap = {};
                        urlsMap[CapturePartMediaType.consumed] = _consumedPartsUrls ?? [];
                        urlsMap[CapturePartMediaType.retrieved] = _retrievedPartsUrls ?? [];
                        arg.onImageUploaded(urlsMap, _barcodeController.text);
                      }
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _canProceed(int retrievedPartsMediaCount) {
    if (Validator.isListNullOrEmpty(_consumedPartsUrls)) {
      return false;
    }

    if (retrievedPartsMediaCount > 0 &&
        (Validator.isListNullOrEmpty(_retrievedPartsUrls) || Validator.isNullOrEmpty(_barcodeController.text))) {
      return false;
    }

    return true;
  }
}

class _CaptureMediaModule extends StatefulWidget {
  final String title;
  final int imageCount;
  final Function(List<String> urls) onImageUploaded;

  const _CaptureMediaModule({super.key, required this.title, this.imageCount = 1, required this.onImageUploaded});

  @override
  State<_CaptureMediaModule> createState() => _CaptureMediaModuleState();
}

class _CaptureMediaModuleState extends State<_CaptureMediaModule> {
  late List<String> _imageList;

  @override
  void initState() {
    _imageList = List.generate(widget.imageCount, (index) => "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title, style: theme.primaryTextTheme.titleMedium),
        const SizedBox(height: Dimens.space_16),
        Container(
          height: 120,
          alignment: Alignment.center,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(Dimens.space_8),
              itemBuilder: (context, index) {
                var item = _imageList[index];
                return ChangeNotifierProvider(
                    create: (_) => ImageUploadProvider(serviceType: ImageUploadServiceType.trc),
                    child: GeneralImageUploadCard(
                      cardHeight: 100,
                      cardWidth: 100,
                      imageUrl: item,
                      // onMediaUploadingStarted: () {
                      //   setState(() {
                      //     if (_imageList.length < 8 && index == _imageList.length - 1) {
                      //       _imageList.add("");
                      //     }
                      //   });
                      // },
                      onMediaUploaded: (url) {
                        setState(() {
                          _imageList[index] = url!;
                        });
                        widget.onImageUploaded(_imageList);
                      },
                    ));
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: Dimens.space_16);
              },
              itemCount: _imageList.length),
        ),
      ],
    );
  }
}
