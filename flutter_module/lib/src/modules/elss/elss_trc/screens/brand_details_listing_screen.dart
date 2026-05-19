import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_trc/src/header/trc_header.dart';
import 'package:flutter_trc/src/modules/elss/elss_trc/screens/part_selection_screen_trc.dart';
import 'package:provider/provider.dart';

import '../../common_models/elss_device_details_response.dart';
import '../l10n.dart';
import '../providers/brands_listing_provider.dart';

class BrandDetailsListingArguments {
  final String barcode;
  final ElssDeviceDetailsResponse? deviceDetailsResponse;

  BrandDetailsListingArguments({
    required this.barcode,
    this.deviceDetailsResponse,
  });
}

class BrandsDetailsListingScreen extends StatefulWidget {
  static const String route = "/brand_details_listing_screen";

  const BrandsDetailsListingScreen({Key? key}) : super(key: key);

  @override
  State<BrandsDetailsListingScreen> createState() => _BrandsDetailsListingScreenState();
}

class _BrandsDetailsListingScreenState extends State<BrandsDetailsListingScreen> {
  bool _showProductsListing = false, _showColourListing = false;
  int? _brandId, _productId;
  String? _colour;
  String? _selectedBrandName;
  String? _selectedProductName;

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var l10n = L10n(context);
    BrandDetailsListingArguments args = ModalRoute.of(context)?.settings.arguments as BrandDetailsListingArguments;
    return ChangeNotifierProvider(
      lazy: false,
      create: (_) => BrandsListingProvider(args.barcode),
      builder: (BuildContext innerContext, __) {
        var provider = BrandsListingProvider.of(innerContext);
        return Scaffold(
          appBar: TrcHeader(
            l10n.deviceDetails,
            showBackBtn: true,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimens.space_12, horizontal: Dimens.space_16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _detailsCard(args.deviceDetailsResponse, theme, l10n, args.barcode),
                const SizedBox(height: Dimens.space_20),
                if (!Validator.isListNullOrEmpty(provider.brandDetailsData?.brandDataList)) ...[
                  Text(
                    l10n.selectBrand,
                    style: theme.primaryTextTheme.headlineMedium,
                  ),
                  const SizedBox(height: Dimens.space_8),
                  InkWell(
                    onTap: () {
                      _showSearchableBottomSheet(
                        title: l10n.selectBrand,
                        hintText: "Search brand...",
                        items: provider.getBrandDropDownItems(provider.brandDetailsData!.brandDataList!),
                        onSelected: (DropDownItem data) {
                      if (data.id != null) {
                        _brandId = int.parse(data.id!);
                            _selectedBrandName = data.label;
                        if (provider.productsColorResponse != null || provider.brandsAllProductResponse != null) {
                          provider.resetProductsColors();
                          _showColourListing = false;
                          _showProductsListing = false;
                          _productId = null;
                              _selectedProductName = null;
                          _colour = null;
                            }
                          setState(() {});
                        _getProductsFromBrandId(innerContext, int.parse(data.id!));
                      }
                    },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.extension<CustomColors>()?.inputStrokeColor ?? Colors.grey),
                        borderRadius: BorderRadius.circular(CshRadius.rad4.value),
                        color: theme.canvasColor,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _selectedBrandName ?? l10n.selectBrand,
                              style: _selectedBrandName != null
                                  ? theme.textTheme.labelSmall
                                  : theme.textTheme.labelSmall?.copyWith(color: theme.shadowColor),
                            ),
                          ),
                          CshIcon.assets(
                            packageIcon('ic_down_arrow.png'),
                            padding: EdgeInsets.zero,
                            iconSize: MobileIconSize.medium,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
                if (_showProductsListing == true &&
                    !Validator.isListNullOrEmpty(provider.brandsAllProductResponse?.listOfAllProducts)) ...[
                  const SizedBox(height: Dimens.space_20),
                  Text(
                    l10n.selectProduct,
                    style: theme.primaryTextTheme.headlineMedium,
                  ),
                  const SizedBox(height: Dimens.space_8),
                  InkWell(
                    onTap: () {
                      _showSearchableBottomSheet(
                        title: l10n.selectProduct,
                        hintText: "Search product...",
                        items: provider.getProductDropDownItems(provider.brandsAllProductResponse!.listOfAllProducts!),
                        onSelected: (DropDownItem data) {
                      if (data.id != null) {
                        _productId = int.parse(data.id!);
                            _selectedProductName = data.label;
                        if (provider.productsColorResponse != null) {
                          provider.resetColors();
                          _showColourListing = false;
                          _colour = null;
                            }
                          setState(() {});
                        _getColoursFromProductId(innerContext, int.parse(data.id!));
                      }
                    },
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
                      decoration: BoxDecoration(
                        border: Border.all(color: theme.extension<CustomColors>()?.inputStrokeColor ?? Colors.grey),
                        borderRadius: BorderRadius.circular(CshRadius.rad4.value),
                        color: theme.canvasColor,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _selectedProductName ?? l10n.selectProduct,
                              style: _selectedProductName != null
                                  ? theme.textTheme.labelSmall
                                  : theme.textTheme.labelSmall?.copyWith(color: theme.shadowColor),
                            ),
                          ),
                          CshIcon.assets(
                            packageIcon('ic_down_arrow.png'),
                            padding: EdgeInsets.zero,
                            iconSize: MobileIconSize.medium,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
                if (_showColourListing) ...[
                  const SizedBox(height: Dimens.space_20),
                  Text(
                    l10n.selectColor,
                    style: theme.primaryTextTheme.headlineMedium,
                  ),
                  const SizedBox(height: Dimens.space_8),
                  CshDropDown(
                    hintText: l10n.selectColor,
                    onChanged: (DropDownItem data) {
                      _colour = data.label;
                    },
                    items: provider.getProductColorDropDownItems(provider.productsColorResponse?.listOfColours),
                  )
                ],
                const Expanded(
                  child: SizedBox(),
                ),
                ComboButton(
                  padding: EdgeInsets.zero,
                  isFirstPrimary: true,
                  firstBtnText: l10n.cancel,
                  secondBtnText: l10n.submit,
                  firstBtnClick: () {
                    Navigator.of(context).pop(true);
                  },
                  secondBtnClick: () {
                    if (_brandId != null && _productId != null) {
                      _submitDeviceDetails(innerContext, args.barcode, _brandId!, _productId!, color: _colour);
                    } else {
                      if (_brandId == null) {
                        CshSnackBar.error(context: context, message: l10n.pleaseSelectBrand);
                      } else if (_productId == null) {
                        CshSnackBar.error(context: context, message: l10n.pleaseSelectProduct);
                      }
                    }
                  },
                  buttonType: ButtonType.mini,
                )
              ],
            ),
          ),
        );
      },
    );
  }

  _detailsCard(ElssDeviceDetailsResponse? dataModel, ThemeData theme, L10n l10n, String barcode) {
    return CshCard(
      radius: CshRadius.rad8,
      elevation: CardElevation.dimen_10,
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _labelValueWidget(
              theme,
              l10n.deviceBarcode,
              barcode,
            ),
            const SizedBox(height: Dimens.space_8),
            _labelValueWidget(
              theme,
              l10n.deviceName,
              dataModel?.deviceDetailsData?.deviceName ?? "",
            ),
            const SizedBox(height: Dimens.space_8),
            _labelValueWidget(
              theme,
              l10n.deviceColour,
              dataModel?.deviceDetailsData?.deviceColor ?? "",
            ),
          ],
        ),
      ),
    );
  }

  _labelValueWidget(ThemeData theme, String label, String value) {
    return Row(
      children: [
        Expanded(child: Text("$label:", style: theme.primaryTextTheme.headlineMedium)),
        Expanded(child: Text(value, style: theme.primaryTextTheme.headlineMedium))
      ],
    );
  }

  void _showSearchableBottomSheet({
    required String title,
    required String hintText,
    required List<DropDownItem> items,
    required Function(DropDownItem) onSelected,
  }) {
    showCshBottomSheet(
      context: context,
      wrapContent: false,
      child: _SearchableBottomSheetContent(
        title: title,
        hintText: hintText,
        items: items,
        onSelected: onSelected,
      ),
    );
  }

  _getProductsFromBrandId(BuildContext insideContext, int brandId) {
    var provider = BrandsListingProvider.of(insideContext, listen: false);
    CshLoading().showLoading(context);
    provider.fetchProductsFromBid(brandId).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        _showProductsListing = true;
        setState(() {});
      }
    }, onError: (error) {
      CshSnackBar.error(context: context, message: error);
      CshLoading().hideLoading(context);
    });
  }

  _getColoursFromProductId(BuildContext insideContext, int productId) {
    var provider = BrandsListingProvider.of(insideContext, listen: false);
    CshLoading().showLoading(context);
    provider.fetchProductColorByPid(productId).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        _showColourListing = true;
        setState(() {});
      }
    }, onError: (error) {
      CshSnackBar.error(context: context, message: error);
      CshLoading().hideLoading(context);
    });
  }

  _submitDeviceDetails(BuildContext insideContext, String barcode, int brandId, int productId, {String? color}) {
    var provider = BrandsListingProvider.of(insideContext, listen: false);
    CshLoading().showLoading(context);
    provider.submitDeviceDetails(barcode, brandId, productId, color: color).then((value) {
      CshLoading().hideLoading(context);
      if (value) {
        CshSnackBar.success(context: context, message: "Details Submitted Successfully!!");
        PartSelectionScreenTrcArguments args = PartSelectionScreenTrcArguments(barcode: barcode);
        Navigator.of(context).pushReplacementNamed(PartSelectionScreenTrc.route, arguments: args);
      }
    }, onError: (error) {
      CshSnackBar.error(context: context, message: error);
      CshLoading().hideLoading(context);
    });
  }
}

class _SearchableBottomSheetContent extends StatefulWidget {
  final String title;
  final String hintText;
  final List<DropDownItem> items;
  final Function(DropDownItem) onSelected;

  const _SearchableBottomSheetContent({
    required this.title,
    required this.hintText,
    required this.items,
    required this.onSelected,
  });

  @override
  State<_SearchableBottomSheetContent> createState() => _SearchableBottomSheetContentState();
}

class _SearchableBottomSheetContentState extends State<_SearchableBottomSheetContent> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final filteredItems = _searchQuery.isEmpty
        ? widget.items
        : widget.items.where((item) => (item.label ?? "").toLowerCase().contains(_searchQuery.toLowerCase())).toList();

    return Padding(
      padding: EdgeInsets.only(bottom: bottomInset, top: Dimens.space_12),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.50,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(Dimens.space_16),
              child: Text(
                widget.title,
                style: theme.primaryTextTheme.headlineMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16),
              child: CshTextFormField(
                controller: _searchController,
                hintText: widget.hintText,
                prefixIcon: CshIcon(FeatherIcons.search, iconSize: MobileIconSize.small),
                suffixIcon: _searchQuery.isNotEmpty
                    ? CshIcon(FeatherIcons.x, iconSize: MobileIconSize.small, onClick: () {
                        _searchController.clear();
                        setState(() {
                          _searchQuery = "";
                        });
                      })
                    : null,
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            const SizedBox(height: Dimens.space_8),
            Expanded(
              child: filteredItems.isEmpty
                  ? const Center(
                      child: Text("No results found"),
                    )
                  : ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        return InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            widget.onSelected(item);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: Dimens.space_16, vertical: Dimens.space_12),
                            child: Text(
                              item.label ?? "",
                              style: theme.textTheme.bodyMedium,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
