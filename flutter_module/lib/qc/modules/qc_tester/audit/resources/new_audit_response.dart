import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'new_audit_response.g.dart';

@JsonSerializable()
class NewAuditResponse extends BaseResponse {
  @JsonKey(name: "r_id")
  String? referenceId;

  @JsonKey(name: "dt")
  AuditQuestionResponse? auditQuestionResponse;

  NewAuditResponse(super.cashifyAlert, super.trackUrl);

  static NewAuditResponse fromJson(Map<String, dynamic> json) => _$NewAuditResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NewAuditResponseToJson(this);
}

@JsonSerializable()
class AuditQuestionResponse {
  @JsonKey(name: "dpr")
  List<AuditQuestionData>? auditQuestionList;

  @JsonKey(name: "maq")
  List<ManualAuditQuestionItem>? manualAuditQuestionList;

  static AuditQuestionResponse fromJson(Map<String, dynamic> json) => _$AuditQuestionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AuditQuestionResponseToJson(this);
}

@JsonSerializable()
class AuditQuestionData {
  @JsonKey(name: "pi")
  int? questionId;

  @JsonKey(name: "pn")
  String? question;

  @JsonKey(name: "ic")
  int? imageCount;

  @JsonKey(name: "v")
  Map<String, String>? options;

    @JsonKey(name: "subVariations")
  Map<String, List<String>>? subVariations;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? selectedOption;

  @JsonKey(includeFromJson: false, includeToJson: false)
  List<String>? selectedSubVariations;

  @JsonKey(includeFromJson: false, includeToJson: false)
  Map<String, String?>? selectedSubVariationImageUrls;

  @JsonKey(includeFromJson: false, includeToJson: false)
  String? s3url;


  AuditQuestionData(
    this.questionId,
    this.question,
    this.options, {
    this.selectedOption,
    this.s3url,
    this.subVariations,
    this.selectedSubVariations,
    this.selectedSubVariationImageUrls,
  });

  static AuditQuestionData fromJson(Map<String, dynamic> json) {
    Map<String, String>? parsedOptions;
    final rawOptions = json['v'];
    if (rawOptions is Map) {
      parsedOptions = rawOptions.map((key, value) =>
          MapEntry(key.toString(), value?.toString() ?? ''));
    }

    Map<String, List<String>>? parsedSubVariations;
    final rawSubVariations = json['subVariations'];
    if (rawSubVariations is Map) {
      parsedSubVariations = rawSubVariations.map((key, value) {
        final list = value is List
            ? value.map((e) => e.toString()).toList()
            : <String>[];
        return MapEntry(key.toString(), list);
      });
    }

    final data = AuditQuestionData(
      json['pi'] as int?,
      json['pn'] as String?,
      parsedOptions,
      subVariations: parsedSubVariations,
    );

    final ic = json['ic'];
    if (ic is num) {
      data.imageCount = ic.toInt();
    } else if (ic != null) {
      final parsed = int.tryParse(ic.toString());
      if (parsed != null) data.imageCount = parsed;
    }

    return data;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'pi': questionId,
      'pn': question,
      'ic': imageCount,
      'v': options,
      'subVariations': subVariations,
    };
  }
}

@JsonSerializable()
class ManualAuditQuestionItem {
  @JsonKey(name: "mmid")
  int? manualMasterId;

  @JsonKey(name: "q")
  String? question;

  @JsonKey(name: "is")
  bool? isSelected;

  ManualAuditQuestionItem(this.manualMasterId, this.question);

  static ManualAuditQuestionItem fromJson(Map<String, dynamic> json) => _$ManualAuditQuestionItemFromJson(json);

  Map<String, dynamic> toJson() => _$ManualAuditQuestionItemToJson(this);
}
