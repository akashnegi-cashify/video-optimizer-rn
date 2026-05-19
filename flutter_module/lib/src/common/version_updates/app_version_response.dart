import 'package:json_annotation/json_annotation.dart';

part 'app_version_response.g.dart';

@JsonSerializable()
class AppVersionResponse {
  @JsonKey(name: "dt")
  List<AppVersionData>? versionList;

  AppVersionResponse(this.versionList);

  static AppVersionResponse fromJson(Map<String, dynamic> json) => _$AppVersionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AppVersionResponseToJson(this);
}

@JsonSerializable()
class AppVersionData {
  @JsonKey(name: "version")
  String? versionName;

  @JsonKey(name: "isMajor")
  bool? isMajorUpdate;

  @JsonKey(name: "apkUrl")
  String? apkUrl;

  AppVersionData(this.versionName, this.isMajorUpdate);

  static AppVersionData fromJson(Map<String, dynamic> json) => _$AppVersionDataFromJson(json);

  Map<String, dynamic> toJson() => _$AppVersionDataToJson(this);
}
