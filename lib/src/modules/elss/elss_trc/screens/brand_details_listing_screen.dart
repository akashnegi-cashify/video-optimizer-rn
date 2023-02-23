import 'package:core_widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_trc/src/modules/elss/elss_trc/screens/part_selection_screen_trc.dart';
import 'package:provider/provider.dart';
import '../../common_models/elss_device_details_response.dart';
import '../providers/brands_listing_provider.dart';
import '../l10n.dart';

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
          appBar: CshHeader(
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
                    style: theme.primaryTextTheme.headline4,
                  ),
                  const SizedBox(height: Dimens.space_8),
                  CshDropDown(
                    onChanged: (DropDownItem data) {
                      if (data.id != null) {
                        _brandId = int.parse(data.id!);
                        if (provider.productsColorResponse != null || provider.brandsAllProductResponse != null) {
                          provider.resetProductsColors();
                          _showColourListing = false;
                          _showProductsListing = false;
                          _productId = null;
                          _colour = null;
                          setState(() {});
                        }

                        _getProductsFromBrandId(innerContext, int.parse(data.id!));
                      }
                    },
                    hintText: l10n.selectBrand,
                    items: provider.getBrandDropDownItems(provider.brandDetailsData!.brandDataList!),
                  )
                ],
                if (_showProductsListing == true &&
                    !Validator.isListNullOrEmpty(provider.brandsAllProductResponse?.listOfAllProducts)) ...[
                  const SizedBox(height: Dimens.space_20),
                  Text(
                    l10n.selectProduct,
                    style: theme.primaryTextTheme.headline4,
                  ),
                  const SizedBox(height: Dimens.space_8),
                  CshDropDown(
                    hintText: l10n.selectProduct,
                    onChanged: (DropDownItem data) {
                      if (data.id != null) {
                        _productId = int.parse(data.id!);
                        if (provider.productsColorResponse != null) {
                          provider.resetColors();
                          _showColourListing = false;
                          _colour = null;
                          setState(() {});
                        }
                        _getColoursFromProductId(innerContext, int.parse(data.id!));
                      }
                    },
                    items: provider.getProductDropDownItems(provider.brandsAllProductResponse!.listOfAllProducts!),
                  )
                ],
                if (_showColourListing) ...[
                  const SizedBox(height: Dimens.space_20),
                  Text(
                    l10n.selectColor,
                    style: theme.primaryTextTheme.headline4,
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
        Expanded(child: Text("$label:", style: theme.primaryTextTheme.headline4)),
        Expanded(child: Text(value, style: theme.primaryTextTheme.headline4))
      ],
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
        Navigator.of(context).pushReplacementNamed(PartSelectionScreenTrc.route, arguments: barcode);
      }
    }, onError: (error) {
      CshSnackBar.error(context: context, message: error);
      CshLoading().hideLoading(context);
    });
  }
}
