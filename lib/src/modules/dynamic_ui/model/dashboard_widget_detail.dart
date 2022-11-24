import 'package:components/components.dart';
import 'package:core_widgets/core_widgets.dart';import 'package:json_annotation/json_annotation.dart';

part 'dashboard_widget_detail.g.dart';

@JsonSerializable()
class DashboardWidgetDetailsResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'key')
  String? key;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'isActive')
  bool? isActive;

  @JsonKey(name: 'widgetList', includeIfNull: false)
  List<WidgetListResponse>? widgetList;

  DashboardWidgetDetailsResponse(CashifyAlert? cashifyAlert, String? trackUrl) : super(cashifyAlert,trackUrl);

  static DashboardWidgetDetailsResponse fromJson(Map<String, dynamic> data) =>
      _$DashboardWidgetDetailsResponseFromJson(data);

  @override
  Map<String, dynamic> toJson() => _$DashboardWidgetDetailsResponseToJson(this);

  // DashboardWidgetDetailsResponse(
  //   super.cashifyAlert,
  //   super.trackUrl,
  //   this.id,
  //   this.key,
  //   this.name,
  //   this.isActive,
  //   this.widgetList,
  // );
}

@JsonSerializable()
class WidgetListResponse extends BaseResponse {
  @JsonKey(name: 'id')
  int? id;

  @JsonKey(name: 'key')
  String? key;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'isHidden')
  bool? isHidden;

  @JsonKey(name: 'ui', includeIfNull: false)
  UIResponse? ui;

  @JsonKey(name: 'priority')
  int? priority;

  @JsonKey(name: 'templateFilterList', includeIfNull: false)
  List<TemplateFilterList>? templateFilterList;

  WidgetListResponse(CashifyAlert? cashifyAlert, String? trackUrl) : super(cashifyAlert,trackUrl);


  static WidgetListResponse fromJson(Map<String, dynamic> data) => _$WidgetListResponseFromJson(data);

  Map<String, dynamic> toJson() => _$WidgetListResponseToJson(this);

  // WidgetListResponse(super.cashifyAlert,super.trackUrl,this.id, this.key, this.name, this.isHidden, this.ui);
}

@JsonSerializable()
class UIResponse extends BaseResponse {
  @JsonKey(name: 'key')
  String? key;

  @JsonKey(name: 'name')
  String? name;

  @JsonKey(name: 'colSpan')
  int? colSpan;

  UIResponse(CashifyAlert? cashifyAlert, String? trackUrl) : super(cashifyAlert,trackUrl);


  //UIResponse(super.cashifyAlert,super.trackUrl,this.key, this.name, this.colSpan);

  static UIResponse fromJson(Map<String, dynamic> data) => _$UIResponseFromJson(data);

  Map<String, dynamic> toJson() => _$UIResponseToJson(this);
}

@JsonSerializable()
class TemplateFilterList {
  @JsonKey(name: 'key',includeIfNull: false)
  String? key;

  @JsonKey(name: 'name',includeIfNull: false)
  String? name;

  @JsonKey(name: 'type',includeIfNull: false)
  String? type;

  @JsonKey(name: 'isMandatory',includeIfNull: false)
  bool? isMandatory;

  @JsonKey(name: 'templateId',includeIfNull: false)
  int? templateId;


  TemplateFilterList(this.key, this.name, this.type, this.isMandatory, this.templateId) ;

  static TemplateFilterList fromJson(Map<String, dynamic> data) => _$TemplateFilterListFromJson(data);

  Map<String, dynamic> toJson() => _$TemplateFilterListToJson(this);

}
