import 'package:json_annotation/json_annotation.dart';

part 'store_in_location_verify_response.g.dart';

@JsonSerializable()
class StoreInLocationVerifyResponse {
  @JsonKey(name: "availableCapacity")
  int? availableSpace;

  @JsonKey(name: "totalCapacity")
  int? totalSpace;

  @JsonKey(name: "verifyBarcodeStatus")
  int? verifyBarcodeStatus;

  @JsonKey(name: "message")
  String? message;

  /// Request ID from TRC response
  @JsonKey(name: "r_id")
  String? requestId;

  StoreInLocationVerifyResponse({
    this.availableSpace,
    this.totalSpace,
    this.verifyBarcodeStatus,
    this.message,
    this.requestId,
  });

  /// Custom fromJson to handle both QC and TRC response formats
  /// QC format: { "s": 1, "availableCapacity": ..., "totalCapacity": ... }
  /// TRC format: { "dt": { "r_id": ..., "tc": ..., "s": 1, "ac": ... }, "s": true }
  static StoreInLocationVerifyResponse fromJson(Map<String, dynamic> json) {
    // Check if TRC format (has 'dt' object)
    if (json.containsKey('dt') && json['dt'] is Map<String, dynamic>) {
      final dt = json['dt'] as Map<String, dynamic>;
      return StoreInLocationVerifyResponse(
        success: dt['s'] is int ? dt['s'] : (dt['s'] == true ? 1 : 0),
        availableSpace: (dt['ac'] as num?)?.toInt(),
        totalSpace: (dt['tc'] as num?)?.toInt(),
        requestId: dt['r_id'] as String?,
        message: dt['message'] as String?,
      );
    }
    
    // QC format - use standard parsing
    return _$StoreInLocationVerifyResponseFromJson(json);
  }

  Map<String, dynamic> toJson() => _$StoreInLocationVerifyResponseToJson(this);
}

@JsonSerializable()
class VerifyBarcode {
  @JsonKey(name: "qrCode")
  String? qrCode;

  VerifyBarcode({this.qrCode});

  static VerifyBarcode fromJson(Map<String, dynamic> json) => _$VerifyBarcodeFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyBarcodeToJson(this);
}
