// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pre_dispatch_item_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PreDispatchItemResponse _$PreDispatchItemResponseFromJson(
        Map<String, dynamic> json) =>
    PreDispatchItemResponse(
      items: (json['dt'] as List<dynamic>?)
          ?.map((e) => e == null
              ? null
              : PreDispatchItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['tc'] as int?,
      success: json['success'] as bool?,
      status: json['s'] as bool?,
    );

Map<String, dynamic> _$PreDispatchItemResponseToJson(
        PreDispatchItemResponse instance) =>
    <String, dynamic>{
      'dt': instance.items,
      'tc': instance.totalCount,
      'success': instance.success,
      's': instance.status,
    };

PreDispatchItem _$PreDispatchItemFromJson(Map<String, dynamic> json) =>
    PreDispatchItem(
      id: json['id'] as int?,
      deviceId: json['did'] as int?,
      mpid: json['mpid'] as int?,
      qrCode: json['qr_code'] as String?,
      model: json['m'] as String?,
      brand: json['b'] as String?,
      imei: json['im'] as String?,
      status: json['s'] as int?,
      grade: json['gr'] as String?,
      productTitle: json['pt'] as String?,
      testAge: json['ta'] as int?,
      statusDescription: json['sd'] as String?,
    );

Map<String, dynamic> _$PreDispatchItemToJson(PreDispatchItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'did': instance.deviceId,
      'mpid': instance.mpid,
      'qr_code': instance.qrCode,
      'm': instance.model,
      'b': instance.brand,
      'im': instance.imei,
      's': instance.status,
      'gr': instance.grade,
      'pt': instance.productTitle,
      'ta': instance.testAge,
      'sd': instance.statusDescription,
    };
