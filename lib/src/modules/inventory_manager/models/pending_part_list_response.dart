import 'package:json_annotation/json_annotation.dart';

import '../resources/part_status_enum.dart';

part 'pending_part_list_response.g.dart';

@JsonSerializable()
class PendingPartListResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "s")
  bool? isSuccess;
  @JsonKey(name: "dt")
  List<PendingPartDataResponse>? partDataList;

  PendingPartListResponse({
    this.isSuccess,
    this.refId,
    this.partDataList,
  });

  static PendingPartListResponse fromJson(Map<String, dynamic> data) => _$PendingPartListResponseFromJson(data);

  Map<String, dynamic> toJson() => _$PendingPartListResponseToJson(this);
}

@JsonSerializable()
class PendingPartDataResponse {
  @JsonKey(name: "sku")
  String? sku;
  @JsonKey(name: "pn")
  String? pn;
  @JsonKey(name: "st")
  String? st;
  @JsonKey(name: "prid")
  int? prid;
  @JsonKey(name: "stc")
  int? statusCode;

  @JsonKey(name: "prdt")
  int? requestedTime;

  PendingPartDataResponse({
    this.sku,
    this.pn,
    this.prid,
    this.requestedTime,
    this.st,
    this.statusCode,
  });

  PartStatus getPartStatus() {
    if (statusCode == 12) {
      return PartStatus.AVAILABLE;
    } else if (statusCode == 13) {
      return PartStatus.NOT_AVAILABLE;
    } else {
      return PartStatus.OTHER;
    }
  }

  static PendingPartDataResponse fromJson(Map<String, dynamic> data) => _$PendingPartDataResponseFromJson(data);

  Map<String, dynamic> toJson() => _$PendingPartDataResponseToJson(this);
}
