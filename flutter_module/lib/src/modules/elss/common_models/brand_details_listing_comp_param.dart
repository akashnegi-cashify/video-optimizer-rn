import 'package:csh_annotation/annotation.dart';

import '../elss_trc/screens/brand_details_listing_screen.dart';

@CshPageParam()
class BrandDetailsListingParam {
  @ParamKey(key: BrandDetailsListingParamKeys.brandListingArg)
  BrandDetailsListingArguments? arguments;

  BrandDetailsListingParam({
    this.arguments,
  });
}

enum BrandDetailsListingParamKeys with AbsParamKey {
  brandListingArg("arg");

  @override
  final String value;

  const BrandDetailsListingParamKeys(this.value);
}
