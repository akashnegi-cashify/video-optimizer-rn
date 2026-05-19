import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'engineer_list_response.g.dart';

@JsonSerializable()
class EngineerListResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "dt")
  EngineerListDataResponse? data;

  EngineerListResponse({
    this.refId,
    this.data,
  });

  static EngineerListResponse fromJson(Map<String, dynamic> data) => _$EngineerListResponseFromJson(data);

  Map<String, dynamic> toJson() => _$EngineerListResponseToJson(this);
}

@JsonSerializable()
class EngineerListDataResponse {
  @JsonKey(name: "dl")
  List<EngineerDataResponse>? engineerDataList;
  @JsonKey(name: "tp")
  int? totalPage;
  @JsonKey(name: "tr")
  int? totalRecord;

  EngineerListDataResponse({
    this.engineerDataList,
    this.totalPage,
    this.totalRecord,
  });

  static EngineerListDataResponse fromJson(Map<String, dynamic> data) => _$EngineerListDataResponseFromJson(data);

  Map<String, dynamic> toJson() => _$EngineerListDataResponseToJson(this);
}

@JsonSerializable()
class EngineerDataResponse {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "n")
  String? name;
  @JsonKey(name: "lc")
  String? location;

  bool? isUrgent;

  EngineerDataResponse({
    this.name,
    this.id,
    this.isUrgent,
    this.location,
  });

  static EngineerDataResponse fromJson(Map<String, dynamic> data) => _$EngineerDataResponseFromJson(data);

  Map<String, dynamic> toJson() => _$EngineerDataResponseToJson(this);
}

// Wrapper response model for CshApiList
@JsonSerializable()
class EngineerListApiResponse extends BaseResponse {
  @JsonKey(name: "data")
  List<EngineerDataResponse>? data;

  EngineerListApiResponse(super.cashifyAlert, super.trackUrl);

  // Custom fromJson to convert EngineerListResponse to EngineerListApiResponse
  static EngineerListApiResponse fromEngineerListResponse(EngineerListResponse? response) {
    if (response == null) {
      return EngineerListApiResponse(null, null);
    }
    final apiResponse = EngineerListApiResponse(null, null);
    apiResponse.data = response.data?.engineerDataList;
    return apiResponse;
  }

  static EngineerListApiResponse fromJson(Map<String, dynamic> json) => _$EngineerListApiResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EngineerListApiResponseToJson(this);
}
