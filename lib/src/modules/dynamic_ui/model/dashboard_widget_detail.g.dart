// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_widget_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DashboardWidgetDetailsResponse _$DashboardWidgetDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    DashboardWidgetDetailsResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..id = json['id'] as int?
      ..key = json['key'] as String?
      ..name = json['name'] as String?
      ..isActive = json['isActive'] as bool?
      ..widgetList = (json['widgetList'] as List<dynamic>?)
          ?.map((e) => WidgetListResponse.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$DashboardWidgetDetailsResponseToJson(
    DashboardWidgetDetailsResponse instance) {
  final val = <String, dynamic>{
    '__ca': instance.cashifyAlert,
    'turl': instance.trackUrl,
    'id': instance.id,
    'key': instance.key,
    'name': instance.name,
    'isActive': instance.isActive,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('widgetList', instance.widgetList);
  return val;
}

WidgetListResponse _$WidgetListResponseFromJson(Map<String, dynamic> json) =>
    WidgetListResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..id = json['id'] as int?
      ..key = json['key'] as String?
      ..name = json['name'] as String?
      ..isHidden = json['isHidden'] as bool?
      ..ui = json['ui'] == null
          ? null
          : UIResponse.fromJson(json['ui'] as Map<String, dynamic>)
      ..priority = json['priority'] as int?
      ..templateFilterList = (json['templateFilterList'] as List<dynamic>?)
          ?.map((e) => TemplateFilterList.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$WidgetListResponseToJson(WidgetListResponse instance) {
  final val = <String, dynamic>{
    '__ca': instance.cashifyAlert,
    'turl': instance.trackUrl,
    'id': instance.id,
    'key': instance.key,
    'name': instance.name,
    'isHidden': instance.isHidden,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('ui', instance.ui);
  val['priority'] = instance.priority;
  writeNotNull('templateFilterList', instance.templateFilterList);
  return val;
}

UIResponse _$UIResponseFromJson(Map<String, dynamic> json) => UIResponse(
      json['__ca'] == null
          ? null
          : CashifyAlert.fromJson(json['__ca'] as Map<String, dynamic>),
      json['turl'] as String?,
    )
      ..key = json['key'] as String?
      ..name = json['name'] as String?
      ..colSpan = json['colSpan'] as int?;

Map<String, dynamic> _$UIResponseToJson(UIResponse instance) =>
    <String, dynamic>{
      '__ca': instance.cashifyAlert,
      'turl': instance.trackUrl,
      'key': instance.key,
      'name': instance.name,
      'colSpan': instance.colSpan,
    };

TemplateFilterList _$TemplateFilterListFromJson(Map<String, dynamic> json) =>
    TemplateFilterList(
      json['key'] as String?,
      json['name'] as String?,
      json['type'] as String?,
      json['isMandatory'] as bool?,
      json['templateId'] as int?,
    );

Map<String, dynamic> _$TemplateFilterListToJson(TemplateFilterList instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('key', instance.key);
  writeNotNull('name', instance.name);
  writeNotNull('type', instance.type);
  writeNotNull('isMandatory', instance.isMandatory);
  writeNotNull('templateId', instance.templateId);
  return val;
}
