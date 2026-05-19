import 'package:core_widgets/core_widgets.dart';
import 'package:json_annotation/json_annotation.dart';

part 'inventory_location_response.g.dart';

@JsonSerializable()
class InventoryLocationResponse {
  @JsonKey(name: "r_id")
  String? refId;
  @JsonKey(name: "dt")
  List<String>? locationsDataList;

  InventoryLocationResponse({
    this.locationsDataList,
    this.refId,
  });

  static InventoryLocationResponse fromJson(Map<String, dynamic> data) => _$InventoryLocationResponseFromJson(data);

  Map<String, dynamic> toJson() => _$InventoryLocationResponseToJson(this);
}

// Wrapper response model for CshApiList
@JsonSerializable()
class LocationListResponse extends BaseResponse {
  @JsonKey(name: "data")
  List<LocationItem>? data;

  LocationListResponse(super.cashifyAlert, super.trackUrl);

  // Custom fromJson to convert InventoryLocationResponse to LocationListResponse
  static LocationListResponse fromInventoryResponse(InventoryLocationResponse? response) {
    if (response == null) {
      return LocationListResponse(null, null);
    }
    final locationListResponse = LocationListResponse(null, null);
    locationListResponse.data = response.locationsDataList
        ?.map((locationName) => LocationItem(locationName: locationName))
        .toList();
    return locationListResponse;
  }

  static LocationListResponse fromJson(Map<String, dynamic> json) {
    // Handle response with dt field directly (array of strings)
    if (json.containsKey('dt') && json['dt'] is List) {
      final response = LocationListResponse(
        json['__ca'] == null ? null : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
        json['turl'] as String?,
      );
      response.data = (json['dt'] as List<dynamic>?)
          ?.map((e) {
            if (e is String) {
              return LocationItem(locationName: e);
            } else {
              return LocationItem.fromJson(e);
            }
          })
          .toList();
      return response;
    }
    // Fallback to generated fromJson for standard BaseResponse format
    return _$LocationListResponseFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => _$LocationListResponseToJson(this);
}

@JsonSerializable()
class LocationItem {
  @JsonKey(name: "locationName")
  String? locationName;

  LocationItem({
    this.locationName,
  });

  // Custom fromJson to handle string items from the API
  static LocationItem fromJson(dynamic json) {
    if (json is String) {
      return LocationItem(locationName: json);
    } else if (json is Map<String, dynamic>) {
      return _$LocationItemFromJson(json);
    }
    return LocationItem(locationName: json?.toString());
  }

  Map<String, dynamic> toJson() => _$LocationItemToJson(this);
}

class GroupLocationModel {
  String? locationName;
  bool? isSelected;

  GroupLocationModel({
    this.isSelected,
    this.locationName,
  });
}
