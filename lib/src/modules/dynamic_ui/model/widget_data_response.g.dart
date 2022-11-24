// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_data_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WidgetDataResponse _$WidgetDataResponseFromJson(Map<String, dynamic> json) =>
    WidgetDataResponse(
      (json['columns'] as List<dynamic>?)
          ?.map((e) => WidgetDetails.fromJson(e as Map<String, dynamic>))
          .toList(),
      (json['data'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as String).toList())
          .toList(),
    );

Map<String, dynamic> _$WidgetDataResponseToJson(WidgetDataResponse instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('columns', instance.columns);
  val['data'] = instance.data;
  return val;
}

WidgetDetails _$WidgetDetailsFromJson(Map<String, dynamic> json) =>
    WidgetDetails(
      json['key'] as String?,
      json['name'] as String?,
      json['type'] as String?,
      json['priority'] as int?,
      json['isHidden'] as bool?,
      json['action'],
      json['widget'],
    );

Map<String, dynamic> _$WidgetDetailsToJson(WidgetDetails instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('key', instance.key);
  writeNotNull('name', instance.name);
  writeNotNull('type', instance.type);
  writeNotNull('priority', instance.priority);
  writeNotNull('isHidden', instance.isHidden);
  writeNotNull('action', instance.action);
  writeNotNull('widget', instance.widget);
  return val;
}
