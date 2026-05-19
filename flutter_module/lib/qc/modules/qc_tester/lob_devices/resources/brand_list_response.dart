import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'brand_list_response.g.dart';

@JsonSerializable()
class BrandListResponse extends BaseResponse {
  @JsonKey(name: 'data')
  List<BrandListData>? brandList;

  BrandListResponse(this.brandList, super.cashifyAlert, super.trackUrl);

  /// Custom fromJson to handle both QC and TRC response formats
  /// QC format: { "data": [...], "__ca": ..., "turl": ... }
  /// TRC format: { "dt": [...], "s": true }
  static BrandListResponse fromJson(Map<String, dynamic> json) {
    // Check if TRC format (has 'dt' array)
    if (json.containsKey('dt') && json['dt'] is List<dynamic>) {
      final dt = json['dt'] as List<dynamic>;
      return BrandListResponse(
        dt.map((e) => BrandListData.fromJson(e as Map<String, dynamic>)).toList(),
        json['__ca'] == null
            ? null
            : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
        json['turl'] as String?,
      );
    }
    
    // QC format - use standard parsing
    return _$BrandListResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$BrandListResponseToJson(this);
}

@JsonSerializable()
class BrandListData {
  @JsonKey(name: 'brandId')
  int? brandId;

  @JsonKey(name: 'brandName')
  String? brandName;

  BrandListData(this.brandId, this.brandName);

  /// Custom fromJson to handle both QC and TRC response formats
  /// QC format: { "brandId": 1, "brandName": "Apple" }
  /// TRC format: { "bid": 1, "bn": "Apple" }
  static BrandListData fromJson(Map<String, dynamic> json) {
    // Check if TRC format (has 'bid' and 'bn' fields)
    if (json.containsKey('bid') || json.containsKey('bn')) {
      return BrandListData(
        (json['bid'] as num?)?.toInt(),
        json['bn'] as String?,
      );
    }
    
    // QC format - use standard parsing
    return _$BrandListDataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$BrandListDataToJson(this);
}
