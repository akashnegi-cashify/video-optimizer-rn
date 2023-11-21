import 'package:core_widgets/core_widgets.dart' hide ImageUtil;
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/qc/modules/supervisor/providers/supervisor_base_provider.dart';
import 'package:flutter_trc/qc/modules/supervisor/providers/supervisor_provider.dart';
import 'package:flutter_trc/qc/modules/supervisor/screens/supervisor_seach_screen.dart';
import 'package:flutter_trc/qc/modules/supervisor/widgets/part_variantion_list_item.dart';
import 'package:flutter_trc/src/common/dialogs/csh_remarks_dialog.dart';
import 'package:flutter_trc/src/common/gallery_screen.dart';
import 'package:flutter_trc/src/common/widgets/shimmer_list_widget.dart';
import 'package:provider/provider.dart';

import '../l10n.dart';

class SupervisorWidget extends StatelessWidget {
  SupervisorWidget({super.key});

  List<(GlobalKey, ExpansionTileController)>? _categoryGlobalKeys;

  @override
  Widget build(BuildContext context) {
    var provider = SupervisorProvider.of(context);
    var theme = Theme.of(context);
    CustomColors customTheme = theme.extension<CustomColors>() as CustomColors;
    if (provider.isLoading) {
      return const ShimmerListWidget();
    }

    if (!provider.isLoading && !Validator.isNullOrEmpty(provider.errorMessage)) {
      return Center(child: Text(provider.errorMessage!, style: theme.primaryTextTheme.titleMedium));
    }

    var categoryCounterMap = provider.categoryCounterMap;
    _categoryGlobalKeys ??=
        List.generate(categoryCounterMap.length, (index) => (GlobalKey(), ExpansionTileController()));
    var galleryImageList = provider.getGalleryImages();
    var l10n = L10n(context);

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: theme.primaryColor,
          child: CshIcon(FeatherIcons.filter, iconSize: MobileIconSize.large, iconColor: Colors.white),
          onPressed: () => _showCategoryMenu(context, provider, l10n),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider(
                            create: (_) =>
                                SupervisorBaseProvider(partVariationListResponse: provider.partVariationList),
                            child: const SupervisorSearchScreen(),
                          )),
                ).then((value) {
                  provider.partVariationList = value;
                });
              },
              child: Hero(
                tag: "Card",
                child: Container(
                  margin: const EdgeInsets.fromLTRB(Dimens.space_16, Dimens.space_16, Dimens.space_16, 0),
                  padding: const EdgeInsets.symmetric(vertical: Dimens.space_16, horizontal: Dimens.space_12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimens.space_6),
                    color: theme.cardColor,
                  ),
                  child: Row(
                    children: [
                      CshIcon(FeatherIcons.search, iconSize: MobileIconSize.small, padding: EdgeInsets.zero),
                      const SizedBox(width: Dimens.space_16),
                      Text("Search Functionality", style: theme.primaryTextTheme.headlineSmall)
                    ],
                  ),
                ),
              ),
            ),
            if (!Validator.isListNullOrEmpty(galleryImageList))
              Padding(
                padding: const EdgeInsets.only(top: Dimens.space_16, bottom: Dimens.space_4),
                child: InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, GalleryScreen.route,
                        arguments: GalleryScreenArguments(galleryImageList));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
                        padding: const EdgeInsets.symmetric(vertical: Dimens.space_4, horizontal: Dimens.space_8),
                        decoration: BoxDecoration(
                          border: Border.all(color: theme.shadowColor),
                          borderRadius: BorderRadius.circular(Dimens.space_4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CshIcon(FeatherIcons.image, iconSize: MobileIconSize.small, padding: EdgeInsets.zero),
                            const SizedBox(width: Dimens.space_4),
                            Text(l10n.viewDeviceImages, style: theme.primaryTextTheme.bodySmall),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(Dimens.space_16),
                child: Column(
                  children: List.generate(categoryCounterMap.length, (index) {
                    String? category = categoryCounterMap.keys.elementAt(index);
                    double progressValue = provider.getProgressValue(category).$1;
                    String progressInString = provider.getProgressValue(category).$2;
                    return Padding(
                      padding: const EdgeInsets.only(bottom: Dimens.space_16),
                      child: CshCard(
                        key: _categoryGlobalKeys?[index].$1,
                        child: Theme(
                          data: theme.copyWith(dividerColor: Colors.transparent),
                          child: ExpansionTile(
                            tilePadding: EdgeInsets.zero,
                            controller: _categoryGlobalKeys?[index].$2,
                            childrenPadding: const EdgeInsets.only(top: Dimens.space_8),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  progressInString,
                                  style: theme.primaryTextTheme.bodySmall?.copyWith(color: theme.primaryColor),
                                ),
                                const SizedBox(height: Dimens.space_4),
                                LinearProgressIndicator(
                                  value: progressValue,
                                  minHeight: Dimens.space_4,
                                  backgroundColor: theme.disabledColor,
                                  borderRadius: BorderRadius.circular(Dimens.space_4),
                                  valueColor: AlwaysStoppedAnimation(theme.primaryColor),
                                ),
                                const SizedBox(height: Dimens.space_16),
                                Text("${index + 1}. $category", style: theme.primaryTextTheme.titleMedium),
                              ],
                            ),
                            children: [
                              buildCategoryList(provider, category, theme),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(Dimens.space_16),
          decoration: BoxDecoration(
            color: theme.cardColor,
            boxShadow: [BoxShadow(color: theme.shadowColor, blurRadius: Dimens.space_4)],
          ),
          child: Row(
            children: [
              Expanded(
                child: CshBigButton(
                  text: l10n.markFail,
                  bgColor: theme.colorScheme.error,
                  onPressed: provider.isAnyQuestionAnswered() ? () => _onProceed(context, provider, l10n) : null,
                ),
              ),
              const SizedBox(width: Dimens.space_16),
              Expanded(
                child: CshBigButton(
                  text: l10n.pass,
                  bgColor: customTheme.successColor,
                  onPressed: !provider.isAnyQuestionAnswered() ? () => _onProceed(context, provider, l10n) : null,
                ),
              ),
            ],
          ),
        ));
  }

  _onProceed(BuildContext context, SupervisorProvider provider, L10n l10n) {
    showRemarksDialog(
      context,
      onProceed: (remarks) {
        Navigator.pop(context); // dismiss dialog
        CshLoading().showLoading(context);
        provider.submitDeviceDetails(remarks).then((value) {
          CshLoading().hideLoading(context);
          CshSnackBar.success(context: context, message: l10n.supervisionSuccessMessage);
          Navigator.pop(context); // dismiss screen
        }, onError: (error) {
          CshLoading().hideLoading(context);
          CshSnackBar.error(context: context, message: error);
        });
      },
    );
  }

  Widget buildCategoryList(SupervisorProvider provider, String category, ThemeData theme) {
    var list = provider.getCategoryVisePartVariationList(category);
    return ListView.separated(
      itemCount: list?.length ?? 0,
      shrinkWrap: true,
      primary: false,
      separatorBuilder: (_, __) => const SizedBox(height: Dimens.space_16),
      itemBuilder: (_, index) {
        var item = list?[index];
        return PartVariationListItem(
          item!,
          index,
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
    );
  }

  _showCategoryMenu(BuildContext context, SupervisorProvider provider, L10n l10n) {
    var categoryList = provider.getCategoryList();
    showCshBottomSheet(
        context: context,
        child: Builder(builder: (innerContext) {
          return Container(
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
            padding: const EdgeInsets.all(Dimens.space_16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CshTextNew.h3(l10n.category),
                const SizedBox(height: Dimens.space_8),
                const Divider(),
                const SizedBox(height: Dimens.space_8),
                Flexible(
                  flex: 1,
                  fit: FlexFit.loose,
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        var item = categoryList[index];
                        return InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            Scrollable.ensureVisible(_categoryGlobalKeys![index].$1.currentContext!,
                                duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
                            if (!_categoryGlobalKeys![index].$2.isExpanded) {
                              _categoryGlobalKeys![index].$2.expand();
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(Dimens.space_8),
                            child: CshTextNew.subTitle1("${index + 1}.  $item"),
                          ),
                        );
                      },
                      itemCount: categoryList.length),
                )
              ],
            ),
          );
        }));
  }
}
