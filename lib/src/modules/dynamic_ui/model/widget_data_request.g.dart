// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'widget_data_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WidgetDateRequest _$WidgetDateRequestFromJson(Map<String, dynamic> json) =>
    WidgetDateRequest(
      widgetKey: json['widget'] as String?,
      templateFilters: (json['templateFilters'] as List<dynamic>?)
          ?.map((e) => TemplateFilterList.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WidgetDateRequestToJson(WidgetDateRequest instance) =>
    <String, dynamic>{
      'widget': instance.widgetKey,
      'templateFilters': instance.templateFilters,
    };
