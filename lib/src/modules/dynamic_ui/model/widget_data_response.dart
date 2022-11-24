import 'package:json_annotation/json_annotation.dart';

part 'widget_data_response.g.dart';

@JsonSerializable()
class WidgetDataResponse {
  @JsonKey(name: 'columns', includeIfNull: false)
  List<WidgetDetails>? columns;
  @JsonKey(name: 'data', includeIfNull: false)
  List<List<String>> data;

  WidgetDataResponse(
    this.columns,
    this.data,
  );

  static WidgetDataResponse fromJson(Map<String, dynamic> data) => _$WidgetDataResponseFromJson(data);

  Map<String, dynamic> toJson() => _$WidgetDataResponseToJson(this);
}

@JsonSerializable()
class WidgetDetails {
  @JsonKey(name: 'key', includeIfNull: false)
  String? key;

  @JsonKey(name: 'name', includeIfNull: false)
  String? name;

  @JsonKey(name: 'type', includeIfNull: false)
  String? type;

  @JsonKey(name: 'priority', includeIfNull: false)
  int? priority;

  @JsonKey(name: 'isHidden', includeIfNull: false)
  bool? isHidden;

  @JsonKey(name: 'action', includeIfNull: false)
  Object? action;

  @JsonKey(name: 'widget', includeIfNull: false)
  Object? widget;

  WidgetDetails(
    this.key,
    this.name,
    this.type,
    this.priority,
    this.isHidden,
    this.action,
    this.widget,
  );

  static WidgetDetails fromJson(Map<String, dynamic> data) => _$WidgetDetailsFromJson(data);

  Map<String, dynamic> toJson() => _$WidgetDetailsToJson(this);
}
