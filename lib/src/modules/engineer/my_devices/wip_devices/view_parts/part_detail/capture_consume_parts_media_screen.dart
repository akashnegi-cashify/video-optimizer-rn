import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/utils/csh_ml_scanner_util.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/part_detail/models/retrieved_part_reason_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/part_detail/providers/capture_consume_parts_media_provider.dart';
import 'package:flutter_trc/src/utils/media_upload/models/image_upload_service_type_enum.dart';
import 'package:flutter_trc/src/utils/media_upload/providers/image_upload_provider.dart';
import 'package:flutter_trc/src/utils/media_upload/widgets/general_image_upload_card.dart';
import 'package:provider/provider.dart';

import '../../../../l10n.dart';

enum CapturePartMediaType { consumed, retrieved }

class CaptureConsumePartMediaArg {
  final int? retrievedPartsMediaCount;
  final int? partRequestId;
  final Function(
    Map<CapturePartMediaType, List<String>> urlsMap,
    String? retrievedPartBarcode,
    RetrievedPartReasonListData? selectedReason,
    String? remarks,
  ) onImageUploaded;

  const CaptureConsumePartMediaArg(this.partRequestId,
      {required this.onImageUploaded, this.retrievedPartsMediaCount = 0});
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
  final _remarksController = TextEditingController();
  DropDownItem? _selectedReason;

  @override
  Widget build(BuildContext context) {
    var arg = ModalRoute.of(context)?.settings.arguments as CaptureConsumePartMediaArg;
    var theme = Theme.of(context);
    L10n l10n = L10n(context);
    return ChangeNotifierProvider(
      create: (_) => CaptureConsumePartsMediaProvider(),
      child: PopScope(
        canPop: true,
        child: Scaffold(
            appBar: TrcHeader(l10n.captureConsumedPartsMedia, showBackBtn: true),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(Dimens.space_16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _CaptureMediaModule(
                      key: const ValueKey("Consumed Parts"),
                      title: l10n.consumedPartsMedia,
                      onImageUploaded: (urls) {
                        setState(() {
                          _consumedPartsUrls = urls;
                        });
                      }),
                  const SizedBox(height: Dimens.space_12),
                  if ((arg.retrievedPartsMediaCount ?? 0) > 0) ...[
                    const Divider(),
                    const SizedBox(height: Dimens.space_12),
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
                    const SizedBox(height: Dimens.space_8),
                    Container(
                      color: Colors.white,
                      child: Consumer<CaptureConsumePartsMediaProvider>(
                        builder: (context, provider, child) {
                          return FutureBuilder(
                              future: provider.getReasonsList(arg.partRequestId),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState != ConnectionState.done || !snapshot.hasData) {
                                  return const SizedBox.shrink();
                                }
                                var list = _getReasonsDropdownList(snapshot.data!);
                                return CshDropDown(
                                  items: list,
                                  hintText: "Select Reasons",
                                  selectedItem: _selectedReason,
                                  onChanged: (DropDownItem? newValue) {
                                    setState(() {
                                      _selectedReason = newValue;
                                    });
                                  },
                                );
                              });
                        },
                      ),
                    ),
                    const SizedBox(height: Dimens.space_16),
                    CshTextFormField(
                      hintText: l10n.addRemarksOptional,
                      hintStyle: theme.textTheme.labelSmall?.copyWith(color: theme.disabledColor),
                      controller: _remarksController,
                      maxLines: 3,
                    ),
                  ],
                ],
              ),
            ),
            bottomNavigationBar: Padding(
              padding: const EdgeInsets.all(Dimens.space_16),
              child: CshBigButton(
                text: l10n.proceed,
                onPressed: _canProceed(arg.retrievedPartsMediaCount ?? 0)
                    ? () {
                        Map<CapturePartMediaType, List<String>> urlsMap = {};
                        urlsMap[CapturePartMediaType.consumed] = _consumedPartsUrls ?? [];
                        urlsMap[CapturePartMediaType.retrieved] = _retrievedPartsUrls ?? [];
                        arg.onImageUploaded(
                          urlsMap,
                          _barcodeController.text,
                          _getRetrievedReasonFromDropDown(_selectedReason),
                          _remarksController.text,
                        );
                      }
                    : null,
              ),
            )),
      ),
    );
  }

  RetrievedPartReasonListData? _getRetrievedReasonFromDropDown(DropDownItem? selectedReason) {
    if (selectedReason == null) {
      return null;
    }
    int id = int.parse(selectedReason.id!);
    return RetrievedPartReasonListData(id, selectedReason.label);
  }

  List<DropDownItem> _getReasonsDropdownList(List<RetrievedPartReasonListData> list) {
    return List.generate(list.length, (index) {
      var item = list[index];
      return DropDownItem(item.id.toString(), item.reason);
    });
  }

  bool _canProceed(int retrievedPartsMediaCount) {
    if (Validator.isListNullOrEmpty(_consumedPartsUrls)) {
      return false;
    }

    if (retrievedPartsMediaCount > 0 &&
        (Validator.isListNullOrEmpty(_retrievedPartsUrls) ||
            Validator.isNullOrEmpty(_barcodeController.text) ||
            _selectedReason == null)) {
      return false;
    }

    return true;
  }

  @override
  void dispose() {
    _barcodeController.dispose();
    _remarksController.dispose();
    super.dispose();
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
        SizedBox(
          height: 120,
          child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(Dimens.space_8),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                var item = _imageList[index];
                return ChangeNotifierProvider(
                  create: (_) => ImageUploadProvider(serviceType: ImageUploadServiceType.trc),
                  child: GeneralImageUploadCard(
                    cardHeight: 100,
                    cardWidth: 100,
                    imageUrl: item,

                    onMediaUploaded: (url) {
                      setState(() {
                        _imageList[index] = url!;
                      });
                      widget.onImageUploaded(_imageList);
                    },
                  ),
                );
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
