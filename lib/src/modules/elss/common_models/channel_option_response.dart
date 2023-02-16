import 'package:json_annotation/json_annotation.dart';
import 'elss_part.dart';

part 'channel_option_response.g.dart';

@JsonSerializable()
class ChannelOptionResponse {
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "pm")
  int? pm;
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "dt")
  ChannelOptionDataModel? channelOptionData;

  ChannelOptionResponse({
    this.isSuccess,
    this.pm,
    this.refId,
    this.channelOptionData,
  });

  static ChannelOptionResponse fromJson(Map<String, dynamic> data) => _$ChannelOptionResponseFromJson(data);

  Map<String, dynamic> toJson() => _$ChannelOptionResponseToJson(this);
}

@JsonSerializable()
class ChannelOptionDataModel {
  @JsonKey(name: "dbr")
  String? barcode;
  @JsonKey(name: "in")
  ChannelOptionData? initialChannelOption;
  @JsonKey(name: "fi")
  List<ChannelOptionData>? listOfChannelOption;
  @JsonKey(name: "df")
  ChannelOptionData? defaultChannelOption;

  ChannelOptionDataModel({
    this.barcode,
    this.defaultChannelOption,
    this.initialChannelOption,
    this.listOfChannelOption,
  });

  static ChannelOptionDataModel fromJson(Map<String, dynamic> data) => _$ChannelOptionDataModelFromJson(data);

  Map<String, dynamic> toJson() => _$ChannelOptionDataModelToJson(this);
}

@JsonSerializable()
class ChannelOptionData {
  @JsonKey(name: "oid")
  int? optionId;
  @JsonKey(name: "ch")
  String? channelName;
  @JsonKey(name: "pr")
  double? channelOptionPrice;
  @JsonKey(name: "gr")
  String? grade;
  @JsonKey(name: "isr")
  bool? isRubbingAllowed;
  @JsonKey(name: "rp")
  List<ElssPart>? requestedParts;

  ChannelOptionData({
    this.optionId,
    this.channelName,
    this.channelOptionPrice,
    this.grade,
    this.isRubbingAllowed,
    this.requestedParts,
  });

  static ChannelOptionData fromJson(Map<String, dynamic> data) => _$ChannelOptionDataFromJson(data);

  Map<String, dynamic> toJson() => _$ChannelOptionDataToJson(this);
}
