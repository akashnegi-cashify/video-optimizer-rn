import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/qc/modules/qc_tester/lob_devices/resources/device_detail_response.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category_response.g.dart';

@JsonSerializable()
class CategoryResponse extends BaseResponse {
  @JsonKey(name: "category")
  CategoryData? categoryData;

  CategoryResponse(this.categoryData, super.cashifyAlert, super.trackUrl);

  /// Custom fromJson to handle both QC and TRC response formats
  /// QC format: { "category": {...} }
  /// TRC format: { "cat": {...} }
  static CategoryResponse fromJson(Map<String, dynamic> json) {
    // Check if TRC format (has 'cat' field)
    if (json.containsKey('cat') && json['cat'] != null) {
      return CategoryResponse(
        CategoryData.fromJson(json['cat'] as Map<String, dynamic>),
        json['__ca'] == null
            ? null
            : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
        json['turl'] as String?,
      );
    }
    
    // QC format - use standard parsing
    return _$CategoryResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$CategoryResponseToJson(this);
}
