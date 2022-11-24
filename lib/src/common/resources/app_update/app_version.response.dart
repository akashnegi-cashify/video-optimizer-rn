import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'app_version.response.g.dart';

@JsonSerializable()
class AppVersionResponse extends BaseResponse {
  @JsonKey(name: 'maj')
  bool? majorUpdate;

  @JsonKey(name: 'min')
  bool? minorUpdate;

  @JsonKey(name: 'majm')
  String? majorUpdateMsg;

  @JsonKey(name: 'minm')
  String? minorUpdateMsg;

  @JsonKey(name: 'lav')
  String? availableLatestVersion;

  static AppVersionResponse fromJson(Map<String, dynamic> json) => _$AppVersionResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AppVersionResponseToJson(this);

  AppVersionResponse(
    this.majorUpdate,
    this.minorUpdate,
    this.majorUpdateMsg,
    this.minorUpdateMsg,
    this.availableLatestVersion,
    CashifyAlert? cashifyAlert,
    String? trackUrl,
  ) : super(cashifyAlert, trackUrl);
}
