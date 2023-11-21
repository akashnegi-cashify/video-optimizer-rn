import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/qc/modules/supervisor/providers/supervisor_base_provider.dart';
import 'package:flutter_trc/qc/modules/supervisor/widgets/part_variantion_list_item.dart';

class SupervisorSearchScreen extends StatefulWidget {
  const SupervisorSearchScreen({super.key});

  @override
  State<SupervisorSearchScreen> createState() => _SupervisorSearchScreenState();
}

class _SupervisorSearchScreenState extends State<SupervisorSearchScreen> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var provider = SupervisorBaseProvider.of(context);
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, provider.getCompletePartVariationList());
        return Future.value(false);
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(Dimens.space_16),
          child: Column(
            children: [
              const SizedBox(height: 56),
              Hero(
                tag: "Card",
                child: Material(
                  color: Colors.transparent,
                  child: CshTextFormField(
                    hintText: "Search Functionality",
                    isBorderAllowed: false,
                    autofocus: true,
                    backgroundColor: theme.cardColor,
                    prefixIcon: CshIcon(FeatherIcons.search, iconSize: MobileIconSize.small, padding: EdgeInsets.zero),
                    onChanged: (value) {
                      provider.searchQuery = value;
                    },
                  ),
                ),
              ),
              const SizedBox(height: Dimens.space_8),
              Expanded(
                child: ListView.separated(
                  itemCount: provider.partVariationList?.length ?? 0,
                  separatorBuilder: (_, __) => const SizedBox(height: Dimens.space_16),
                  itemBuilder: (_, index) {
                    var item = provider.partVariationList?[index];
                    return PartVariationListItem(
                      key: ValueKey(item?.partId),
                      item!,
                      index,
                      countingType: CountingType.numeric,
                      onImageClicked: (imageUrl) {
                        provider.updateImage(item.partId!, imageUrl);
                      },
                      onValueSelected: (variationId) {
                        provider.updateUserSelectedVariantId(item.partId!, variationId);
                      },
                      onReset: () {
                        provider.resetQuestion(item.partId!);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
