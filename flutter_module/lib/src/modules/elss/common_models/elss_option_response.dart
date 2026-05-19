import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'elss_option_response.g.dart';

@JsonSerializable()
class ElssOptionResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "em")
  String? errorMessage;
  @JsonKey(name: "dt")
  List<OptionResponse>? listOfOptions;

  ElssOptionResponse(
    this.errorMessage,
    this.refId,
    this.listOfOptions,
  );

  static ElssOptionResponse fromJson(Map<String, dynamic> data) => _$ElssOptionResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ElssOptionResponseToJson(this);
}

@JsonSerializable()
class OptionResponse {
  @JsonKey(name: "k")
  int? key;
  @JsonKey(name: "v")
  String? optionName;
  @JsonKey(name: "isra")
  bool? isRubbingApplicable;
  @JsonKey(name: "isPna")
  bool? isPnaApplicable;
  @JsonKey(name: "isGc")
  bool? isGlassChangeApplicable;
  @JsonKey(name: "isCc")
  bool? isCameraCleaningApplicable;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isOptionSelected;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isApplicableReasonRequired;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isGc;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isCc;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isRub;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isPNA;

  OptionResponse(
    this.isRubbingApplicable,
    this.isPnaApplicable,
    this.isGlassChangeApplicable,
    this.key,
    this.optionName, {
    this.isCameraCleaningApplicable = false,
    this.isGc = false,
    this.isCc = false,
    this.isPNA = false,
    this.isRub = false,
    this.isOptionSelected = false,
    this.isApplicableReasonRequired = false,
  });

  bool getIsApplicableOptionsPresent() {
    if (Validator.isTrue(isPnaApplicable) &&
        Validator.isTrue(isGlassChangeApplicable) &&
        Validator.isTrue(isRubbingApplicable)) {
      return true;
    }
    if (Validator.isTrue(isCameraCleaningApplicable)) {
      return true;
    }
    return false;
  }

  static OptionResponse fromJson(Map<String, dynamic> data) => _$OptionResponseFromJson(data);

  Map<String, dynamic> toJson() => _$OptionResponseToJson(this);
}
