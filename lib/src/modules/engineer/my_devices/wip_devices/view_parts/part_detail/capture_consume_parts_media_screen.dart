import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/utils/media_upload/models/image_upload_service_type_enum.dart';
import 'package:flutter_trc/src/utils/media_upload/providers/image_upload_provider.dart';
import 'package:flutter_trc/src/utils/media_upload/widgets/general_image_upload_card.dart';
import 'package:provider/provider.dart';

class CaptureConsumePartMediaArg {
  final int? retrievedPartsMediaCount;
  final Function(Map<String, List<String>> urlsMap) onImageUploaded;

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

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)?.settings.arguments as CaptureConsumePartMediaArg;
    return PopScope(
      canPop: true,
      child: Scaffold(
        appBar: const TrcHeader("Capture Consumed Parts Media", showBackBtn: true),
        body: Padding(
          padding: const EdgeInsets.all(Dimens.space_16),
          child: Column(
            children: [
              _CaptureMediaModule(
                  key: const ValueKey("Consumed Parts"),
                  title: "Consumed Parts Media",
                  onImageUploaded: (urls) {
                    setState(() {
                      _consumedPartsUrls = urls;
                    });
                  }),
              const SizedBox(height: Dimens.space_24),
              if ((arg.retrievedPartsMediaCount ?? 0) > 0)
                _CaptureMediaModule(
                    key: const ValueKey("Retrieved Parts"),
                    imageCount: arg.retrievedPartsMediaCount!,
                    title: "Retrieved Parts Media",
                    onImageUploaded: (urls) {
                      setState(() {
                        _retrievedPartsUrls = urls;
                      });
                    }),
              const Expanded(child: SizedBox.shrink()),
              CshBigButton(
                text: "Proceed",
                onPressed: _canProceed(arg.retrievedPartsMediaCount ?? 0)
                    ? () {
                        Map<String, List<String>> urlsMap = {};
                        urlsMap["consumedParts"] = _consumedPartsUrls ?? [];
                        urlsMap["retrievedParts"] = _retrievedPartsUrls ?? [];
                        arg.onImageUploaded(urlsMap);
                        Navigator.pop(context);
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

    if (retrievedPartsMediaCount > 0 && Validator.isListNullOrEmpty(_retrievedPartsUrls)) {
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
