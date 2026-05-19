import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pending_device_list_response.g.dart';

@JsonSerializable()
class PendingDeviceListResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "dt")
  PendingDeviceData? data;

  PendingDeviceListResponse({
    this.refId,
    this.data,
  });

  static PendingDeviceListResponse fromJson(Map<String, dynamic> data) => _$PendingDeviceListResponseFromJson(data);

  Map<String, dynamic> toJson() => _$PendingDeviceListResponseToJson(this);
}

@JsonSerializable()
class PendingDeviceData {
  @JsonKey(name: "tp")
  int? totalPage;
  @JsonKey(name: "tr")
  int? totalRecords;
  @JsonKey(name: "dl")
  List<PendingDeviceDetailData>? dataList;

  PendingDeviceData({
    this.totalPage,
    this.totalRecords,
    this.dataList,
  });

  static PendingDeviceData fromJson(Map<String, dynamic> data) => _$PendingDeviceDataFromJson(data);

  Map<String, dynamic> toJson() => _$PendingDeviceDataToJson(this);
}

@JsonSerializable()
class PendingDeviceDetailData {
  @JsonKey(name: "deviceId")
  int? deviceId;

  @JsonKey(name: "productTitle")
  String? productTitle;

  @JsonKey(name: "deviceBarcode")
  String? deviceBarcode;

  @JsonKey(name: "trayBarcode")
  String? trayBarcode;

  @JsonKey(name: 'partAvailableCount')
  int? partAvailableCount;

  @JsonKey(name: "totalPartCount")
  int? totalPartCount;

  @JsonKey(name: "engineerName")
  String? engineerName;

  @JsonKey(name: "location")
  String? location;

  @JsonKey(name: "assignedAt")
  int? assignedAt;

  @JsonKey(name: "isUrgent")
  bool? isUrgent;

  @JsonKey(name: "repairType")
  String? repairType;

  @JsonKey(name: "grade")
  String? grade;
  @JsonKey(includeFromJson: false, includeToJson: false)
  bool? isAssignedToRider;

  PendingDeviceDetailData({
    this.isUrgent,
    this.repairType,
    this.partAvailableCount,
    this.grade,
    this.deviceBarcode,
    this.assignedAt,
    this.deviceId,
    this.engineerName,
    this.location,
    this.productTitle,
    this.trayBarcode,
    this.totalPartCount,
    this.isAssignedToRider = false,
  });

  static PendingDeviceDetailData fromJson(Map<String, dynamic> data) => _$PendingDeviceDetailDataFromJson(data);

  Map<String, dynamic> toJson() => _$PendingDeviceDetailDataToJson(this);
}

extension PendingDeviceDetailDataClone on PendingDeviceDetailData {
  PendingDeviceDetailData copyWith({
    int? deviceId,
    String? productTitle,
    String? deviceBarcode,
    String? trayBarcode,
    int? partAvailableCount,
    int? totalPartCount,
    String? engineerName,
    String? location,
    int? assignedAt,
    bool? isUrgent,
    String? repairType,
    String? grade,
    bool? isAssignedToRider,
  }) {
    return PendingDeviceDetailData(
      deviceId: deviceId ?? this.deviceId,
      productTitle: productTitle ?? this.productTitle,
      deviceBarcode: deviceBarcode ?? this.deviceBarcode,
      trayBarcode: trayBarcode ?? this.trayBarcode,
      partAvailableCount: partAvailableCount ?? this.partAvailableCount,
      totalPartCount: totalPartCount ?? this.totalPartCount,
      engineerName: engineerName ?? this.engineerName,
      location: location ?? this.location,
      assignedAt: assignedAt ?? this.assignedAt,
      isUrgent: isUrgent ?? this.isUrgent,
      repairType: repairType ?? this.repairType,
      grade: grade ?? this.grade,
      isAssignedToRider: isAssignedToRider ?? this.isAssignedToRider,
    );
  }
}


// Wrapper response model for CshApiList
@JsonSerializable()
class PendingDeviceListApiResponse extends BaseResponse {
  @JsonKey(name: "data")
  List<PendingDeviceDetailData>? data;

  PendingDeviceListApiResponse(super.cashifyAlert, super.trackUrl);

  // Custom fromJson to convert PendingDeviceListResponse to PendingDeviceListApiResponse
  static PendingDeviceListApiResponse fromPendingDeviceListResponse(
    PendingDeviceListResponse? response,
  ) {
    if (response == null) {
      return PendingDeviceListApiResponse(null, null);
    }
    final apiResponse = PendingDeviceListApiResponse(null, null);
    apiResponse.data = response.data?.dataList;
    return apiResponse;
  }

  static PendingDeviceListApiResponse fromJson(Map<String, dynamic> json) =>
      _$PendingDeviceListApiResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PendingDeviceListApiResponseToJson(this);
}
