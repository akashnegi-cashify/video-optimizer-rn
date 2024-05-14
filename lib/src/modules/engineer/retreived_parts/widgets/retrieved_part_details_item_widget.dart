import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/models/engineer_part_info.dart';
import 'package:provider/provider.dart';

import '../../../../utils/media_upload/models/image_upload_service_type_enum.dart';
import '../../../../utils/media_upload/providers/image_upload_provider.dart';
import '../../../../utils/media_upload/widgets/general_image_upload_card.dart';
import '../l10n.dart';
import '../providers/retrieved_part_data_provider.dart';

class RetrievedPartDetailsItemWidget extends StatefulWidget {
  final EngineerPartInfo? itemModel;

  const RetrievedPartDetailsItemWidget({
    super.key,
    this.itemModel,
  });

  @override
  State<RetrievedPartDetailsItemWidget> createState() => _RetrievedPartDetailsItemWidgetState();
}

class _RetrievedPartDetailsItemWidgetState extends State<RetrievedPartDetailsItemWidget>
    with AutomaticKeepAliveClientMixin {
  final TextEditingController _barcodeTextController = TextEditingController();
  final TextEditingController _remarkController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var provider = RetrievedPartsDataProviders.of(context);
    super.build(context);
    var theme = Theme.of(context);
    var l10n = L10n(context);
    return CshCard(
      radius: CshRadius.rad8,
      elevation: CardElevation.dimen_10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!Validator.isNullOrEmpty(widget.itemModel?.partName))
            Text(
              widget.itemModel!.partName!,
              style: theme.primaryTextTheme.displaySmall,
            ),
          const SizedBox(height: Dimens.space_16),
          Text("${l10n.attachPartImage}*", style: theme.primaryTextTheme.headlineSmall),
          const SizedBox(height: Dimens.space_4),
          ChangeNotifierProvider(
            create: (_) => ImageUploadProvider(serviceType: ImageUploadServiceType.trc),
            child: GeneralImageUploadCard(
              cardHeight: 70.0,
              cardWidth: 70.0,
              imageUrl: provider.retrievedPartRequest.imageUrl,
              onMediaUploaded: (url) {
                provider.onS3UrlChange(url ?? "");
              },
            ),
          ),
          const SizedBox(height: Dimens.space_8),
          Text("${l10n.selectReason}*", style: theme.primaryTextTheme.headlineSmall),
          const SizedBox(height: Dimens.space_4),
          SingleSelectDropDown(
            borderColor: theme.shadowColor,
            hintText: l10n.selectReason,
            labelText: l10n.selectReason,
            onSelect: (DropDownItem item) {
              if (item.id != null) {
                int id = int.parse(item.id!);
                provider.onReasonSelected(item.label ?? "", id);
              }
            },
            items: !Validator.isListNullOrEmpty(provider.reasonList)
                ? List.generate(
                    provider.reasonList!.length,
                    (index) => DropDownItem(
                      provider.reasonList![index].id.toString(),
                      provider.reasonList![index].reason,
                    ),
                  )
                : [],
          ),
          const SizedBox(height: Dimens.space_8),
          Text("${l10n.barcode}*", style: theme.primaryTextTheme.headlineSmall),
          const SizedBox(height: Dimens.space_4),
          CshTextFormField(
            controller: _barcodeTextController,
            keyboardType: TextInputType.name,
            hintText: l10n.barcode,
            labelText: l10n.barcode,
            onChanged: (String data) {
              provider.onBarcodeChanged(data.trim());
            },
            maxLines: 1,
            maxLength: 50,
          ),
          const SizedBox(height: Dimens.space_4),
          Text("${l10n.remark} (Optional)", style: theme.primaryTextTheme.headlineSmall),
          const SizedBox(height: Dimens.space_4),
          CshTextFormField(
            controller: _remarkController,
            hintText: l10n.remark,
            labelText: l10n.remark,
            keyboardType: TextInputType.name,
            onChanged: (String data) {
              provider.onRemarkChanged(data.trim());
            },
            maxLines: 1,
            maxLength: 50,
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
