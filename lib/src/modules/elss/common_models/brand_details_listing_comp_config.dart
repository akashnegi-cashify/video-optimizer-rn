import 'package:csh_annotation/annotation.dart';

part 'brand_details_listing_comp_config.g.dart';

@ConfigModel()
class BrandDetailsListingCompConfig {
  @ConfigKey(name: "none")
  String? none;

  BrandDetailsListingCompConfig({
    this.none,
  });

  static BrandDetailsListingCompConfig fromConfig(Map<String, dynamic> data) =>
      _$BrandDetailsListingCompConfigFromConfig(data);
}
