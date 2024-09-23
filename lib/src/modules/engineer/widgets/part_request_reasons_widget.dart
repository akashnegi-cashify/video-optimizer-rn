import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';
import 'package:flutter_trc/src/modules/engineer/models/reason_list_response.dart';
import 'package:flutter_trc/src/modules/engineer/my_devices/wip_devices/view_parts/models/order_engineer_part.dart';
import 'package:flutter_trc/src/modules/engineer/providers/part_request_reasons_provider.dart';
import 'package:flutter_trc/src/utils/media_upload/providers/image_upload_provider.dart';
import 'package:flutter_trc/src/utils/media_upload/widgets/general_image_upload_card.dart';
import 'package:provider/provider.dart';

import '../../../utils/media_upload/models/image_upload_service_type_enum.dart';

class PartRequestReasonsWidget extends StatelessWidget implements PartRequestReasonInterface {
  final Function(List<OrderEngineerPart> partList)? onReasonsSubmitted;

  const PartRequestReasonsWidget(this.onReasonsSubmitted, {super.key});

  @override
  Widget build(BuildContext context) {
    var provider = PartRequestReasonsProvider.of(context);
    provider.partRequestReasonInterface ??= this;

    if (provider.isPageLoading) {
      return const ShimmerListWidget();
    }

    if (!Validator.isNullOrEmpty(provider.reasonListError)) {
      return Center(
        child: CshTextNew.bodyText1(provider.reasonListError ?? ""),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
              padding: const EdgeInsets.all(Dimens.space_16),
              separatorBuilder: (context, index) {
                return const SizedBox(height: Dimens.space_8);
              },
              itemBuilder: (context, index) {
                var item = provider.partRequestList[index];
                if (provider.isReasonRequired(item)) {
                  return _PartRequestReasonItem(
                    item,
                    onChanged: (selectedReasonId, imageUrlList) {
                      item.reasonId = int.parse(selectedReasonId);
                      item.imageList = imageUrlList;
                      provider.updatePartRequestItem(item);
                    },
                  );
                }
                return const SizedBox.shrink();
              },
              itemCount: provider.partRequestList.length),
        ),
        const SizedBox(height: Dimens.space_16),
        Container(
          width: double.infinity,
          margin: const EdgeInsets.all(Dimens.space_16),
          child: CshMediumButton(
            text: "Complete Part Request",
            onPressed: provider.isAllReasonsSelected()
                ? () => onReasonsSubmitted?.call(provider.filterRequestedPartList())
                : null,
          ),
        ),
      ],
    );
  }

  @override
  void noReasonRequired(List<OrderEngineerPart> partList) {
    onReasonsSubmitted?.call(partList);
  }
}

class _PartRequestReasonItem extends StatefulWidget {
  final OrderEngineerPart item;
  final Function(String selectedReasonId, List<String> imageUrlList) onChanged;

  const _PartRequestReasonItem(this.item, {super.key, required this.onChanged});

  @override
  State<_PartRequestReasonItem> createState() => _PartRequestReasonItemState();
}

class _PartRequestReasonItemState extends State<_PartRequestReasonItem> {
  DropDownItem<ReasonListData>? _selectedItem;
  final List<String> _imageList = [""];

  @override
  Widget build(BuildContext context) {
    var provider = PartRequestReasonsProvider.of(context);

    return CshCard(
      padding: const EdgeInsets.all(Dimens.space_12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CshTextNew.subTitle1(widget.item.partName ?? ""),
          const SizedBox(height: Dimens.space_6),
          CshTextNew.subTitle2(widget.item.sku ?? ""),
          const SizedBox(height: Dimens.space_6),
          CshTextNew.subTitle2(widget.item.partColor ?? ""),
          const SizedBox(height: Dimens.space_16),
          CshDropDown(
            items: provider.reasonsDropdownList,
            selectedItem: _selectedItem,
            onChanged: (DropDownItem<ReasonListData> value) {
              setState(() {
                _selectedItem = value;
                widget.onChanged(value.id!, _imageList);
              });
            },
          ),
          const SizedBox(height: Dimens.space_16),
          if (Validator.isTrue(_selectedItem?.extraData?.isImageRequired))
            SizedBox(
              height: Dimens.space_100,
              child: ListView.separated(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    var imageUrl = _imageList[index];
                    return ChangeNotifierProvider(
                      create: (_) => ImageUploadProvider(serviceType: ImageUploadServiceType.trc),
                      child: GeneralImageUploadCard(
                        cardHeight: 100,
                        cardWidth: 100,
                        imageUrl: imageUrl,
                        isImageMarkingRequired: true,
                        onMediaUploadingStarted: () {
                          if (_imageList.length < 5 && index == _imageList.length - 1) {
                            setState(() {
                              _imageList.add("");
                            });
                          }
                        },
                        onMediaUploaded: (url) {
                          setState(() {
                            _imageList[index] = url ?? "";
                            widget.onChanged(_selectedItem!.id!, _imageList);
                          });
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: Dimens.space_12);
                  },
                  itemCount: _imageList.length),
            )
        ],
      ),
    );
  }
}
